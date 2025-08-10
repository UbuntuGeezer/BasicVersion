#!/bin/bash
# 4/9/25.	wmk.	path correction to Machine/MachVersion folder.
# 2025-04-09   wmk.   (automated) Accounting path fixes (Lenovo).
cat ~/Machine/MachVersion/CurrVersion | \
 mawk '{if($1 != ENVIRON["CONFIG_VERSION"])print "**WARNING - CONFIG_VERSION is " ENVIRON["CONFIG_VERSION"] "  CurrVersion is " $1;;}'
