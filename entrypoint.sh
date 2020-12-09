#!/bin/sh -e

cd /lnbits
python3 -m venv venv
./venv/bin/hypercorn -k trio --bind 0.0.0.0:${PORT} 'lnbits.app:create_app()'