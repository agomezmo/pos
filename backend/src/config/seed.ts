import fs from 'fs';
import path from 'path';
import pool from './database';

async function seed(type: 'pharmacy' | 'hardware') {
  const client = await pool.connect();
  try {
    const seedFile = type === 'pharmacy'
      ? '../../../database/seed_pharmacy.sql'
      : '../../../database/seed_hardware.sql';

    const seedPath = path.join(__dirname, seedFile);

    if (!fs.existsSync(seedPath)) {
      console.log(`No seed file found for ${type}. Skipping.`);
      return;
    }

    const seedSql = fs.readFileSync(seedPath, 'utf-8');
    console.log(`Seeding ${type} data...`);
    await client.query(seedSql);
    console.log(`${type} data seeded successfully.`);
  } catch (error) {
    console.error(`Seed failed for ${type}:`, error);
    throw error;
  } finally {
    client.release();
    await pool.end();
  }
}

const type = (process.argv[2] as 'pharmacy' | 'hardware') || 'pharmacy';
seed(type).catch(() => process.exit(1));
