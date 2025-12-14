#!/usr/bin/env bash


#############################################
# Parse input and set output directory
#############################################
INPUTPDF="$1"
OUTDIR="$2"
if [ -z "$INPUTPDF" ]; then
	echo "Usage: $0 <input.pdf> [output_dir]"
	exit 1
fi
BASENAME="$(basename "$INPUTPDF" .pdf)"
if [ -z "$OUTDIR" ]; then
	OUTDIR="$BASENAME"
fi
TEMPLATEDIR="$OUTDIR"
mkdir -p "$TEMPLATEDIR"

IMGDIR="$OUTDIR/images"
TEXTFILE="$OUTDIR/text.txt"
TEMPLATEDIR="$OUTDIR/template"
mkdir -p "$IMGDIR" "$TEMPLATEDIR"


#############################################
# Extract images
#############################################
echo "Extracting images..."
pdfimages -png "$INPUTPDF" "$IMGDIR/img"

#############################################
# Extract text
#############################################
echo "Extracting text..."
pdftotext "$INPUTPDF" "$TEXTFILE"

#############################################
# Create Beamer template prototype
#############################################
cat > "$TEMPLATEDIR/template.sty" <<'EOF'
% Prototype Beamer Template Style


\ProvidesPackage{template}


% Title page setup
\setbeamertemplate{title page}{
\begin{centering}
{\usebeamerfont{title} \usebeamercolor[fg]{title} \inserttitle}\par
\vspace{1cm}
{\usebeamerfont{subtitle} \insertsubtitle}\par
\vspace{1cm}
{\usebeamerfont{author} \insertauthor}\par
\vfill
{\usebeamerfont{date} \insertdate}
\end{centering}
}


% Thank‑you page
\newcommand{\thankyoupage}{
\begin{frame}
\centering
{\Huge Thank You!}
\end{frame}
}


% Two‑column slide prototype
\newenvironment{twocolframe}[2]{
\begin{frame}{#1}
\begin{columns}[T]
\column{0.48\textwidth}
#2
\column{0.48\textwidth}
}{
\end{columns}
\end{frame}
}


EOF


#############################################
# Scaffold example main.tex
#############################################
cat > "$TEMPLATEDIR/main.tex" <<'EOF'
\documentclass{beamer}
\usepackage{template}


\title{Example Title}
\author{Your Name}
\date{\\today}


\begin{document}


\begin{frame}
\titlepage
\end{frame}


\begin{twocolframe}{Two Columns Example}{
Left content here.
}
Right content here.
\end{twocolframe}


\thankyoupage


\end{document}
EOF


#############################################
# Done
#############################################
echo "Done. Output directory: $OUTDIR"
