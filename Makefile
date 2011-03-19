everything: test

# a simple (old) combinator graph reducer
sen: sen.c
	gcc -O2 -o sen sen.c

# recompile the.. amm.. compiler. swim compiles syntactically sugared lambda calculus to combinatory logic, which can be executed with sen.
swim.ce: sen app/swim.s
   # this may take a few minutes
	cat swim.ce app/swim.s | ./sen -H 64 > swim.new
	cp mv swim.ce swim.old
	mv swim.new swim.ce

# compile the regular expression test program
app/reg.ce: sen
	cat swim.ce app/stdlib.s app/reg.s | ./sen -H 64 > app/reg.ce
	# syntax c(a+d)*r

# compile cellular automata test program
app/cell.ce: sen app/cell.s
	cat swim.ce app/cell.s | ./sen > app/cell.ce

app/primes.ce: sen app/primes.s
	cat swim.ce app/primes.s | ./sen > app/primes.ce

test: sen app/cell.ce
	cat app/cell.ce | ./sen | head -n 30 | grep -q "*** * ** ****** *** **  *****"
	# now you can for example $ cat swim.ce app/primes.s | ./sen | ./sen
   # make swim.ce recompiles the bytecode-compiler-ish LC2CL translator

