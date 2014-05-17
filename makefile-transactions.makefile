# Makefile
# create OUTPUT/transactions-subset1.csv and its predecessors

OUTPUT=../data/v6/output

CENSUS=$(OUTPUT)/census.csv
DEEDS=$(OUTPUT)/deeds-al.csv
PARCELS=$(OUTPUT)/parcels-sfr.csv
TRANSACTIONS=$(OUTPUT)/transactions-al-sfr.csv
SUBSET1=$(OUTPUT)/transactions-subset1.csv
 
# These rules come from
# https://github.com/yihui/knitr/blob/master/inst/doc/Makefile

%.pdf: %.Rnw
	RScript -e "if (getRversion() < '3.0.0') knitr::knit2pdf('$*.Rnw') else tools::texi2pdf('$*.tex')"

%.html: %.Rmd
	Rscript -e "if (getRversion() < '3.0.0') knitr::knit2html('$*.Rmd')"

.PHONY: all
all: $(CENSUS) $(DEEDS) $(PARCELS) $(SUBSET1) $(TRANSACTIONS)

$(CENSUS): census.R
	Rscript census.R

$(DEEDS): deeds-al.R
	Rscript deeds-al.R

$(PARCELS): parcels-sfr.R
	Rscript parcels-sfr.R

$(SUBSET1): transactions-subset1.R $(TRANSACTIONS)
	Rscript transactions-subset1.R

$(TRANSACTIONS): transactions-al-sfr.R $(CENSUS) $(DEEDS) $(PARCELS)
	Rscript transactions-al-sfr.R