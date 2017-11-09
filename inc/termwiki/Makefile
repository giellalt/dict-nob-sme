XFST = xfst #-utf8

term.fst: term.lexc
	@echo
	@echo
	printf "read lexc term.lexc \n\
	invert net \n\
	save term.fst \n\
	quit \n" > f-fst-script
	$(XFST) < f-fst-script
	rm -f f-fst-script

clean:
        @rm -f term.fst