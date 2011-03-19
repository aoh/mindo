def W as \a (a a)
def Y as \a (W \b (a (b b)))
def I as \a a

def bi as \a \b \c (c a b)
def t as \a \b a
def f as \a \b b

def $ as (bi t I)
def 0 as (bi f $)
def 1 as (bi f 0)
def 9 as (bi f (bi f (bi f (bi f (bi f (bi f (bi f (bi f 1))))))))

def null as (bi $ $)

def eq as
	(Y \elf \a \b
		(a t (b t)
			(b t f
				(elf (a f) (b f)))))

def ++ as
	(Y \elf \a
		(eq (a t) $ (bi 1 null)
			(eq (a t) 9 (bi 0 (elf (a f)))
				(bi (bi f (a t)) (a f)))))  

def = as
	(Y \elf \a \b
		(eq (a t) $ (eq (b t) $)
			(eq (b t) $ f
				(eq (a t) (b t) 
					(elf (a f) (b f)) 
					f))))

def @nl as \a (bi f (bi t (bi f (bi t (bi f (bi f (bi f (bi f a))))))))
def @sp as \a (bi f (bi f (bi f (bi f (bi f (bi t (bi f (bi f a))))))))
def @0 as \a (bi f (bi f (bi f (bi f (bi t (bi t (bi f (bi f a))))))))
def @1 as \a (bi t (bi f (bi f (bi f (bi t (bi t (bi f (bi f a))))))))
def @2 as \a (bi f (bi t (bi f (bi f (bi t (bi t (bi f (bi f a))))))))
def @3 as \a (bi t (bi t (bi f (bi f (bi t (bi t (bi f (bi f a))))))))
def @4 as \a (bi f (bi f (bi t (bi f (bi t (bi t (bi f (bi f a))))))))
def @5 as \a (bi t (bi f (bi t (bi f (bi t (bi t (bi f (bi f a))))))))
def @6 as \a (bi f (bi t (bi t (bi f (bi t (bi t (bi f (bi f a))))))))
def @7 as \a (bi t (bi t (bi t (bi f (bi t (bi t (bi f (bi f a))))))))
def @8 as \a (bi f (bi f (bi f (bi t (bi t (bi t (bi f (bi f a))))))))
def @9 as \a (bi t (bi f (bi f (bi t (bi t (bi t (bi f (bi f a))))))))

def nums as 
	(bi @0 (bi @1 (bi @2 (bi @3 (bi @4 (bi @5 
	(bi @6 (bi @7 (bi @8 (bi @9 I))))))))))

def emit-numeral as \a \n
	(Y \elf \a \b
		(a t (b t n)
			(elf (a f) (b f)))
		(a f) nums)

def emit as 
	(Y \elf \a \b
		(eq (a t) $ b
			(elf (a f) (emit-numeral (a t) b))))

def n1 as (bi 1 null)

def push as \a \b
	(Y \elf \b \c \d
		(b t t
			(d 
				(bi t (bi (bi f (bi n1 a)) c)) 
				(bi f c))
			(= (b t f t) (b t f f)
				(elf 
					(b f)
					(bi (bi f (bi n1 (b t f f))) c)
					f)
				(elf 
					(b f)
					(bi (bi f 
						(bi (++ (b t f t)) 
							(b t f f))) c)
					d)))
		b null t)
			
\in
(Y \elf \a \b
	(\c (c t
		(emit a (@sp (elf (++ a) (c f)))) 
			(elf (++ a) (c f)))
		(push a b))
	(++ n1)
	null)

compile/combinator

