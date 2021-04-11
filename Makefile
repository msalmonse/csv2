CSV2 = test/csv2
CANVASFILES = $(shell find data -name \*.canvas -size +0)
CANVASTAGFILES = $(CANVASFILES:data/%.canvas=generated/%.canvastag)
EXAMPLES =\
	examples/layout.svg\
	examples/trig.svg\
	examples/trig-2plots.svg\
	examples/trig-points.svg\
	examples/trig-80-120.svg
JSFILES = $(CANVASFILES:data/%.canvas=generated/%.js)
OPTFILES = $(wildcard data/*.opts)
SVGFILES = $(OPTFILES:data/%.opts=generated/%.svg)
TXTFILES = $(OPTFILES:data/%.opts=generated/%.txt)

.PHONY:	all error.expected examples

all:	generated/.made generated/svgindex.html generated/jsindex.html

generated/.made:
	-mkdir $(@D)
	@ touch $@

generated/svgindex.html: EXTRAS = generated/logo.svg out.svg svgIndexMake.sh $(EXAMPLES)
generated/svgindex.html: $(SVGFILES) $(TXTFILES) $(EXTRAS)
	@ ./svgIndexMake.sh $@

generated/jsindex.html: EXTRAS = generated/logo.svg out.js jsIndexMake.sh
generated/jsindex.html: $(JSFILES) $(CANVASTAGFILES) $(TXTFILES) $(EXTRAS)
	@ ./jsIndexMake.sh $@

generated/%.js: OPTS = $(shell cat $(@F:%.js=data/%.opts))
generated/%.js: CANVAS = $(shell cat $(@F:%.js=data/%.canvas))
generated/%.js: data/%.csv data/%.json data/%.opts generated/%.canvastag $(CSV2)
	-@ $(CSV2) js --canvas $(CANVAS) $(OPTS) $(@F:%.js=data/%.csv) $(@F:%.js=data/%.json) $@

generated/%.canvastag: OPTS = $(shell cat $(@F:%.canvastag=data/%.opts))
generated/%.canvastag: CANVAS = $(shell cat $(@F:%.canvastag=data/%.canvas))
generated/%.canvastag: data/%.csv data/%.json data/%.opts data/%.canvas $(CSV2)
	-@ $(CSV2) js --canvas $(CANVAS) --canvastag $(OPTS) - $(@F:%.js=data/%.json) $@

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

out.svg out.js:
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

