# words.awk
#	Print a list of all of the unique words in the file.  A word is 
#	defined as a sequence of characters delimited by white space, not
#	containing a \ (to skip TeX control sequences)

BEGIN { 
	FS=" "		# Fields delimited by a space
	nw=0		# Number of unique words
	tw=0		# Total number of words
	BLOCK = 5 	# Length for qsort
}

# Sort the subjects either in order of frequency, or in lexical order.
# This qsort program is part of Mike Brennan's MAWK distribution.

# qsort text files
#

function middle(x,y,z)  #return middle of 3
{
  if ( x <= y )  
  { if ( z >= y )  return y
    if ( z <  x )  return x
    return z
  }

  if ( z >= x )  return x
  if ( z <  y )  return y
  return z
}

function  isort(A , n,    i, j, hold)
{
  # if needed a sentinal at A[0] will be created

  for( i = 2 ; i <= n ; i++)
  {
    hold = A[ j = i ]
    while ( A[j-1] > hold )
    { j-- ; A[j+1] = A[j] }

    A[j] = hold
  }
}

# recursive quicksort
function  qsort(A, left, right    ,i , j, pivot, hold)
{
  
  pivot = middle(A[left], A[int((left+right)/2)], A[right])

  i = left
  j = right

  while ( i <= j )
  {
    while ( A[i] < pivot )  i++ 
    while ( A[j] > pivot )  j--

    if ( i <= j )
    { hold = A[i]
      A[i++] = A[j]
      A[j--] = hold
    }
  }

  if ( j - left > BLOCK )  qsort(A,left,j)
  if ( right - i > BLOCK )  qsort(A,i,right)
}

# End of the qsort program
#############################################################################

# Remove big bits of maths. This ignored things in $$.$$
/^\\begin{equation}/ {
        while ($0!~/\\end{equation}/) getline
	gsub(/^.*\\end{equation}/,"")
}

/\\begin{eqnarray}/ {
        while ($0!~/\\end{eqnarray}/) getline
	gsub(/^.*\\end{eqnarray}/,"")
}

/\\begin{eqnarray\*}/ {
        while ($0!~/\\end{eqnarray*}/) getline
	gsub(/^.*\\end{eqnarray*}/,"")
}

/\\begin{pspicture}/ {
        while ($0!~/\\end{pspicture}/) getline
	gsub(/^.*\\end{pspicture}/,"")
}

/\\begin{verbatim}/ {
        while ($0!~/\\end{verbatim}/) getline
	gsub(/^.*\\end{verbatim}/,"")
}


{ 	
	gsub(/\\epsffile\{(.)*\}/," ") 
	gsub(/\\input\{(.)*\}/," ") 
	gsub(/\\cite(\[(.)*\])?\{(.)*\}/," ") 
	gsub(/\\begin\{(.)*\}/," ") 
	gsub(/\\end\{(.)*\}/," ") 
	gsub(/\\label\{(.)*\}/," ")	# Ignore labels and cross-references
	gsub(/\\(page)?(ref)\{(.)*\}/," ")	
	gsub(/\\\\/," ")	# Remove \\ which may confuse things like \\\%
	gsub(/\\%/," ")		# A \% does not begin a comment
	gsub(/%(.)*/," ")	# Remove comments
	gsub(/\\/," \\")
	gsub(/[^a-zA-Z\\]/," ")
  	for (i=1;i<=NF;i++) { 
  		lc=tolower($i)
		tw++
		# Don't add plurals if the singular is there
		if (substr(lc,length(lc),1)=="s"&&substr(lc,1,length(lc)-1) in freq)
			lc=substr(lc,1,length(lc)-1)
		# Add word to word list
		if (substr(lc,1,1)!="\\" && length(lc)>1) {
			if (lc in freq)
				freq[lc]++
			else {
				nw++
# if (lc=="furtheremore") print FILENAME " \t" FNR " \t" lc
				freq[lc]=1
				words[nw]=lc
			}
		}
 	}
}

END {
	print "There are " nw " unique words out of a total of " tw ":"
	if ( nw > BLOCK )  qsort(words, 1, nw)
	isort(words,nw)
	for (i=1;i<=nw;i++) printf("%s\n",words[i])#freq[words[i]])

}
