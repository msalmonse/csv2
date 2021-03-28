CSV2SVG = test/csv2svg
OPTFILES = $(wildcard data/*.opts)
SVGFILES = $(OPTFILES:data/%.opts=generated/%.svg)
TXTFILES = $(OPTFILES:data/%.opts=generated/%.txt)

.PHONY:	all error.expected

all:	generated/.made generated/index.html

generated/.made:
	-mkdir $(@D)
	@ touch $@

generated/index.html: $(SVGFILES) $(TXTFILES) test.svg indexMake.sh
	./indexMake.sh $@

generated/%.svg: OPTS = $(shell cat $(@F:%.svg=data/%.opts))
generated/%.svg: data/%.csv data/%.json data/%.opts $(CSV2SVG)
	-@ $(CSV2SVG) $(OPTS) $(@F:%.svg=data/%.csv) $(@F:%.svg=data/%.json) $@

generated/%.txt: data/%.txt
	@ cp $< $@

generated/z+none-1.svg: error.expected

error.expected:
	@ tput 1>&2 smso
	@ echo 1>&2 Error loading data expected!
	@ tput 1>&2 rmso

test.svg:
	touch $@
