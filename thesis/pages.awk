# Select certain pages from DVIPS output file.
# Use a command line of the form
#    awk -f pages.awk in.ps > out.ps

BEGIN {
	starting = "%%Page: 160"
	stopping = "%%Page: 210"
	state = 0
}

NF==3 && $1=="%%Page:" {
	if ($2>=23)
		state = 1
	else
		state = 0
}

state==0 { print }
