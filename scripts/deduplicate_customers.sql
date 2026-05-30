-- Deduplicate customers: merge duplicates with same fullname
-- Strategy: keep the record with most complete data, merge contacts, update all references, delete extras

DO $$
DECLARE
  dup RECORD;
  keep_id INT;
  del_id INT;
  ids_arr INT[];
  ref_count INT;
BEGIN
  FOR dup IN (
    SELECT fullname,
      array_agg(id ORDER BY
        CASE WHEN email IS NOT NULL AND email != '' AND phone IS NOT NULL AND phone != '' THEN 4
             WHEN email IS NOT NULL AND email != '' THEN 3
             WHEN phone IS NOT NULL AND phone != '' THEN 2
             ELSE 1 END DESC, id
      ) as ids_ordered
    FROM customers
    WHERE fullname IN (SELECT fullname FROM customers GROUP BY fullname HAVING count(*) > 1)
    GROUP BY fullname
  )
  LOOP
    -- First id in the ordered array is the keeper
    keep_id := dup.ids_ordered[1];
    RAISE NOTICE 'Keeping id=% for fullname=%', keep_id, dup.fullname;

    -- Process each duplicate
    FOR i IN 2 .. array_length(dup.ids_ordered, 1) LOOP
      del_id := dup.ids_ordered[i];

      -- 1. Update promo_campaign_customers references
      UPDATE promo_campaign_customers
      SET customer_id = keep_id
      WHERE customer_id = del_id
        AND NOT EXISTS (
          SELECT 1 FROM promo_campaign_customers
          WHERE campaign_id = promo_campaign_customers.campaign_id
            AND customer_id = keep_id
        );
      DELETE FROM promo_campaign_customers WHERE customer_id = del_id;

      -- 2. Update promo_campaign_log references
      UPDATE promo_campaign_log
      SET customer_id = keep_id
      WHERE customer_id = del_id;

      -- 3. Merge email if keeper doesn't have one
      UPDATE customers
      SET email = (SELECT email FROM customers WHERE id = del_id AND email IS NOT NULL AND email != '')
      WHERE id = keep_id
        AND (email IS NULL OR email = '')
        AND EXISTS (SELECT 1 FROM customers WHERE id = del_id AND email IS NOT NULL AND email != '');

      -- 4. Merge phone if keeper doesn't have one
      UPDATE customers
      SET phone = (SELECT phone FROM customers WHERE id = del_id AND phone IS NOT NULL AND phone != '')
      WHERE id = keep_id
        AND (phone IS NULL OR phone = '')
        AND EXISTS (SELECT 1 FROM customers WHERE id = del_id AND phone IS NOT NULL AND phone != '');

      -- 5. Delete the duplicate
      DELETE FROM customers WHERE id = del_id;
      RAISE NOTICE '  Deleted duplicate id=%', del_id;
    END LOOP;
  END LOOP;
END $$;

-- Verification
SELECT '=== VERIFICATION ===' as info;
SELECT fullname, count(*) as cnt FROM customers
GROUP BY fullname HAVING count(*) > 1;

SELECT 'Total customers after dedup:' as info, count(*) FROM customers;
