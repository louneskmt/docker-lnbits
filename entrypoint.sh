#!/bin/sh -e

cd /lnbits
./venv/bin/quart assets
./venv/bin/quart migrate
./venv/bin/hypercorn -k trio --bind 0.0.0.0:${PORT} 'lnbits.app:create_app()'