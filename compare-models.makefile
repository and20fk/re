# compare-models.makefile
# USAGE
# make -file compare-models.makefile depend
# make -file compare-models.makefile all
#

OUTPUT=../data/v6/output
TRANSACTIONS=$(OUTPUT)/transactions-subset1.csv.gz
AN01=$(OUTPUT)/compare-models-an-01.pdf
CV01=$(OUTPUT)/compare-models-cv-01.rsave
CV02=$(OUTPUT)/compare-models-cv-02.rsave
TARGETS=$(AN01) $(CV01) $(CV02)

SOURCES=$(wildcard *.R)

$(warning TARGETS is $(TARGETS))
$(warning SOURCES is $(SOURCES))

include dependencies-in-R-sources.generated

.PHONY: all
all: $(AN01) $(CV01) dependencies-in-R-sources.makefile

.PHONY: AN01
AN01: $(AN01)

.PHONY: CV01
CVO1: $(CV01)

.PHONY: CV02
CV02: $(CV02)

# analyses
$(AN01): compare-models.R CompareModelsAn01.R $(TRANSACTIONS)
	Rscript compare-models.R --what an --choice 01


# experiments
$(CV01): compare-models.R CompareModelsCv01.R $(TRANSACTIONS) 
	Rscript compare-models.R --what cv --choice 01

$(CV02): compare-models.R CompareModelsCv02.R $(TRANSACTIONS) 
	Rscript compare-models.R --what cv --choice 02

# dependencies
.PHONY: depend
depend: 
	echo REMAKING dependencies
	Rscript make-dependencies.R --filename dependencies-in-R-sources.generated


#
# Output info about each rule and why it was executed
# ref: drdobbs.com/toools/debugging-makefiles/199703338?pgno=3
#OLD_SHELL := $(SHELL)
#SHELL := ($warning [$@ ($^) ($?)] $(OLD_SHELL)
