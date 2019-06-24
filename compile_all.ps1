# Color
pdflatex "\input{logo.tex}" -job-name=logo
pdflatex "\input{logo.tex}" -job-name=logo
latex "\input{logo.tex}" -job-name=logo
dvips -E logo

# Black
pdflatex "\def\logowificolor{0} \input{logo.tex}" -job-name=logo-black
latex "\def\logowificolor{0} \input{logo.tex}" -job-name=logo-black
dvips -E logo-black

# Color NoText
pdflatex "\def\notextlogo{} \input{logo.tex}" -job-name=logo-notext
latex "\def\notextlogo{} \input{logo.tex}" -job-name=logo-notext
dvips -E logo-notext

# Black NoText
pdflatex "\def\logowificolor{0} \def\notextlogo{} \input{logo.tex}" -job-name=logo-black-notext
latex "\def\logowificolor{0} \def\notextlogo{} \input{logo.tex}" -job-name=logo-black-notext
dvips -E logo-black-notext


# Convert PDF -> png
magick -density 300 logo.pdf -quality 90 -resize 3840 logo-2160p.png
magick -density 300 logo.pdf -quality 90 -resize 1920 logo-1080p.png
magick -density 300 logo.pdf -quality 90 -resize 1280 logo-720p.png

magick -density 300 logo-black.pdf -quality 90 -resize 3840 logo-black-2160p.png
magick -density 300 logo-black.pdf -quality 90 -resize 1920 logo-black-1080p.png
magick -density 300 logo-black.pdf -quality 90 -resize 1280 logo-black-720p.png

magick -density 300 logo-notext.pdf -quality 90 -resize 3840 logo-notext-2160p.png
magick -density 300 logo-notext.pdf -quality 90 -resize 1920 logo-notext-1080p.png
magick -density 300 logo-notext.pdf -quality 90 -resize 1280 logo-notext-720p.png

magick -density 300 logo-black-notext.pdf -quality 90 -resize 3840 logo-black-notext-2160p.png
magick -density 300 logo-black-notext.pdf -quality 90 -resize 1920 logo-black-notext-1080p.png
magick -density 300 logo-black-notext.pdf -quality 90 -resize 1280 logo-black-notext-720p.png


# Export GIFs (frame by frame, and combine)
pdflatex -jobname=logo-tmp-0 "\def\logowificolor{0} \input{logo.tex}"
pdflatex -jobname=logo-tmp-1 "\def\logowificolor{1} \input{logo.tex}"
pdflatex -jobname=logo-tmp-2 "\def\logowificolor{2} \input{logo.tex}"
pdflatex -jobname=logo-tmp-3 "\def\logowificolor{3} \input{logo.tex}"
magick -verbose -delay 50 -loop 0 -density 300 logo-tmp-*.pdf -alpha remove logo.gif

# NoText
pdflatex -jobname=logo-tmp-nt-0 "\def\logowificolor{0} \def\notextlogo{} \input{logo.tex}"
pdflatex -jobname=logo-tmp-nt-1 "\def\logowificolor{1} \def\notextlogo{} \input{logo.tex}"
pdflatex -jobname=logo-tmp-nt-2 "\def\logowificolor{2} \def\notextlogo{} \input{logo.tex}"
pdflatex -jobname=logo-tmp-nt-3 "\def\logowificolor{3} \def\notextlogo{} \input{logo.tex}"
magick -verbose -delay 50 -loop 0 -density 300 logo-tmp-nt-*.pdf -alpha remove logo-notext.gif


# Clean up all unusable outputs
del *.aux
del *.log
del *.dvi
del logo-tmp-*
