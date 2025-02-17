# PhD Thesis

This is my PhD thesis "Motion Estimation for Inverse Synthetic Aperture Radar Imaging", submitted on January 9 1995. 

I was at the University of Melbourne, Australia, where my supervisor for the first year was Prof. Terry Caelli in the Cognitive Science Lab at the Department of Computer Science.
He took up an appointment elsewhere so I moved to the Department of Electrical and Electronic Engineering, where I was supervised by Prof. Rob Evans.
My research was supported by the Australian Defence Science and Technology Organisation (DSTO), where my manager was Dr David Heilbronn, head of the Microwave Radar Division.

This initial commit is my first successful attempt at regenerating the PDF in nearly 30 years. 
This involved porting my old LaTex2.09 style files to modern LaTex, updating archaic PSTricks code, and finally generating PDFs using `xelatex`.

## Creating the PDF

With all the dependencies installed (details to be added, including PSTricks and CMU fonts), generate the PDF with:

```bash
xelatex t.tex
bibtext t.aux
xelatex t.tex
xelatex t.tex # to get the references right
mv t.pdf thesis.pdf
```
# phd-thesis-radar-imaging
My PhD thesis "Motion Estimation for Inverse Synthetic Aperture Radar Imaging" (University of Melbourne, 1995)