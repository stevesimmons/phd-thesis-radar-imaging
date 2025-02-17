/^\%/ { print; $0="" }

NF==8 { 
	for (i=1;i<9;i++) {
		n=int(256*$i/0.50);
		if (n>255) n=255;
		if (n<0) n=0;
		printf("%2x",n);
	}
	printf("\n");
	$0=""
}
		
