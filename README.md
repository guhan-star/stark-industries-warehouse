# Stark Industries Warehouse

Local-first, single-operator electronics inventory control application generated from the supplied master prompt.

## Run

Open `stark_industries_warehouse.html` directly in a modern browser. All records are persisted in browser `localStorage` under `stark-warehouse-v1`. XLSX export uses SheetJS when the browser can reach the CDN; CSV export works offline.

The application intentionally has no reorder-point fields, low-stock alerts, reorder metrics, or standalone audit-trail screen. Borrowed stock contributes zero to owned valuation; lent stock reduces availability. Dropdown values are isolated and normalized before insertion. Spreadsheet exports neutralize formula-like user strings.

## Included surfaces

- Local mode is available without an account, login, role, or user-management layer.
- Optional multi-user cloud mode with Supabase email/password accounts. Each user receives an isolated inventory and dropdown dataset through row-level security, and can open the same account on any phone, tablet, laptop, or PC.
- Dark and light themes with a persistent header toggle; the dark industrial theme is the default.
- Unified search/filter/sort inventory workspace with custody, ownership, valuation and nine-level storage display.
- Component create/edit/delete controls are intentionally limited to Component ID, Component name, quantity number/unit, price per unit, total value, type, Borrowed From, Lent To, Date Lent, Note, and Current Status.
- Ownership/status fields are conditional: selecting `Borrowed` reveals a required `Borrowed from` name field; selecting `Lent Out` reveals required `Lent to` and `Date lent` fields. If either option is changed, the hidden name/date fields are cleared and are not saved.
- Dropdown-backed fields offer a `Custom…` option. A custom value is normalized, saved into that same field’s dropdown, and available on every later component.
- CSV and XLSX staging import with flexible header matching, duplicate ID skipping, review-before-commit behavior, and exports containing the reduced field set.
- `sqlite_schema.sql` and `supabase_postgres_schema.sql` for a persistence upgrade path.

## Multi-device setup

The HTML file works locally without configuration. To enable separate accounts and cross-device synchronization:

1. Create a Supabase project.
2. Run `supabase_postgres_schema.sql` in the Supabase SQL editor.
3. In `stark_industries_warehouse.html`, set `SUPABASE_URL` to the project URL and `SUPABASE_ANON_KEY` to the project's public anon key. Never put a service-role key in the HTML file.
4. Open the HTML file from a web host or local server on each device. Create an account or sign in; inventory and dropdown options are private to that account.

Supabase email confirmation settings may require confirming the account email before the first sign-in. Local mode remains available when the two configuration constants are blank.
