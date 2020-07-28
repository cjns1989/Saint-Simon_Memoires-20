# Generate PDFs & epub from pandoc markdown
#
# Prerequisites:
#
# - GNU make
# - sed
# - pandoc
# - latex/xelatex
# - pdftk
# - imagemagick
# - img2pdf
# - EBGaramond font
#
TITLE			:=	'Mémoires_XX'
AUTHOR			:=	'Saint-Simon'
TITLE_UNDERSCORE	:=	$(shell echo $(TITLE) | tr  ' ' '_')
AUTHOR_UNDERSCORE 	:=	$(shell echo $(AUTHOR) | tr ' ' '_')

LATEX_LANG    		:= 	fr
LATEX_FONT    		:= 	EBGaramond-Regular

PT08			:= 	08pt
PT09			:= 	09pt
PT10			:= 	10pt
PT11			:= 	11pt
PT12			:= 	12pt
PT14			:= 	14pt

MDSOURCE		:=	md/title.txt md/ch*

EPUB_DIR		:=	epub
LATEX_DIR		:=	latex
PDF_DIR			:=	pdf
HTML_DIR		:=	html

PANDOC_EPUB_OPTIONS	:=	--epub-cover-image=images/cover.png 	      				       	     \
				--css=css/stylesheet.css		      				       	     \
				--epub-metadata=xml/metadata.xml	      				       	     \
				--epub-embed-font=fonts/*
 
PANDOC_LATEX_OPTIONS	:=	--pdf-engine=xelatex			       				     \
				--variable mainfont='$(LATEX_FONT)'					     \
				--variable 'documentclass=extbook'					     \
				--variable 'geometry:papersize={4.80 in, 6.40  in},left=.5 in,right=.5 in'   \
				--variable 'lang=$(LATEX_LANG)'						     \
				--variable 'indent'						       	      
 
PANDOC_HTML_OPTIONS	:=      --css=css/stylesheet.css                                                              \
				--toc
 
PANDOC_VP08		:=	--variable fontsize=8pt
PANDOC_VP08		:=	--variable 'fontsize=8pt'
PANDOC_VP09		:=	--variable 'fontsize=9pt'
PANDOC_VP10		:=	--variable 'fontsize=10pt'
PANDOC_VP11		:=	--variable 'fontsize=11pt'
PANDOC_VP12		:=	--variable 'fontsize=12pt'
PANDOC_VP14		:=	--variable 'fontsize=14pt'
 
all:	latex08 latex09 latex10 latex11 latex12 latex14 pdf08 pdf09 pdf10 pdf11 pdf12 pdf14  pdfc zip zipc epub html
 
allpdf: latex08 latex09 latex10 latex11 latex12 latex14 pdf08 pdf09 pdf10 pdf11 pdf12 pdf14 pdfc
 
pdf:    latex08 latex09 latex10 latex11 latex12 latex14 pdf08 pdf09 pdf10 pdf11 pdf12 pdf14
 
.PHONY:	pdfc
pdfc: pdf
	convert images/cover.png -fuzz 25% -fill 'rgb(16,90,20)' -opaque 'rgb(166,30,20)' images/cover.jpg
	img2pdf --output images/cover.pdf --pagesize 4.8inx6.4in --auto-orient images/cover.jpg
	for file in $$(ls pdf); do						\
		pdftk images/cover.pdf pdf/$$file cat output pdfc/$$file;	\
		done                                                             
 
.PHONY:	zip
zip:
	mkdir 	-p /tmp/wzip/$(AUTHOR_UNDERSCORE)/$(TITLE_UNDERSCORE)
	cp    	pdf/* /tmp/wzip/$(AUTHOR_UNDERSCORE)/$(TITLE_UNDERSCORE)
	cd    	/tmp/wzip/ ; zip -r $(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE).zip $(AUTHOR_UNDERSCORE)/$(TITLE_UNDERSCORE)/*
	rm   	/tmp/wzip/$(AUTHOR_UNDERSCORE)/$(TITLE_UNDERSCORE)/*
	rmdir   /tmp/wzip/$(AUTHOR_UNDERSCORE)/$(TITLE_UNDERSCORE)
	rmdir   /tmp/wzip/$(AUTHOR_UNDERSCORE)
	mv	/tmp/wzip/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE).zip zip
	rmdir   /tmp/wzip
 
.PHONY:	zipc
zipc:
	mkdir 	-p /tmp/wzip/$(AUTHOR_UNDERSCORE)/$(TITLE_UNDERSCORE)
	cp    	pdf/* /tmp/wzip/$(AUTHOR_UNDERSCORE)/$(TITLE_UNDERSCORE)
	cd    	/tmp/wzip/ ; zip -r $(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE).zip $(AUTHOR_UNDERSCORE)/$(TITLE_UNDERSCORE)/*
	rm   	/tmp/wzip/$(AUTHOR_UNDERSCORE)/$(TITLE_UNDERSCORE)/*
	rmdir   /tmp/wzip/$(AUTHOR_UNDERSCORE)/$(TITLE_UNDERSCORE)
	rmdir   /tmp/wzip/$(AUTHOR_UNDERSCORE)
	mv	/tmp/wzip/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE).zip zipc
	rmdir   /tmp/wzip
 
pdf08:	latex08
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT08).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT08).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT08).tex
	- rm -f $(PDF_DIR)/*.aux $(PDF_DIR)/*.log $(PDF_DIR)/*.out
 
pdf09: latex09
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT09).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT09).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT09).tex
	- rm -f $(PDF_DIR)/*.aux $(PDF_DIR)/*.log $(PDF_DIR)/*.out
 
pdf10:	latex10
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT10).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT10).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT10).tex
	- rm -f $(PDF_DIR)/*.aux $(PDF_DIR)/*.log $(PDF_DIR)/*.out
 
pdf11:	latex11
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT11).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT11).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT11).tex
	- rm -f $(PDF_DIR)/*.aux $(PDF_DIR)/*.log $(PDF_DIR)/*.out
 
pdf12:	latex12
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT12).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT12).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT12).tex
	- rm -f $(PDF_DIR)/*.aux $(PDF_DIR)/*.log $(PDF_DIR)/*.out
 
pdf14:	latex14
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT14).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT14).tex
	xelatex -output-directory=$(PDF_DIR) $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT14).tex
	- rm -f $(PDF_DIR)/*.aux $(PDF_DIR)/*.log $(PDF_DIR)/*.out
 
latex08: md/title.txt md/*.md
	pandoc -s $(MDSOURCE) $(PANDOC_LATEX_OPTIONS) $(PANDOC_VP08) -o $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT08).tex
 
latex09: md/title.txt md/*.md
	pandoc -s $(MDSOURCE) $(PANDOC_LATEX_OPTIONS) $(PANDOC_VP09) -o $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT09).tex
 
latex10: md/title.txt md/*.md
	pandoc -s $(MDSOURCE) $(PANDOC_LATEX_OPTIONS) $(PANDOC_VP10) -o $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT10).tex
 
latex11: md/title.txt md/*.md
	pandoc -s $(MDSOURCE) $(PANDOC_LATEX_OPTIONS) $(PANDOC_VP11) -o $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT11).tex
 
latex12: md/title.txt md/*.md
	pandoc -s $(MDSOURCE) $(PANDOC_LATEX_OPTIONS) $(PANDOC_VP12) -o $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT12).tex
 
latex14: md/title.txt md/*.md
	pandoc -s $(MDSOURCE) $(PANDOC_LATEX_OPTIONS) $(PANDOC_VP14) -o $(LATEX_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE)-$(PT14).tex
 
.PHONY:	epub
epub:
	find md -type f -exec sed -i 's/<!---/   /g' {} \;
	find md -type f -exec sed -i 's/-->/   /g' {} \;
	pandoc $(MDSOURCE) $(PANDOC_EPUB_OPTIONS) -o $(EPUB_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE).epub
	find md -type f -exec sed -i 's/   /<!---/g' {} \;
	find md -type f -exec sed -i 's/   /-->/g' {} \;
	epubcheck $(EPUB_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE).epub
 
.PHONY:	html
html:
	find md -type f -exec sed -i 's/<!---/   /g' {} \;
	find md -type f -exec sed -i 's/-->/   /g' {} \;
	pandoc -s $(MDSOURCE) ${PANDOC_HTML_OPTIONS} -o $(HTML_DIR)/$(AUTHOR_UNDERSCORE)-$(TITLE_UNDERSCORE).html
	find md -type f -exec sed -i 's/   /<!---/g' {} \;
	find md -type f -exec sed -i 's/   /-->/g' {} \;
 
clean: md/*
	- rm -f latex/*
	- rm -f pdf/*
	- rm -f pdfc/*
	- rm -f zip/*
	- rm -f zipc/*
	- rm -f epub/*
	- rm -f html/*
