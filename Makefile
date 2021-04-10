CSV2 = test/csv2
EXAMPLES =\
	examples/layout.svg\
	examples/trig.svg\
	examples/trig-2plots.svg\
	examples/trig-points.svg\
	examples/trig-80-120.svg
OPTFILES = $(wildcard data/*.opts)
SVGFILES = $(OPTFILES:data/%.opts=generated/%.svg)
TXTFILES = $(OPTFILES:data/%.opts=generated/%.txt)

.PHONY:	all error.expected examples

all:	generated/.made generated/index.html

generated/.made:
	-mkdir $(@D)
	@ touch $@

generated/index.html: EXTRAS = generated/logo.svg test.svg indexMake.sh $(EXAMPLES)
generated/index.html: $(SVGFILES) $(TXTFILES) $(EXTRAS)
	@ ./indexMake.sh $@

generated/%.svg: OPTS = $(shell cat $(@F:%.svg=data/%.opts))
generated/%.svg: data/%.csv data/%.json data/%.opts $(CSV2)
	-@ $(CSV2) svg $(OPTS) $(@F:%.svg=data/%.csv) $(@F:%.svg=data/%.json) $@

generated/%.txt: data/%.txt data/br.inc data/%.opts
	@ cat $^ > $@

generated/trig+trig-inc.svg: data/trig.inc

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
	-@ $(CSV2) svg --nocomment --cssid=svg-ex1 data/trig.csv examples/trig.json $@

examples/trig-80-120.svg: data/trig.csv examples/trig.json $(CSV2)
	-@ $(CSV2) svg --nocomment --cssid=svg-ex2 --xmin=80 --xmax=120 data/trig.csv examples/trig.json $@

examples/trig-2plots.svg: data/trig.csv examples/trig.json $(CSV2)
	-@ $(CSV2) svg --nocomment --cssid=svg-ex3 --include=40 data/trig.csv examples/trig.json $@

examples/trig-points.svg: data/trig.csv examples/trig.json $(CSV2)
	-@ $(CSV2) svg --nocomment --cssid=svg-ex4 --showpoints=8 --scattered=16 data/trig.csv examples/trig.json $@

examples/layout.svg: data/trig.csv examples/layout.json examples/layout.inc
	-@ $(CSV2) svg data/trig.csv examples/layout.json $@

