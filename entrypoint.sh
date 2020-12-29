#!/bin/sh -e

cd /lnbits
./venv/bin/quart assets
./venv/bin/quart migrate
./venv/bin/hypercorn -k trio --bind ${HOST}:${PORT} 'lnbits.app:create_app()'
