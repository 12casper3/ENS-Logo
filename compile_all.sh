#!/bin/bash

# Order of exporting:
# Color
# Black
# Color NoText
# Black NoText

# Compile PDFs
pdflatex -jobname=logo "\input{logo.tex}"
pdflatex -jobname=logo-black "\def\logowificolor{0} \input{logo.tex}"
pdflatex -jobname=logo-notext "\def\notextlogo{} \input{logo.tex}"
pdflatex -jobname=logo-black-notext "\def\logowificolor{0} \def\notextlogo{} \input{logo.tex}"


# Export dvi -> eps
latex -jobname=logo "\input{logo.tex}" && dvips -E logo &
latex -jobname=logo-black "\def\logowificolor{0} \input{logo.tex}" && dvips -E logo-black &
latex -jobname=logo-notext "\def\notextlogo{} \input{logo.tex}" && dvips -E logo-notext &
latex -jobname=logo-black-notext "\def\logowificolor{0} \def\notextlogo{} \input{logo.tex}" && dvips -E logo-black-notext &


# Convert PDF -> png
declare -a files=("logo" "logo-black" "logo-notext" "logo-black-notext" )

declare -a widths=("3840" "1920" "1280")
declare -a heigths=("2160p" "1080p" "720p")

arraylength=${#widths[@]}

for (( i=0; i<${arraylength}; i++ ));
do
    echo $i " / " ${arraylength} " : " ${heigths[$i]}" =" ${widths[$i]}
    for f in "${files[@]}"
    do
        echo "$f"
        convert -density 300 $f.pdf -quality 90 -resize ${widths[$i]} ${f}-${heigths[$i]}.png &
    done
done


# Export GIFs (frame by frame, and combine)
pdflatex -jobname=logo-tmp-0 "\def\logowificolor{0} \input{logo.tex}"
pdflatex -jobname=logo-tmp-1 "\def\logowificolor{1} \input{logo.tex}"
pdflatex -jobname=logo-tmp-2 "\def\logowificolor{2} \input{logo.tex}"
pdflatex -jobname=logo-tmp-3 "\def\logowificolor{3} \input{logo.tex}"
convert -verbose -delay 50 -loop 0 -density 300 -alpha remove logo-tmp-*.pdf logo.gif &

# NoText
pdflatex -jobname=logo-tmp-nt-0 "\def\logowificolor{0} \def\notextlogo{} \input{logo.tex}"
pdflatex -jobname=logo-tmp-nt-1 "\def\logowificolor{1} \def\notextlogo{} \input{logo.tex}"
pdflatex -jobname=logo-tmp-nt-2 "\def\logowificolor{2} \def\notextlogo{} \input{logo.tex}"
pdflatex -jobname=logo-tmp-nt-3 "\def\logowificolor{3} \def\notextlogo{} \input{logo.tex}"
convert -verbose -delay 50 -loop 0 -density 300 -alpha remove logo-tmp-nt-*.pdf logo-notext.gif &


# Wait & Clean up all unusable outputs
echo "Waiting to finish"
wait
rm -f *.aux
rm -f *.log
rm -f *.dvi
rm -f logo-tmp-*
echo "Clean up finished"
