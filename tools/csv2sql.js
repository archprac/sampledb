#!/usr/bin/env node

import fs from 'node:fs';
import path from 'node:path';
import util from 'node:util';
import * as csvparse from 'csv-parse/sync';

const tables = [
    "calendar",
    "products",
    "menus",
    "menu_products",
    "orders",
    "order_menus",
    "order_deliveres",
    "seats",
    "addresses",
    "customers",
    "customer_addresses",
    "customer_reserves",
    "customer_visits",
    "gates",
    "rolls",
    "staffs",
    "staff_rolls",
    "staff_accesses",
    "shifts",
];

const { positionals } = util.parseArgs({allowPositionals: true});


function csvCaster(value, context) {
    if (value === '') {
        if (!context.quoting) {
            return null
        }
    } else {
        if (!context.quoting) {
            let num = Number(value)
            if (!Number.isNaN(num)) {
                return num
            }
        }
    }
    return value;
}


console.info("START TRANSACTION;");
console.info();

for (let table of tables.toReversed()) {
    console.info(util.format("DELETE FROM restodb.%s;", table));
}

for (let table of tables) {
    let filepath = path.join("data", table + ".csv");
    if (!fs.existsSync(filepath)) continue;

    let csvString = fs.readFileSync(filepath, 'utf-8');
    let records = csvparse.parse(csvString, {
        columns: false,
        bom: true,
        skip_empty_lines: true,
        cast: csvCaster,
    });
    if (0 < records.length) {
        let head = records.shift();
        if (0 < records.length) {
            console.info(util.format("INSERT INTO restodb.%s", path.parse(filepath).name));
            console.info(util.format("  (%s)", head.join(",")));
            console.info("VALUES");
            console.info(records.map(r => util.format("  (%s)", r.map(c => {
                return typeof c == "string" ? `'${c.trim()}'` : c == null ? "NULL" : String(c)
            }).join(","))).join(",\n"));
            console.info(";");
            console.info();
        }
    }
}

console.info("COMMIT;");
console.info();
