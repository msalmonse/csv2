CSV2SVG = test/csv2svg
OPTFILES = $(wildcard testdata/*.opts)
SVGFILES = $(OPTFILES:testdata/%.opts=generated/%.svg)
TXTFILES = $(OPTFILES:testdata/%.opts=generated/%.txt)

.PHONY:	all

all:	generated/.made generated/index.html

generated/.made:
	mkdir $(@D)
	@touch $@

generated/index.html: $(SVGFILES) $(TXTFILES) indexMake.sh
	./indexMake.sh $@

generated/%.svg: OPTS = $(shell cat $(@F:%.svg=testdata/%.opts))
generated/%.svg: testdata/%.csv testdata/%.json testdata/%.opts $(CSV2SVG)
	-@$(CSV2SVG) $(OPTS) $(@F:%.svg=testdata/%.csv) $(@F:%.svg=testdata/%.json) $@

generated/%.txt: testdata/%.txt
	@ cp $< $@
