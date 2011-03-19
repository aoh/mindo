
[ the regex syntax is a bit different from the posix one.
  you write things like "c(a+d)*r + foo" ]

def read-non-null-line input as 
	(read-line input loop)
	where rec loop input line is
		(if (nil? line)
			(read-line input loop)
			(bi input line))

def rec prompter auto input as
	(print-string "> "
		def input line from (read-line input)
			(print-line (append "Read: " line)
				(print-line 
					(append "Verdict: "
						(if (dfa-match? auto line) "Match" "No match"))
							(prompter auto input))))

fn input is
	(print-string "Give regular expression: "
		def input regex from (read-line input)
		def auto as (regex->dfa regex)
		(print-line (append "read: " regex)
		(print-line "Compiles to DFA: "
			(fa-print auto
				(print-line "Type in text to match against the automata."
					(prompter auto input))))))


end

