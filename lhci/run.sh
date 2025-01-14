#!/bin/sh

set -e

rm -f /data/lhci.db

# Restore the database file
litestream restore -if-replica-exists /data/lhci.db

# Replicate the database file and start the LHCI server
litestream replicate -exec "pnpm start"