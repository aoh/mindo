

def Y a as (X X)
	where X b is (a (b b))

def bi a b as 
	fn c in (c a b)

def t a b as a
def f a b as b

def rule as \a \b \c
	(a (b (c f t) (c t t)) (b (c t t) (c f f)))

def next as \a
	(Y \elf \a \b
		(b t t
			(bi (bi f (rule a (b t f) f)) (bi (bi t f) \x x)) 
			(bi (bi f (rule a (b t f) (b f t f)))
				(elf (b t f) (b f))))
		f a)

def spc e as 
	(bi f (bi f (bi f (bi f
	(bi f (bi t (bi f (bi f e))))))))

def cell e as 
	(bi f (bi t (bi f (bi t
	(bi f (bi t (bi f (bi f e))))))))

def nl e as 
	(bi f (bi t (bi f (bi t
	(bi f (bi f (bi f (bi f e))))))))

\in
(Y \elf \a
	(Y \op \b
		(b t t 
			(nl
				(elf (next a)))
			(b t f cell spc (op (b f))))
		a)
	(bi (bi t t) \x x))

end

