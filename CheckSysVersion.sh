cat ~/Machine/MachVersion/CurrVersion | \
 mawk '{if($1 != ENVIRON["CONFIG_VERSION"])print "**WARNING - CONFIG_VERSION is " ENVIRON["CONFIG_VERSION"] "  CurrVersion is " $1;;}'
