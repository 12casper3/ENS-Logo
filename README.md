[Download Logo](https://github.com/12casper3/ENS-Logo/releases/latest)
===============
[Here](https://github.com/12casper3/ENS-Logo/releases/latest)


Exported logos
==============

For easy use, the different versions of the logo are released in different file formats.
The possible combinations are:
* Color - Black
* Text - NoText
* *.pdf, *.eps, *.png
* Small, Medium and Large resolutions.

A vector version (*.tikz, *.pdf, *.eps) of the logo should be used where possible.

Installation & Dependencies
===========================
Compiling the logo requires LaTeX.

ImageMagick is used to convert the pdfs to other formats.

Ubuntu
------

```sudo apt install texlive-latex-extra```

```./compile_all.sh```

Potential problems with ImageMagick exporting GIFs:
https://stackoverflow.com/questions/42928765/convertnot-authorized-aaaa-error-constitute-c-readimage-453

Windows
-------
Install MiKTeX or TeX Live

Install ImageMagick

```.\compile_all.ps1```
