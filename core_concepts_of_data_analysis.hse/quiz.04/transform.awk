#!/usr/bin/awk -f

# # #
# transform q1_data.orig into the format readable by octave
#

BEGIN {
	ids["F"] = 1
	ids["E"] = 2
	ids["H"] = 3
	ids["X"] = 4
}

match($0, /^([FEHX])/, mdata) {
	gsub(/  +/, " ")
	print ids[mdata[1]], substr($0,2)
}
