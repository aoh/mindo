
[ See what I mean -- a mindo syntax to lambda calculus to combinator expression compiler 
  on 1/2004 by aki helin into public domain ]


[ Usual primitives. ]

def Y a as (X X)
   where X b is (a (b b))

def I a as a

def bi a b c as (c a b)
def t a b as a
def f a b as b

def tri a b c as 
   fn d in (d a b c)

def 1t a b c as a
def 2t a as t 
def 3t a as f

def if a as a



[ Input handling with hexes. ]

def mkhex a b c d e f as 
   (e d (e c (e b (e a f))))

def 0x0 as (mkhex f f f f)
def 0x1 as (mkhex f f f t)
def 0x2 as (mkhex f f t f)
def 0x3 as (mkhex f f t t)
def 0x4 as (mkhex f t f f)
def 0x5 as (mkhex f t f t)
def 0x6 as (mkhex f t t f)
def 0x7 as (mkhex f t t t)
def 0x8 as (mkhex t f f f)
def 0x9 as (mkhex t f f t)
def 0xA as (mkhex t f t f)
def 0xB as (mkhex t f t t)
def 0xC as (mkhex t t f f)
def 0xD as (mkhex t t f t)
def 0xE as (mkhex t t t f)
def 0xF as (mkhex t t t t)

def join-bvec b a as
   fn j f in (a j (b j f))

def hex-eq? as
   def tester b2 r2 b1 r1 as
      ((b1 b2 (b2 f t))
         (r1 r2)
         f)
   fn h1 h2 in
      (h1 bi I
         (h2 tester t))

def mkchar as join-bvec 

def print-char v cont as
   (v bi cont)

def read-hex str as
   def 1 str from str
   def 2 str from str
   def 3 str from str
   def 4 str from str
      (bi str 
         (mkhex 4 3 2 1))

def read-char str as
   def str h1 from (read-hex str) 
   def str h2 from (read-hex str) 
      (bi str
         (join-bvec h2 h1))

def char-eq? as hex-eq?


[ Logic and lists. ]

def not a as (a f t)
def or a b as (a t b)
def and a b as (a b f)
def same-bit? a b as (a b (not b))

def cons as (tri f)
def car a as (a 2t)
def cdr a as (a 3t)
def nil? a as (a 1t)
def nil c as t

def caar a as (car (car a))
def cadr a as (car (cdr a))
def cdar a as (cdr (car a))
def cddr a as (cdr (cdr a))

def enlist a as 
   (cons a nil)

def lrec a g f l as
   (loop l)
   where rec loop x is
      ((nil? x) a
         (g (f (car x))
            (loop (cdr x))))

def append a b as 
   (lrec b cons I a)

def reverse l as 
   (loop nil l)
   where rec loop a b is
      ((nil? b) a
         (loop 
            (cons (car b) a) 
            (cdr b)))

def rec list-eq? op l1 l2 as
   (loop l1 l2)
   where rec loop l1 l2 is
      (if (nil? l1) 
         (nil? l2)
         (if (nil? l2) f
            (if (op (car l1) (car l2))
               (loop (cdr l1) (cdr l2))
               f)))

def ab a b as a

def if as I 

def rec cond a as
   (a I fn a in (a loop (ab cond)))
   where rec loop a b is
      (b (ab a)
         (ab (ab (loop a))))
       
def switch a as 
   def rec do b as
      (b I fn b in (b a skip (ab do)))
      where rec skip b c is
         (c (ab b) (ab (ab (skip b))))
   do

def case a a as a
def else a b as a

def do as f
def end as t

def string as
   def 0x0? as (hex-eq? 0x0) 
   (collect nil)
   where rec collect buffer h1 h2 is
      (if (and (0x0? h1) (0x0? h2))
         (reverse buffer)
         (collect
            (cons
               (mkchar h1 h2)
               buffer)))

def rec string->bits a as
   (if (nil? a) 
      nil
      (car a cons
         (string->bits (cdr a))))

def member? = a S as
   (lrec f or (= a) S)



[ Math in binary. ]

def 0 as (cons f nil)
def 1 as (cons t nil)

def rec ++ a as
   ((nil? a) 1  
      ((car a)
         (cons f (++ (cdr a)))
         (cons t (cdr a)))) 
