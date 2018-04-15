$recorder = 1;
$pdf_mode = 1;        # tex -> pdf
$pdf_previewer = 'open -a Skim  %O %S';
$bibtex_use = 2;
$pdflatex = 'xelatex -synctex=1 -interaction=nonstopmode -shell-escape  %O %S';
@generated_exts = (@generated_exts, 'synctex.gz');
$clean_ext = 'synctex.gz synctex.gz(busy) run.xml tex.bak bbl bcf fdb_latexmk run tdo %R-blx.bib';
print("Config file located at $HOME/.latexmkrc\n");


