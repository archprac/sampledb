#!/usr/bin/env node

import fs from 'node:fs';
import path from 'node:path';
import util from 'node:util';
import * as csvparse from 'csv-parse/sync';

console.info("START TRANSACTION;");
console.info();

const { positionals } = util.parseArgs({allowPositionals: true});
for (let filepath of positionals) {
    //console.error(filepath);
    let csvString = fs.readFileSync(filepath, 'utf-8');
    let records = csvparse.parse(csvString, {
        columns: false,
        bom: true,
        skip_empty_lines: true,
    });
    if (0 < records.length) {
        let head = records.shift();
        if (0 < records.length) {
            console.info(util.format("DELETE FROM restodb.%s;", path.parse(filepath).name));
            console.info();
            console.info(util.format("INSERT INTO restodb.%s", path.parse(filepath).name));
            console.info(util.format("  (%s)", head.join(",")));
            console.info("VALUES");
            console.info(records.map(r => util.format("  (%s)", r.map(c => `'${c.trim()}'`).join(","))).join(",\n"));
            console.info(";");
            console.info();
        }
    }
}

console.info("COMMIT;");
console.info();
