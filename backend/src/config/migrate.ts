import fs from 'fs';
import path from 'path';
import pool from './database';

async function migrate() {
  const client = await pool.connect();
  try {
    const schemaPath = path.join(__dirname, '../../../database/schema.sql');
    const schema = fs.readFileSync(schemaPath, 'utf-8');

    console.log('Running schema migration...');
    await client.query(schema);
    console.log('Schema migration completed successfully.');
  } catch (error) {
    console.error('Migration failed:', error);
    throw error;
  } finally {
    client.release();
    await pool.end();
  }
}

migrate().catch(() => process.exit(1));