def = as 
   (list-eq? same-bit?)

def 10 as (++ 1)
def 11 as (++ 10)
def 100 as (++ 11)
def 101 as (++ 100)
def 110 as (++ 101)
def 111 as (++ 110)

def -- a as 
   (if (nil? (cdr a)) 0
      (-- a))
   where rec -- a is
      (if (nil? a) a
         (if (car a) 
            (if (nil? (cdr a)) 
               (cdr a)
               (cons f (cdr a)))
            (cons t (-- (cdr a)))))



[ dict : str -> dict x binary 

   tokenizer could be just (map string->bits tape), but this way
   they become much smaller and compilation to combinators (which 
   takes most of the time) becomes cheaper. ]

def dict as 
   def rat-query T id nid as
      (do id T)
      where rec do k T is
         def L R b? v from T
         (if (nil? k)
            (if b? 
               (bi v T)
               (bi nid \c (c L R t nid)))
            (car k
               def k L from 
                  (do (cdr k) L)
                  (bi k \c (c L R b? v))
               def k R from 
                  (do (cdr k) R)
                  (bi k \c (c L R b? v))))
   def rec N c as (c N N f f)
   def rec make nid tree str is
      def id tree from 
         (rat-query tree (string->bits str) nid)
         (bi (make (= nid id ++ I nid) tree) id)
   (make 1 N)
   

def blank-char? special-char? from 
   (bi blank? special?)
   where special-chars is "\()"
      and blank-chars is "    
"
      and tester lst is fn x in (member? char-eq? x lst)
      and blank? is (tester blank-chars)
      and special? is (tester special-chars)


[ lexer : char-list -> string-list ]

def lexer str as
   (lexer nil str)
   where rec lexer buff str is
      (switch (car str)
         case blank-char? 
            (flush buff 
               (lexer nil (cdr str)))
         case special-char?
            (flush buff
               (cons
                  (enlist (car str))
                  (lexer nil (cdr str))))
         else
            (lexer 
               (cons (car str) buff)
               (cdr str)))
      where flush buff cont is
         (if (nil? buff) I
            (cons (reverse buff))
            cont)


[ Save primitive things to dictionary and store their tokens. ]

