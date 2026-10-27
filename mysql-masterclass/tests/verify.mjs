import { readFile } from 'node:fs/promises';
import { createRequire } from 'node:module';
import assert from 'node:assert/strict';
const require = createRequire(new URL('../../backend/package.json', import.meta.url));
const mysql = require('mysql2/promise');
const fixtures = JSON.parse(await readFile(new URL('./expected.json', import.meta.url), 'utf8'));
const db = await mysql.createConnection({ host:process.env.DB_HOST??'127.0.0.1',port:Number(process.env.DB_PORT??3306),user:process.env.DB_USER??'root',password:process.env.DB_PASSWORD,database:process.env.DB_NAME??'masterclass',decimalNumbers:true });
try {
 for (const fixture of fixtures) {
  const sql = await readFile(new URL(`../solutions/${String(fixture.id).padStart(2, '0')}.sql`, import.meta.url), 'utf8');
  const [rows] = await db.query(sql);
  assert.deepEqual(rows.map(row=>({...row})),fixture.expected,`Latihan SQL ${fixture.id} berbeda`);
 }
 console.log(`${fixtures.length} expected result cocok pada MySQL nyata.`);
} finally {await db.end();}
