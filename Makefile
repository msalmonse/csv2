CSV2SVG = test/csv2svg
EXAMPLES =\
	examples/trig.svg\
	examples/trig-2plots.svg\
	examples/trig-points.svg\
	examples/trig-80-120.svg
OPTFILES = $(wildcard data/*.opts)
SVGFILES = $(OPTFILES:data/%.opts=generated/%.svg)
TXTFILES = $(OPTFILES:data/%.opts=generated/%.txt)

.PHONY:	all error.expected examples

all:	generated/.made generated/index.html examples

generated/.made:
	-mkdir $(@D)
	@ touch $@

generated/index.html: $(SVGFILES) $(TXTFILES) generated/logo.svg test.svg indexMake.sh
	./indexMake.sh $@

generated/%.svg: OPTS = $(shell cat $(@F:%.svg=data/%.opts))
generated/%.svg: data/%.csv data/%.json data/%.opts $(CSV2SVG)
	-@ $(CSV2SVG) $(OPTS) $(@F:%.svg=data/%.csv) $(@F:%.svg=data/%.json) $@

generated/%.txt: data/%.txt data/br.inc data/%.opts
	@ cat $^ > $@

generated/z+none-1.svg: error.expected

generated/logo.svg: data/logo.svg
	@ cp $< $@

error.expected:
	@ tput 1>&2 smso
	@ echo 1>&2 Error loading data expected!
	@ tput 1>&2 rmso

test.svg:
	touch $@

examples: $(EXAMPLES)

examples/trig.svg: data/trig.csv examples/trig.json
	-@ $(CSV2SVG) data/trig.csv examples/trig.json $@

examples/trig-80-120.svg: data/trig.csv examples/trig.json $(CSV2SVG)
	-@ $(CSV2SVG) --xmin=80 --xmax=120 data/trig.csv examples/trig.json $@

examples/trig-2plots.svg: data/trig.csv examples/trig.json $(CSV2SVG)
	-@ $(CSV2SVG) --include=40 data/trig.csv examples/trig.json $@

examples/trig-points.svg: data/trig.csv examples/trig.json $(CSV2SVG)
	-@ $(CSV2SVG) --showpoints=8 --scattered=16 data/trig.csv examples/trig.json $@