def dict tok-lam from (dict "\")
def dict tok-lp from (dict "(")
def dict tok-rp from (dict ")")
def dict tok-fn from (dict "fn")
def dict tok-is from (dict "is")
def dict tok-def from (dict "def")
def dict tok-where from (dict "where")
def dict tok-from from (dict "from")
def dict tok-rec from (dict "rec")
def dict tok-and from (dict "and")
def dict tok-as from (dict "as")
def dict tok-in from (dict "in")


[ Primitive combinators. 
   Hack warning: these cannot occur in lexer output, so they
   are distinct from any valid tokens. ]

def dict tok-s from (dict " s")
def dict tok-k from (dict " k")
def dict tok-i from (dict " i")
def dict tok-b from (dict " b")
def dict tok-c from (dict " c")
def dict tok-w from (dict " w")
def dict tok-y from (dict " y")
def dict tok-t from (dict " t")
def dict tok-b* from (dict " bx")
def dict tok-c* from (dict " cx")
def dict tok-s* from (dict " sx")

def exp-delimiter? as
   def delimiters as 
      (cons tok-in (cons tok-as (cons tok-is (cons tok-from nil))))
   fn x in (member? = x delimiters)


[ tokenizer: string-list -> token-list 
   Note that this could be simply (map string->bits).
   Dictionary is only used to make sure tokens are small
   numbers, which makes rest of compilation cheaper. ]

def rec tokenizer str as
   (maker dict str)
   where rec maker dict str is
      def dict token from 
         (dict (car str))
      (cons token 
         (maker dict (cdr str)))


[ Expression ADT ]

def type/var as 1t
def type/lam as 2t
def type/app as 3t

def type exp as (exp 1t)

def mk-var bin as (tri type/var f bin)
def var->value a as (a 3t)

def mk-lam var body as (tri type/lam var body)
def lam->variable a as (a 2t)
def lam->body a as (a 3t)

def mk-app rator rand as (tri type/app rator rand)
def app->rator a as (a 2t)
def app->rand a as (a 3t)

def var? exp as (type exp t f f)
def lam? exp as (type exp f t f)
def app? exp as (type exp f f t)

[ Primitive combinators' expressions ]

def cS  as (mk-var tok-s)
def cK  as (mk-var tok-k)
def cI  as (mk-var tok-i)
def cB  as (mk-var tok-b)
def cC  as (mk-var tok-c)
def cW  as (mk-var tok-w)
def cY  as (mk-var tok-y)
def cT  as (mk-var tok-t)
def cB* as (mk-var tok-b*)
def cC* as (mk-var tok-c*)
def cS* as (mk-var tok-s*)

[ curry "(a b ... n)" "exp" -> "\a \... \n exp" ]

def rec curry vars exp as
   (if (nil? vars) exp
      (mk-lam
         (mk-var (car vars))
         (curry (cdr vars) exp)))


[ Wraps a binding around 1 or 2 expressions. ]

def rec wrap vars delim exp cont? cont as 
   (cond
      case (= tok-from delim)
         (mk-app exp
            (curry vars cont))
      case (nil? (cdr vars))
         (mk-app
            (mk-lam
               (mk-var (car vars))
               cont)
            exp)
      case (= tok-rec (car vars))
         def body as 
            (mk-app cY
               (curry (cdr vars) exp))
         (if cont?
            (mk-app
               (mk-lam 
                  (mk-var (cadr vars))
                  cont)
               body)
            body)
      case (= tok-fn (car vars))
         (if cont? 
            (wrap (cdr vars) delim exp cont? cont)
            (curry (cdr vars) exp))
      else
         (mk-app
            (mk-lam    
               (mk-var (car vars))
               cont)
            (curry (cdr vars) exp)))

[ parse : tape -> ok?, exp, tape
  Parser consists of 3 mutually recursive functions.
  We only bind parse-exp. 
  Note, there could be a primitive syntax for mutual recursion... ]

def parse tape as 
   (parser 3t tape)
   where rec parser op is
      (op
         fn tape in
            (reader nil tape)
            where rec reader vars tape is
               (cond
                  case (nil? tape) 
                     \c f
                  case (exp-delimiter? (car tape))
                     def ok? body rest from (parse-exp (cdr tape))
                        \c (c t (reverse vars) (car tape) body rest)
                  else
                     (reader 
                        (cons (car tape) vars)
                        (cdr tape)))
         fn trip in 
            def ok? exp tape from trip
            (if ok?
               (loop exp tape tok-where)
               where rec loop exp tape want is
                  (cond
                     case (nil? tape) 
                        fail
                     case (= want (car tape))
                        def ok? vars delim value tape 
                           from (read-binding (cdr tape))
                        def ok? cont tape 
                           from (loop exp tape tok-and)
                        (ok
                           (wrap vars delim value t cont)
                           tape)
                     else
                        (ok exp tape))
               trip)
         fn tape in
            (if (nil? tape) fail
               (include-where-clauses
                  (switch (car tape)
                     case (= tok-lam)
                        def ok1? var tape from (parse-exp (cdr tape))
                        def ok2? body tape from (parse-exp tape)
                        (if (and ok1? ok2?)
                           (ok (mk-lam var body) tape)
                           fail)
                     case (= tok-lp)
                        def ok? exp tape from (parse-exp (cdr tape))
                        (loop exp tape)
                        where rec loop exp tape is
                           (if (= (car tape) tok-rp)
                              (ok exp (cdr tape))
                              def ok? new-exp tape from (parse-exp tape)
                                 (loop 
                                    (mk-app exp new-exp)
                                    tape))
                     case (= tok-def)
                        def ok1? vars delim exp tape from (read-binding (cdr tape))
                           def ok2? cont tape from (parse-exp tape)
                              (ok 
                                 (wrap vars delim exp t cont)
                                 tape)
                     case fn x in (or (= tok-fn x) (= tok-rec x))
                        def ok? vars delim exp tape from (read-binding tape)
                           (ok 
                              (wrap vars delim exp f cI) 
                              tape)
                     else
                        (ok
                           (mk-var (car tape))
                           (cdr tape))))))
      where fail is (tri f I I)
         and ok exp tape is (tri t exp tape)
         and read-binding is (parser 1t)
         and include-where-clauses is (parser 2t)
         and parse-exp is (parser 3t)



def rec print-cexp exp as
   (type exp
      (switch (var->value exp)
         case (= tok-s)  (put 0x7 0x3)
         case (= tok-k)  (put 0x6 0xB)
         case (= tok-i)  (put 0x6 0x9)
         case (= tok-b)  (put 0x6 0x2)
         case (= tok-c)  (put 0x6 0x3)
         case (= tok-w)  (put 0x7 0x7)
         case (= tok-y)  (put 0x7 0x9)
         case (= tok-t)  (put 0x7 0x4)
         case (= tok-b*) (put 0x6 0xC)
         case (= tok-c*) (put 0x6 0xE)
         case (= tok-s*) (put 0x6 0xD)
         else            (put 0x7 0x8))
      (put 0x7 0x8)
      fn cont in
         (put 0x6 0x1
            (print-cexp (app->rator exp)
               (print-cexp (app->rand exp) cont))))
      where put a b c is (b bi (a bi c))
      

[ Optimization related predicates. ]

def S? K? I? B? from  
   def var-eq? id exp as
      (and (var? exp) 
         (= (var->value exp) id))
   \c (c 
      (var-eq? tok-s)
      (var-eq? tok-k)
      (var-eq? tok-i)
      (var-eq? tok-b))

def K-app? exp as
   (and (app? exp) 
      (K? (app->rator exp)))

def B-app-app? exp as
   (and (app? exp) 
      (and (app? (app->rator exp))
         (B? (app->rator (app->rator exp)))))


[ curry-apply : exp1, exp2 -> exp3 
   exp3 = (S exp1 exp2) would do the trick, but this is the usual 
   place to optimize. These rules are derived from a SASL compiler.
   (S exp1 exp2) is the fallback case when no optimizations apply. ]

def curry-apply a b as 
   (if (K-app? a) 
      (if (K-app? b)
         (mk-app cK
            (mk-app 
               (app->rand a)
               (app->rand b)))
         (if (I? b) 
            (app->rand a)
            (if (B-app-app? b)
               (mk-app
                  (mk-app
                     (mk-app cB* (app->rand a))
                     (app->rand (app->rator b)))
                  (app->rand b))
               (mk-app
                  (mk-app cB (app->rand a))
                  b))))
      (if (B-app-app? a)
         (if (K-app? b)
            (mk-app
               (mk-app
                  (mk-app cC* (app->rand (app->rator a)))
                  (app->rand a))
               (app->rand b))
            (mk-app
               (mk-app
                  (mk-app cS* (app->rand (app->rator a)))
                  (app->rand a))
               b))
         (if (K-app? b)
            (mk-app
               (mk-app cC a)
               (app->rand b))
            (mk-app
               (mk-app cS a)
               b))))

[ compile : lambda expression -> combinator expression 
   Note: same ADT, just no lambdas ]

def rec compile exp as
   (type exp
      exp
      (extract
         (var->value (lam->variable exp))
         (lam->body exp))
      (mk-app
         (compile (app->rator exp))
         (compile (app->rand exp))))
   where rec extract var exp is
      (type exp
         (if (= var (var->value exp))
            cI
            (mk-app cK exp))
         (extract var
            (extract 
               (var->value (lam->variable exp))
               (lam->body exp)))
         (curry-apply
            (extract var (app->rator exp))
            (extract var (app->rand exp))))


[ strip : expression -> expression
   translates (\x A B) to A where x does not occur free in A ]

def rec strip exp as
   (type exp
         exp
         (mk-lam
            (lam->variable exp)
            (strip (lam->body exp)))
         def rat as (strip (app->rator exp))
         def ran as (strip (app->rand exp))
            (if (lam? rat) 
               (if (occurs-free? (var->value (lam->variable rat)) (lam->body rat))
                  (mk-app rat ran)
                  (lam->body rat))
               (mk-app rat ran)))
   where occurs-free? var is
      rec search exp in
      (type exp
         (= var (var->value exp))
         (if (= var (var->value (lam->variable exp)))
             f
            (search (lam->body exp)))
         (or 
            (search (app->rator exp))
            (search (app->rand exp))))

def rec exp-equal? a b as
   (type a
      (and (var? b) 
         (= 
            (var->value a) 
            (var->value b)))
      f
      (and (app? b)
         (and
            (exp-equal? 
               (app->rator a)
               (app->rator b))
            (exp-equal? 
               (app->rand a)
               (app->rand b)))))




[ t-compile : cexp -> cexp
  makes (x^i b), i more compact for large values of i]

def rec t-compile exp as
   (if (app? exp) 
      (if   
         (and 
            (app? (app->rand exp)) 
            (exp-equal? 
               (app->rator exp) 
               (app->rator 
                  (app->rand exp))))
         (t-factor 1 
            (app->rator exp) 
            (app->rand exp))
         (mk-app
            (t-compile (app->rator exp))
            (t-compile (app->rand exp))))
      exp)
   where rec t-factor count exp left is
      (if 
         (and (app? left) 
            (exp-equal? exp 
               (app->rator left)))
         (t-factor 
            (++ count) 
            exp 
            (app->rand left))
         (nfold-app count 
            (t-compile exp) 
            (t-compile left)))
      where nfold-app count func param is
         (loop 0 count)
         where rec loop tcount count is
            ((if (car count)
               (make-nfold tcount func)
               fn a in a)
               (if (nil? (cdr count))
                  param
                  (loop (++ tcount) (cdr count))))
            where rec make-nfold x exp target is
               (if (= 0 x)
                  (mk-app exp target)
                  (make-nfold (-- x) (mk-app cT exp) target))

[ string preprocessing 
  turns "things" into (string 0xA*) things ]

def $0 as (mkchar 0x3 0x0)
def $1 as (mkchar 0x3 0x1)
def $2 as (mkchar 0x3 0x2)
def $3 as (mkchar 0x3 0x3)
def $4 as (mkchar 0x3 0x4)
def $5 as (mkchar 0x3 0x5)
def $6 as (mkchar 0x3 0x6)
def $7 as (mkchar 0x3 0x7)
def $8 as (mkchar 0x3 0x8)
def $9 as (mkchar 0x3 0x9)
def $A as (mkchar 0x4 0x1)
def $B as (mkchar 0x4 0x2)
def $C as (mkchar 0x4 0x3)
def $D as (mkchar 0x4 0x4)
def $E as (mkchar 0x4 0x5)
def $F as (mkchar 0x4 0x6)

def hex->char x as
   def 1 x from (x bi f)
   def 2 x from x
   def 3 x from x
   def 4 x from x
   (1 (2 (3 (4 $F $7) (4 $B $3))
         (3 (4 $D $5) (4 $9 $1)))
      (2 (3 (4 $E $6) (4 $A $2))
         (3 (4 $C $4) (4 $8 $0))))

def string-start as "(string "
def string-end as "0x0 0x0)"



[ characterize : bit pair list -> char list
   - translates "things" to hex strings
   - removes nested comments ]
   
def characterize str as
   (walk 1t str)
   where rec walk state str is
      def str h2 from (read-hex str)
      def str h1 from (read-hex str)
      (state
         (if (and (hex-eq? h1 0x2) (hex-eq? h2 0x2))
            (append string-start
               (handle-string str))
            (if (and (hex-eq? h1 0x5) (hex-eq? h2 0xB))
               (handle 
                  (skip-comment str))
               (cons
                  (mkchar h1 h2)
                  (handle str))))
         (if (and (hex-eq? h1 0x2) (hex-eq? h2 0x2))
            (append
               string-end
               (handle str))
            (append "0x"
               (cons (hex->char h1)
                  (append " 0x"
                     (cons (hex->char h2)
                        (append " " (handle-string str)))))))
         (if (and (hex-eq? h1 0x5) (hex-eq? h2 0xD))
            str
            (if (and (hex-eq? h1 0x5) (hex-eq? h2 0xB))
               (skip-comment
                  (skip-comment str))
               (skip-comment str))))
         where handle is (walk 1t)
            and handle-string is (walk 2t)
            and skip-comment is (walk 3t)


def rec main-handler tape as
   def ok? value tape from (parse tape)
   def value as (strip value)
   (if ok?
         (print-cexp (t-compile (compile value)))
         (print-cexp cS* cI)
      (main-handler (cdr tape)))
         
fn input is
   (main-handler tape)
   where tape is
      (tokenizer 
         (lexer 
            (characterize input)))

end

