def W as \a (a a)
def Y as \a (W \b (a (b b)))
def I as \a a

def bi as \a \b \c (c a b)
def t as \a \b a
def f as \a \b b

def newline as \a (bi f (bi t (bi f (bi t (bi f (bi f (bi f (bi f a))))))))
def print-0 as \a (bi f (bi f (bi f (bi f (bi t (bi t (bi f (bi f a))))))))
def print-1 as \a (bi t (bi f (bi f (bi f (bi t (bi t (bi f (bi f a))))))))

def 0 as \f \x x
def 1 as \f \x (f x)
def 2 as \f \x (f (f x))
def 3 as \f \x (f (f (f x)))
def 4 as \f \x (f (f (f (f x))))

def + as \a \b
	\f \x (a f (b f x))

def * as \a \b
	(a \c (+ c b) 0)

def 0? as \a 
	(a \b f t)

def -- as \a
	\f \x
		(a \b \c (c (b f))
			\a x
			I)

def ++ as \a
	\f \x (a f (f x))

def square as
	(* 2)

def print-church as \x \c
	(x print-1 (print-0 (newline c)))

def plus as
	(+ 1)

def neg as
	\a (-- a)

\input
	(print-church 
		(1 plus 2)
		input)


compile/combinator

