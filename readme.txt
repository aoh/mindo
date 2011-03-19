Mindo -- Use and abuse of lambda calculus.
Written by Aki Helin in 2003, revised later.
No rights reserved.



OVERVIEW

This directory contains an interpreter, a sort of bytecode compiler
and some example applications for a toy programming language called
Mindo. It is a lazy typeless purely functional language. More precisely
it is an implementation of lambda calculus. 

Lambda calculus (LC) is a simple formal system that can be used to
reason about computation. LC contains only variables, applications
and abstraction, which is used to create an anonymous function of
one variable. Data structures, recursion and other things one needs
to perform some computation must to be built from these primitive
building blocks.

Mindo programs are lambda expressions, modulo some syntactic sugar.
Each program is first translated to a lambda expression, which is 
then compiled to a combinator expression. 

Mindo consists of a combinator graph reducer (sen) which is written 
in C, and a bytecode compiler written in Mindo itself. A Mindo program
is a map from one input bit stream to an output bit stream. Bit order 
is such that the identity function works as the UNIX 'cat' utility.
Sen works by first reading a combinator expression from standard input.
It then begins evaluating the expression and applies it to a node 
representing input to the program. If the value (output) of the program 
depends on the input, more standard input is read and is encoded as 
the input lambda expression. As the program is evaluated, the weak 
head normal form is used to take output bits from the program. Evaluation 
terminates when an EOF is read, or an error occurs.

More or less information may be available at:
   
    http://213.139.166.37/home/aki/mindo



FILES

   sen.c   -- source code for sen
	swim.ce -- bytecode compiler (in bytecode) 
	swim.s  -- bytecode compiler (mindo source) 
   app/    -- some example applications in usual and compiled form



INSTALLATION

The language can be used for example as follows:

   1. Extract the package.

      shell$ tar -zxvf Mindo.tar.gz

   2. Go to the directory.

      shell$ cd mindo

   3. Compile sen.

      shell$ cc -O3 -o sen src/sen.c

   4. Try it out.

      shell$ cat app/primes.ce | ./sen

      Control-c stops.

Programs can be compiled to combinator expressions with swim. It is in 
swim.ce file, and sources are in app/swim.s It can be used by giving 
it and the program to compile to sen. For example to compile the cellular
automata example program, issue

   shell$ cat swim.ce app/cell.s | ./sen > app/cell.ce

to save the compiled form, or just interpret it directly with 
   
   shell$ cat swim.ce app/cell.s | ./sen | ./sen

Compiling larger programs takes a while. Swim can be recompiled with 

   shell$ cat swim.ce app/swim.s | ./sen -H 32 > new-swim.ce

and the regular expression example by including the library

   shell$ cat swim.ce app/stdlib.s app/reg.s | ./sen -H 32 > app/reg.ce

The -H switch can be used to set the amount of memory sen can use. Giving 
more memory generally results in faster operation. Compiling reg.ce takes
a few minutes. It can be run with:

   shell$ cat app/reg.ce - | ./sen
   Give regular expression: c(a+d)*r 
   read: c(a+d)*r
   Compiles to DFA: 
   Finite Automata {
   States: ( 0 1 2 3 )
      Alphabet: ( c a d r )
      Transitions:  (3 r 0) (3 d 3) (3 a 3) (3 c 1) (2 r 1) (2 d 1) 
      (2 a 1) (2 c 3) (1 r 1) (1 d 1) (1 a 1) (1 c 1) (0 r 1) (0 d 1) 
      (0 a 1) (0 c 1)
      Start state: 2
      End state(s): ( 0 )
   }

   Type in text to match against the automata.
   > caddar
   Read: caddar
   Verdict: Match
   > car
   Read: car
   Verdict: Match
   > cheddar
   Read: cheddar
   Verdict: No match
   >^D
   shell$

The -V switch gives some garbage collection statistics.


SYNTAX

Swim accepts a fairly standard representation of lambda expressions and
also some extended syntax. Lambda is represented as \, and application is
written by placing the operator and one or more arguments in parenthesis.
The dot and implicit parenthesis are not used. 

Below is a chart of the syntax allowed by swim. 

   +-----------------------------+------------------------------+        
   | Mindo                       | Lambda calculus              |        
   +-----------------------------+------------------------------+        
   | def name as                 | (\name <rest>                |        
   |    <definition>             |    <definition>)             |        
   | <rest>                      |                              |        
   +-----------------------------+------------------------------+        
   | def fname var* as           | (\fname \var* <rest>         |        
   |    <definition>             |    <definition>)             |        
   | <rest>                      |                              |        
   +-----------------------------+------------------------------+        
   | fn var* in                  | \var* <definition>           |        
   |    <definition>             |                              |        
   +-----------------------------+------------------------------+        
   | def rec fname var* as       | (\fname <rest>               |        
   |    <definition>             |    (Y \fname \var*           |        
   | <rest>                      |       <definition))          |
   +-----------------------------+------------------------------+
   | def var* from               | (\var* <rest> <producer>)    |
   |    <producer>               |                              |
   | <rest>                      |                              |
   +-----------------------------+------------------------------+
   | <expression>                | (\name1                      |
   |    where name1 is <def1>    |    (\name2                   |
   |    and name2 is <def2>      |       <expression>           |
   |                             |     <def2>)                  |
   |                             |  <def1>)                     |
   +-----------------------------+------------------------------+



SEN

Sen uses a fairly standard set of combinators. The letter 'a' is used
to mark an application. It is left as a exercise to figure out how.

Let 1, 2, 3 and 4 and a be arbitrary expressions.

   (i 1)       = 1
   (y 1)       = (1 (y 1))
   (k 1 2)     = 1
   (w 1 2)     = (1 2 2)
   (t 1 2)     = (1 (1 2))
   (c 1 2 3)   = (1 3 2)
   (b 1 2 3)   = (1 (2 3))
   (s 1 2 3)   = (1 3 (2 3))
   (n 1 2 3 4) = (1 (2 4) 3)
   (l 1 2 3 4) = (1 (2 (3 4)))
   (m 1 2 3 4) = (1 (2 4) (3 4))


