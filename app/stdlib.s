
[ first some familiar combinators ]

def Y a as (X X)
   where X b is (a (b b))

def S a b c as (a c (b c))
def K a b as a
def I a as a
def W a b as (a b b)
def C a b c as (a c b)
def B a b c as (a (b c))

[ pairs, tuples and utilities ]

def bi a b as 
   fn c in (c a b)

def t a b as a
def f a b as b

def eq? a b as
   (a b (b f t))

def tri a b c as 
   fn d in (d a b c)

def 1t a b c as a
def 2t a as t 
def 3t a as f

def quad a b c d as 
   fn e in (e a b c d)

def 1q a b c d as a
def 2q a as 1t
def 3q a as 2t
def 4q a as 3t

def quintuple a b c d e as 
   fn f in (f a b c d e)

def Q1 a b c d e as a
def Q2 a as 1q
def Q3 a as 2q
def Q4 a as 3q
def Q5 a as 4q

def if a as a

[ sixteen bit vectors for the i/o lords ]

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


[ chars via the bit vectors ]

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


[ some characters to be called by name ]
       
def $no-break-space as (mkchar 0xA 0x0)
def $inverted-exclamation-mark as (mkchar 0xA 0x1)
def $cent-sign as (mkchar 0xA 0x2)
def $pound-sign as (mkchar 0xA 0x3)
def $currency-sign as (mkchar 0xA 0x4)
def $yen-sign as (mkchar 0xA 0x5)
def $broken-bar as (mkchar 0xA 0x6)
def $section-sign as (mkchar 0xA 0x7)
def $diaresis as (mkchar 0xA 0x8)
def $copyright-sign as (mkchar 0xA 0x9)
def $feminine-ordinal-indicator as (mkchar 0xA 0xA)
def $left-pointing-double-angle-quotation-mark as (mkchar 0xA 0xB)
def $not-sign as (mkchar 0xA 0xC)
def $soft-hyphen as (mkchar 0xA 0xD)
def $registered-sign as (mkchar 0xA 0xE)
def $macron as (mkchar 0xA 0xF)

def $degree-sign as (mkchar 0xB 0x0)
def $plus-minus-sign as (mkchar 0xB 0x1)
def $superscript-two as (mkchar 0xB 0x2)
def $superscript-three as (mkchar 0xB 0x3)
def $acute-accent as (mkchar 0xB 0x4)
def $micro-sign as (mkchar 0xB 0x5)
def $pilcrow-sign as (mkchar 0xB 0x6)
def $middle-dot as (mkchar 0xB 0x7)
def $cedilla as (mkchar 0xB 0x8)
def $superscript-one as (mkchar 0xB 0x9)
def $masculine-ordinal-indicator as (mkchar 0xB 0xA)
def $right-pointing-double-andle-quotation-mark as (mkchar 0xB 0xB)
def $vulgar-fraction-one-quarter as (mkchar 0xB 0xC)
def $vulgar-fraction-one-half as (mkchar 0xB 0xD)
def $vulgar-fraction-three-quarters as (mkchar 0xB 0xE)
def $inverted-question-mark as (mkchar 0xB 0xF)

def $A-grave as (mkchar 0xC 0x0)
def $A-acute as (mkchar 0xC 0x1)
def $A-circumflex as (mkchar 0xC 0x2)
def $A-tilde as (mkchar 0xC 0x3)
def $A-diaresis as (mkchar 0xC 0x4)
def $A-ring as (mkchar 0xC 0x5)
def $AE as (mkchar 0xC 0x6)
def $C-cedilla as (mkchar 0xC 0x7)
def $E-grave as (mkchar 0xC 0x8)
def $E-acute as (mkchar 0xC 0x9)
def $E-circumflex as (mkchar 0xC 0xA)
def $E-diaresis as (mkchar 0xC 0xB)
def $I-grave as (mkchar 0xC 0xC)
def $I-acute as (mkchar 0xC 0xD)
def $I-circumflex as (mkchar 0xC 0xE)
def $I-diaresis as (mkchar 0xC 0xF)

def $ETH as (mkchar 0xD 0x0)
def $N-tilde as (mkchar 0xD 0x1)
def $O-grave as (mkchar 0xD 0x2)
def $O-acute as (mkchar 0xD 0x3)
def $O-circumflex as (mkchar 0xD 0x4)
def $O-tilde as (mkchar 0xD 0x5)
def $I-diaresis as (mkchar 0xD 0x6)
def $multiplication as (mkchar 0xD 0x7)
def $O-stroke as (mkchar 0xD 0x8)
def $U-grave as (mkchar 0xD 0x9)
def $U-acute as (mkchar 0xD 0xA)
def $U-circumflex as (mkchar 0xD 0xB)
def $U-diaresis as (mkchar 0xD 0xC)
def $Y-acute as (mkchar 0xD 0xD)
def $capital-thorn as (mkchar 0xD 0xE)
def $s-sharp as (mkchar 0xD 0xF)

def $a-grave as (mkchar 0xE 0x0)
def $a-acute as (mkchar 0xE 0x1)
def $a-circumflex as (mkchar 0xE 0x2)
def $a-tilde as (mkchar 0xE 0x3)
def $a-diaresis as (mkchar 0xE 0x4)
def $a-ring as (mkchar 0xE 0x5)
def $ae as (mkchar 0xE 0x6)
def $c-cedilla as (mkchar 0xE 0x7)
def $e-grave as (mkchar 0xE 0x8)
def $e-acute as (mkchar 0xE 0x9)
def $e-circumflex as (mkchar 0xE 0xA)
def $e-diaresis as (mkchar 0xE 0xB)
def $i-grave as (mkchar 0xE 0xC)
def $i-acute as (mkchar 0xE 0xD)
def $i-curcumflex as (mkchar 0xE 0xE)
def $i-diaresis as (mkchar 0xE 0xF)

def $eth as (mkchar 0xF 0x0)
def $n-tilde as (mkchar 0xF 0x1)
def $o-grave as (mkchar 0xF 0x2)
def $o-acute as (mkchar 0xF 0x3)
def $o-circumflex as (mkchar 0xF 0x4)
def $o-tilde as (mkchar 0xF 0x5)
def $o-diaresis as (mkchar 0xF 0x6)
def $division as (mkchar 0xF 0x7)
def $o-stroke as (mkchar 0xF 0x8)
def $u-grave as (mkchar 0xF 0x9)
def $u-acute as (mkchar 0xF 0xA)
def $u-circumflex as (mkchar 0xF 0xB)
def $u-diaresis as (mkchar 0xF 0xC)
def $y-acute as (mkchar 0xF 0xD)
def $thorn as (mkchar 0xF 0xE)
def $y-diaresis as (mkchar 0xF 0xF)

def $nul as (mkchar 0x0 0x0)
def $soh as (mkchar 0x0 0x1)
def $stx as (mkchar 0x0 0x2)
def $etx as (mkchar 0x0 0x3)
def $eot as (mkchar 0x0 0x4)
def $enq as (mkchar 0x0 0x5)
def $ack as (mkchar 0x0 0x6)
def $bel as (mkchar 0x0 0x7)
def $bs as (mkchar 0x0 0x8)
def $ht as (mkchar 0x0 0x9)
def $lf as (mkchar 0x0 0xA)
def $nl as $lf
def $vt as (mkchar 0x0 0xB)
def $ff as (mkchar 0x0 0xC)
def $cr as (mkchar 0x0 0xD)
def $s0 as (mkchar 0x0 0xE)
def $s1 as (mkchar 0x0 0xF)
def $dle as (mkchar 0x1 0x0)
def $dc1 as (mkchar 0x1 0x1)
def $dc2 as (mkchar 0x1 0x2)
def $dc3 as (mkchar 0x1 0x3)
def $dc4 as (mkchar 0x1 0x4)
def $nak as (mkchar 0x1 0x5)
def $syn as (mkchar 0x1 0x6)
def $etb as (mkchar 0x1 0x7)
def $can as (mkchar 0x1 0x8)
def $em as (mkchar 0x1 0x9)
def $sub as (mkchar 0x1 0xA)
def $esc as (mkchar 0x1 0xB)
def $fs as (mkchar 0x1 0xC)
def $gs as (mkchar 0x1 0xD)
def $rs as (mkchar 0x1 0xE)
def $us as (mkchar 0x1 0xF)
def $! as (mkchar 0x2 0x1)
def $space as (mkchar 0x2 0x0)
def $spc as $space
def $hipsu as (mkchar 0x2 0x2)
def $# as (mkchar 0x2 0x3)
def $$ as (mkchar 0x2 0x4)
def $% as (mkchar 0x2 0x5)
def $& as (mkchar 0x2 0x6)
def $' as (mkchar 0x2 0x7)
def $lp as (mkchar 0x2 0x8)
def $rp as (mkchar 0x2 0x9)
def $* as (mkchar 0x2 0xA)
def $+ as (mkchar 0x2 0xB)
def $, as (mkchar 0x2 0xC)
def $- as (mkchar 0x2 0xD)
def $. as (mkchar 0x2 0xE)
def $slash as (mkchar 0x2 0xF)
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
def $colon as (mkchar 0x3 0xA)
def $; as (mkchar 0x3 0xB)
def $< as (mkchar 0x3 0xC)
def $= as (mkchar 0x3 0xD)
def $> as (mkchar 0x3 0xE)
def $? as (mkchar 0x3 0xF)
def $@ as (mkchar 0x4 0x0)
def $A as (mkchar 0x4 0x1)
def $B as (mkchar 0x4 0x2)
def $C as (mkchar 0x4 0x3)
def $D as (mkchar 0x4 0x4)
def $E as (mkchar 0x4 0x5)
def $F as (mkchar 0x4 0x6)
def $G as (mkchar 0x4 0x7)
def $H as (mkchar 0x4 0x8)
def $I as (mkchar 0x4 0x9)
def $J as (mkchar 0x4 0xA)
def $K as (mkchar 0x4 0xB)
def $L as (mkchar 0x4 0xC)
def $M as (mkchar 0x4 0xD)
def $N as (mkchar 0x4 0xE)
def $O as (mkchar 0x4 0xF)
def $P as (mkchar 0x5 0x0)
def $Q as (mkchar 0x5 0x1)
def $R as (mkchar 0x5 0x2)
def $S as (mkchar 0x5 0x3)
def $T as (mkchar 0x5 0x4)
def $U as (mkchar 0x5 0x5)
def $V as (mkchar 0x5 0x6)
def $W as (mkchar 0x5 0x7)
def $X as (mkchar 0x5 0x8)
def $Y as (mkchar 0x5 0x9)
def $Z as (mkchar 0x5 0xA)
def $lb as (mkchar 0x5 0xB)
def $bslash as (mkchar 0x5 0xC)
def $rb as (mkchar 0x5 0xD)
def $^ as (mkchar 0x5 0xE)
def $_ as (mkchar 0x5 0xF)
def $` as (mkchar 0x6 0x0)
def $a as (mkchar 0x6 0x1)
def $b as (mkchar 0x6 0x2)
def $c as (mkchar 0x6 0x3)
def $d as (mkchar 0x6 0x4)
def $e as (mkchar 0x6 0x5)
def $f as (mkchar 0x6 0x6)
def $g as (mkchar 0x6 0x7)
def $h as (mkchar 0x6 0x8)
def $i as (mkchar 0x6 0x9)
def $j as (mkchar 0x6 0xA)
def $k as (mkchar 0x6 0xB)
def $l as (mkchar 0x6 0xC)
def $m as (mkchar 0x6 0xD)
def $n as (mkchar 0x6 0xE)
def $o as (mkchar 0x6 0xF)
def $p as (mkchar 0x7 0x0)
def $q as (mkchar 0x7 0x1)
def $r as (mkchar 0x7 0x2)
def $s as (mkchar 0x7 0x3)
def $t as (mkchar 0x7 0x4)
def $u as (mkchar 0x7 0x5)
def $v as (mkchar 0x7 0x6)
def $w as (mkchar 0x7 0x7)
def $x as (mkchar 0x7 0x8)
def $y as (mkchar 0x7 0x9)
def $z as (mkchar 0x7 0xA)
def ${ as (mkchar 0x7 0xB)
def $| as (mkchar 0x7 0xC)
def $} as (mkchar 0x7 0xD)
def $~ as (mkchar 0x7 0xE)
def $del as (mkchar 0x7 0xF)


[ some logic ]

def not a as 
   (a f t)

def or a b as 
   (a t b)

def and a b as 
   (a b f)

def implies a b as 
   (a (b f t) t)

def iff a b as 
   (a b (b f t))

def nand a b as 
   (a (b f t) t)

def xor a b as 
   (a (b f t) b)

def neither a b as
   (a f (b f t))

def same-bit? a b as 
   (a b (not b))


[ list operations ]

def cons as (tri f)
def car a as (a 2t)
def cdr a as (a 3t)
def nil? a as (a 1t)
def nil c as t

def caar a as (car (car a))
def cadr a as (car (cdr a))
def cdar a as (cdr (car a))
def cddr a as (cdr (cdr a))
def caaar a as (car (caar a))
def caadr a as (car (cadr a))
def cadar a as (car (cdar a))
def caddr a as (car (cddr a))
def cdaar a as (cdr (caar a))
def cdadr a as (cdr (cadr a))
def cddar a as (cdr (cdar a))
def cdddr a as (cdr (cddr a))

def enlist a as 
   (cons a nil)

def lrec a g f l as
   (loop l)
   where rec loop x is
      (if (nil? x) a
         (g (f (car x))
            (loop (cdr x))))

def append a b as 
   (lrec b cons I a)

def map a as
   (lrec nil cons a)

def concat as
   (lrec nil append I)

def push a as 
   (lrec a cons I)

def amap a as
   (lrec nil append a)

def reverse as
   (lrec nil push enlist)

def list-and as 
   (lrec t and)

def all op as
   (lrec t and op)

def some op as
   (lrec f or op)

def none op as
   (lrec f neither op)

def max op init as
   (lrec init 
      fn val rest in
         (if (op val rest) val rest)
      I)

def keep op as
   (lrec nil 
      fn vals rest in 
         def a b from vals
            (if a (cons b rest) rest)
      fn a in (bi (op a) a))

def first init op as 
   (lrec init
      fn vals rest in
         def a b from vals
            (if a b rest)
      fn a in (bi (op a) a))

def reverse l as 
   (loop nil l)
   where rec loop a b is
      (if (nil? b) a
         (loop 
            (cons (car b) a) 
            (cdr b)))

def lrec2 a 1e 2e g f l1 l2 as
   (loop l1 l2)
   where rec loop l1 l2 is
      (if (nil? l1) 
         (if (nil? l2) a 1e)
         (if (nil? l2) 2e
            (g 
               (f (car l1) (car l2))
               (loop 
                  (cdr l1) 
                  (cdr l2)))))

def list-eq? op as
   (lrec2 t f f and op)

def map2 op as
   (lrec2 nil nil nil cons op)

def last a as
   (car (reverse a))

def list-print spacer op lst cont as 
   (loop lst)
   where rec loop lst is
      (nil? lst cont
         (spacer 
            (op (car lst)
               (loop (cdr lst)))))


[ some more utilities ]

def ab a b as a

def let a b as 
   (b a)

def let2 as bi
def let3 as tri

def pass as let
def pass2 as let2
def pass3 as let3

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

def begin as
   (Y \elf \buff \end? \proc
      (end? (buff proc)
         (elf \a (buff (proc a)))) 
      I)

def do as f
def end as t


[ basic binary arithmetic ]

def 0 as (cons f nil)
def 1 as (cons t nil)

def rec ++ a as
   (nil? a 1  
      (car a 
         (cons f (++ (cdr a)))
         (cons t (cdr a)))) 

def = as 
   (list-eq? same-bit?)


[ some more character operations ]

def char-eq? a b as 
   (test
      (a cons nil)
      (b cons nil))
   where rec test a b is 
      (nil? a t
         def con as (test (cdr a) (cdr b)) 
         (car a 
            (car b con f)
            (car b f con)))

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

def rec string-eq? a b as
   (nil? a 
      (nil? b)
      (nil? b f
         (char-eq? (car a) (car b)
            (string-eq? (cdr a) (cdr b))
               f)))

def read-line i cont as 
   def nl as (mkchar 0x0 0xA)
   def rec temp buff i as
      (read-char i \i \chr
         (char-eq? chr nl
            (cont i (reverse buff))
            (temp (cons chr buff) i)))
   (temp nil i)
   
def rec print-string str cont as
   (walk str)
   where rec walk str is 
      (if (nil? str)
         cont
         (print-char 
            (car str)
            (walk (cdr str))))

def newline as 
   def nl as (mkchar 0x0 0xA)
      fn cont in
         (print-char nl cont)

def space as 
   def spc as (mkchar 0x2 0x0)
      fn cont in
         (print-char spc cont)
 
def print-line a con as 
   (print-string a 
      (newline con))

def print-bin a cont as 
   (temp (reverse a))
   where rec temp a is
      (if (nil? a) cont
         (print-char 
            (car a 
               (mkchar 0x3 0x1)
               (mkchar 0x3 0x0))
            (temp (cdr a))))

def print-bin bin cont as
   (temp bin cont)
   where rec temp bin cont is
      (if (nil? bin) cont
         def x 1 r from bin
         def x 2 r from (if (nil? r) (tri f f nil) r)
         def x 3 r from (if (nil? r) (tri f f nil) r)
         def x 4 r from (if (nil? r) (tri f f nil) r)
            (temp r 
               (print-char
                  (1 (2 (3 (4 $F $7) (4 $B $3))
                           (3 (4 $D $5) (4 $9 $1)))
                      (2 (3 (4 $E $6) (4 $A $2))
                           (3 (4 $C $4) (4 $8 $0))))
                  cont)))

def rec string->bits a as
   (if (nil? a) 
      nil
      (car a cons
         (string->bits (cdr a))))


[ some set operations ]

def member? = a S as
   (lrec f or (= a) S)

def subset? = A B as
   (lrec t and 
      fn x in (member? = x B)
      A)

def list->set = as 
   rec convert A in
      (if (nil? A) nil
         (member? = (car A) (cdr A)
            f cons 
            (car A) 
            (convert (cdr A))))

def union = A B as 
   (list->set =
      (append A B))

def difference = A B as
   (lrec nil 
      fn this in
         (if (member? = this B) I
            (cons this))
      I A)

def intersect = A B as
   (lrec nil 
      fn elem in
         (if (member? = elem B)
            (cons elem) I)
      I A)

def set-equal? = A B as 
   (and 
      (subset? = B A)
      (subset? = A B))

def set-printer start delim end op A cont as
   (start (walk A))
   where rec walk A is
      (delim 
         (if (nil? A) 
            (end cont)
            (op (car A)
               (walk (cdr A)))))



      [ 
      def member? = a as 
         rec lookup A is
            (nil? A f
               (= (car A) a t
                  (lookup (cdr A))))

      def subset? = A B as
         (walk A)
         where rec walk A is
            (nil? A t
               (member? = (car A) B
                  (walk (cdr A))
                  f)) 

      def list->set = as 
         rec convert A in
            (nil? A nil
               (member? = (car A) (cdr A)
                  f cons 
                  (car A) 
                  (convert (cdr A))))

      def union = A B as 
         (list->set =
            (append A B))

      def difference = A B as 
         (walk A)
         where rec walk A is
            (nil? A nil
               (member? = (car A) B
                  f cons (car A) (walk (cdr A)))) 

      def intersect = A B as 
         (walk A)
         where rec walk A is
            (nil? A nil
               (member? = (car A) B
                  cons f (car A) (walk (cdr A))))

      def set-equal? = A B as 
         (and 
            (subset? = B A)
            (subset? = A B))

      def set-printer start delim end op A cont as
         (start (walk A))
         where rec walk A is
            (delim 
               (nil? A (end cont)
                  (op (car A)
                     (walk (cdr A)))))
      ]





[ tapes (lazy binary tree based random access lists) ]

def tape-cons as tri

def tape-nil B as 
   rec N in (tape-cons N N B)

def rec tape-read B k as
   (if (nil? k) 
      (B 3t)
      (tape-read 
         (B (car k 1t 2t)) 
         (cdr k)))

def tape-apply T id op as 
   (do id T)
   where rec do k T is
      def L R v from T
      (if (nil? k)
            (tape-cons L R (op v))
            def c as (do (cdr k))
               (tape-cons
                  (car k c I L)
                  (car k I c R)
                  v))

def tape-write T id val as 
   (tape-apply T id (ab val))

def tape-new as 
   tape-nil

def tape-map T f i as 
   (do T 0)
   where rec do T a is
      (if (= a i) 
         T
         def T as (tape-apply T a f)
            (do T (++ a)))



[ some more binary arithmetic ]

def 10 as (++ 1)
def 11 as (++ 10)
def 100 as (++ 11)
def 101 as (++ 100)
def 110 as (++ 101)
def 111 as (++ 110)

def + as 
   (Y \elf \a \b
      (nil? a b
         (nil? b a
            (let (car b ++ I a) \a
               (cons (car a) 
                   (elf (cdr a) 
                        (cdr b)))))))

def * as 
   (Y \elf \a \b
      (nil? b 0
         (let 
            (elf (cons f a) (cdr b))
            \c (car b (+ a) I c))))

def -- as \a
   (nil? (cdr a) 0
      (Y \elf \a   
         (nil? a a
            (car a 
               (nil? (cdr a) (cdr a)
                     (cons f (cdr a)))
               (cons t (elf (cdr a)))))
         a)) 

def - as
   (Y \elf \a \b
      (nil? b a
         (let (car b -- I a) 
            \a (nil? (cdr a) 
                   (car a 1 nil)
            (let (elf (cdr a) (cdr b))
               \c (nil? c (car a 1 nil) 
                      (cons (car a) c)))))))

def ! as
   (Y \elf \a
      (= a 0 1 
         (* a (elf (-- a))))) 


def > as \a \b
   (Y \elf \a \b
      (nil? a
         (nil? b (bi f f) (bi t f))
         (nil? b
            (bi t t)
            (let (elf (cdr a) (cdr b)) \c 
               (c t c
                  (car a
                     (car b c (bi t t))
                     (car b (bi t f) c))))))
      a b f)
   

[ hashes (actually string-addressable vectors) ]

def hash-nil as 
   tape-new

def hash-new as 
   hash-nil

def hash-read H key as 
   (tape-read H 
      (string->bits key))

def hash-write H key val as 
   (tape-write H 
      (string->bits key) val)


[ some more list operations ]

def print-list as
   (set-printer
      (print-char $lp)
      (print-char $space)
      (print-char $rp))


def add-indeces L as
   (loop 0 L)
   where rec loop i L is
      (if (nil? L) nil
         (cons (bi i (car L))
            (loop (++ i) (cdr L))))

def length L as 
   (loop 0 L)
   where rec loop i l is
      (if (nil? l) i
         (loop (++ i) (cdr l)))

def index as \op \a
   (Y \elf \i \L 
      (if (op a (car L)) i
         (elf (++ i) (cdr L))) 0)

def list-ref as 
   (Y \elf \i \l
      (if (= 0 i) 
         (car l)
         (elf (-- i) (cdr l))))


[ some finite automata operations ]

def fa-make states alphabet transitions start-state final-states as
   (quintuple 
      states 
      alphabet 
      transitions 
      start-state 
      final-states)

def fa-states A as (A Q1)
def fa-alphabet A as (A Q2)
def fa-transitions A as (A Q3)
def fa-start-state A as (A Q4)
def fa-end-states A as (A Q5)

def fa-normal-transitions A as 
   (fa-transitions A t) 

def fa-epsilon-transitions A as 
   (fa-transitions A f)

def fa-shift A by as 
   def S al tr s0 F from A
      (fa-make
         (map (+ by) S)
         al
         (bi
            (map
               \x3 (x3 \from \via \to (tri (+ from by) via (+ to by)))
               (tr t))
            (map 
               \x2 (x2 \from \to (bi (+ from by) (+ to by)))
               (tr f)))
         (+ s0 by)
         (map (+ by) F))

def fa-max-state as \A
   (max > 0 (fa-states A))

def fa-catenate A B as 
   def B as (fa-shift B (++ (fa-max-state A)))
   def A-S A-alpha A-tr A-s0 A-F from A
   def B-S B-alpha B-tr B-s0 B-F from B
         (fa-make 
            (append A-S B-S)
            (union char-eq? A-alpha B-alpha)
            (bi
               (append (A-tr t) (B-tr t))
               (append
                  (append (A-tr f) (B-tr f))
                  (map 
                     \af (bi af B-s0)
                     A-F)))
            A-s0
            B-F)

def fa-kleene A as
   def S alpha tr s0 F from (fa-shift A 10)
         (fa-make
            (cons 0 (cons 1 S))
            alpha
            (bi
               (tr t)
               (append
                  (map \x (bi x s0) F)
                  (append
                     (map \x (bi x 1) F)
                     (append 
                        (tr f)
                        (cons (bi 0 1) (cons (bi 0 s0) nil))))))
            0
            (cons 1 nil))

def fa-kleene* as 
   fa-kleene

def fa-kleene+ as \A
   (fa-catenate A 
      (fa-kleene* A))

def fa-join as \A \B
   (let (fa-shift A 10) \A
   (let (fa-shift B (++ (fa-max-state A))) \B
      (A \A-S \A-alpha \A-tr \A-s0 \A-F
      (B \B-S \B-alpha \B-tr \B-s0 \B-F
         (fa-make
            (cons 0 (cons 1 (append A-S B-S)))
            (union char-eq? A-alpha B-alpha)
            (bi
               (append (A-tr t) (B-tr t))
               (cons (bi 0 A-s0)
                  (cons (bi 0 B-s0)
                     (append (map \x (bi x 1) A-F)
                        (append (map \x (bi x 1) B-F)
                           (append (A-tr f) (B-tr f)))))))
            0
            (cons 1 nil))))))


def fa-epsilon-closure A state as
   def epsilons as (fa-epsilon-transitions A) 
      (expand (enlist state))
      where rec expand selected is 
         def newly-selected as
            (list->set =
               (amap
                  \x (map \x (x f) (keep \e (= (e t) x) epsilons))
                  selected))
         (if (subset? = newly-selected selected)
            selected
            (expand (union = selected newly-selected)))

def fa-neighbors A chr state as   
   (map \a (a 3t)
      (keep \t (t \from \via \to 
            (and (= from state) (char-eq? chr via)))
         (fa-normal-transitions A)))

def fa-equivalence-classes A as 
   def next-class states char as
         (list->set = 
            (amap (fa-epsilon-closure A)
               (amap (fa-neighbors A char) states)))
   def S alpha tr s0 F from A
   (loop nil (enlist (fa-epsilon-closure A (enlist s0))))
   where rec loop done todo is
            (if (nil? todo) done
               (loop 
                  (union (set-equal? =) 
                     (enlist (car todo)) done)
                  (append (cdr todo)
                     (difference (set-equal? =)
                        (list->set (set-equal? =)
                           (map (next-class (car todo)) alpha))
                        (cons (car todo) done)))))

def fa-equivalence-transitions A classes as
   def S alpha tr s0 F from A
   def make-transition class char as
            (list->set = 
                (amap (fa-epsilon-closure A)
                   (amap (fa-neighbors A char) class)))
   def class-index class as 
      (index (set-equal? =) class classes)
   (amap 
      \class
         (map
            \char
               (tri 
                  (class-index class) 
                  char 
                  (class-index (make-transition class char)))
            alpha)
      classes)


def fa-via-subset-construction A as
   def e-classes as 
      (fa-equivalence-classes A)
   def e-transitions as 
      (fa-equivalence-transitions A e-classes)
   def class-index class as
      (index (set-equal? =) class e-classes)
   def class-index-of state as 
      (index \a \b (member? = a b) state e-classes)
    (fa-make 
       (make-list e-classes 0)
       (fa-alphabet A)
       (bi e-transitions nil)
       (class-index-of (fa-start-state A))
       (list->set = 
          (map class-index
             (keep 
                \x (not (nil? (intersect = x (fa-end-states A))))
                e-classes))))
   where rec make-list l i is
      (if (nil? l) nil 
          (cons i (make-list (cdr l) (++ i))))

def fa-add-garbage-state A as
   def S alpha tr s0 F from (fa-shift A 1)
   def normal epsilon from tr
      (fa-make
         (cons 0 S)
         alpha
         (bi new-normal-transitions epsilon)
         s0
         F)
      where new-normal-transitions is
         (append 
            from-0-to-0
            def find-move from-state via as
               (search normal)
               where rec search trans is
                  (if (nil? trans) 
                     (bi f f)
                     (if (and (= (car trans 1t) from-state) (char-eq? (car trans 2t) via))
                        (bi t (car trans))
                        (search (cdr trans))))
               (loop alpha S)
               where rec loop al st is
                  (nil? st nil
                     (nil? al
                        (loop alpha (cdr st))
                        (find-move (car st) (car al) \found? \move
                           (cons 
                              (found? move
                                 (tri (car st) (car al) 0))
                              (loop (cdr al) st))))))
         where from-0-to-0 is (map \char (tri 0 char 0) alpha)

def fa-deterministic? A as 
   (and no-epsilon-transitions all-transitions-exist)
   where no-epsilon-transitions is 
         (nil? (fa-epsilon-transitions A))
      and all-transitions-exist is
         (nil? 
            (difference compare-op
               all-needed-transitions
               (fa-normal-transitions A)))
         where compare-op is
               fn a b in 
                  def afrom avia ato from a
                  def bfrom bvia bto from b
                     (and (= afrom bfrom) 
                        (char-eq? avia bvia))
            and all-needed-transitions is
               (amap 
                  \chr (map \state (tri chr state I) (fa-states A))
                  (fa-alphabet A))
   
def fa-dfa-minimize as \A
   def S alpha tr s0 F from A
   def trans eps from tr
   def same-class? a b as
            (Y \elf \classes
               (member? = a (car classes)
                  (member? = b (car classes))
                  (elf (cdr classes))))
   def overlap? a b as
         (not (nil? (intersect = a b)))
   def class-no classes state as
            (Y \elf \c \i
               (nil? c 0
                  (member? = state (car c)
                     i
                     (elf (cdr c) (++ i))))
               classes 0)
   def move state chr as
            (Y \elf \tr
               (car tr \from \via \to
                  (and (= from state) (char-eq? via chr) 
                     to
                     (elf (cdr tr))))
               trans)
   def same-alpha-class? as
         (Y \elf \alphabet \classes \a \b
            (cond
               case (nil? alphabet)
                  t
               case (same-class? 
                           (move a (car alphabet))
                           (move b (car alphabet))
                           classes)
                  (elf (cdr alphabet) classes a b)
               else f) alpha)
   def split-by classes class as
                  (Y \elf \head \tail \buff \diff
                     (cond
                        case (nil? tail)
                           (cons
                              (cons head buff)
                              (nil? diff nil
                                 (cons diff nil)))
                        case (same-alpha-class? classes head (car tail))
                           (elf head
                              (cdr tail)
                              (cons (car tail) buff)
                              diff)
                        else
                           (elf head
                              (cdr tail)
                              buff
                              (cons (car tail) diff)))
                        (car class) (cdr class) nil nil)
      (thing
            (cons F
               (cons
                  (difference = S F)
                  nil)))
      where rec thing clist is 
         def new as (amap (split-by clist) clist)
            (if (= (length new) (length clist))
                  (fa-make
                     (Y \elf \i \l
                        (nil? l nil
                           (cons i (elf (++ i) (cdr l))))
                        0 new)
                     alpha
                     (Y \elf \cml \alpha-left \new-trans \state
                        (cond
                           case (nil? cml)
                              (bi new-trans nil)
                           case (nil? alpha-left)
                              (elf (cdr cml) alpha 
                                 new-trans (++ state))
                           else
                              (elf cml (cdr alpha-left)
                                 (cons 
                                    (tri 
                                       state 
                                       (car alpha-left) 
                                       (class-no new (move (car cml) (car alpha-left))))
                                    new-trans)
                                 state))
                        (map car new) alpha nil 0)
                     (class-no new s0)
                     (map 
                        \a (class-no new (car a))
                        (keep \a (overlap? a F) new)))
                  (thing new))

def fa-to-dfa A as 
   (fa-add-garbage-state 
      (fa-via-subset-construction A))

def fa-to-minimal-dfa A as 
   (fa-dfa-minimize
      (fa-to-dfa A))

def fa-minimize as 
   fa-to-minimal-dfa

def print-bset as 
   (print-list print-bin)

def print-cset as 
   (print-list print-char)

def print-transition x cont as 
   (x \from \via \to
      (begin
         do (print-char $lp)
         do (print-bin from)
         do (print-char $space)
         do (print-char via)
         do (print-char $space)
         do (print-bin to)
         do (print-char $rp)
         end cont))

def print-epsilon-transition x cont as 
   (x \from \to
      (begin
         do (print-char $lp)
         do (print-bin from)
         do (print-char $space)
         do (print-string "eps")
         do (print-char $space)
         do (print-bin to)
         do (print-char $rp)
         end cont))

def print-transitions t cont as 
   def normals epsilons from t
      (list-print (print-char $space) print-transition normals
         (list-print (print-char $space) print-epsilon-transition epsilons
            cont))

def fa-print A cont as 
   (begin
      do (print-line "Finite Automata {")
      do (print-string "   States: ")
      do (print-bset (fa-states A))
      do newline
      do (print-string "   Alphabet: ")
      do (print-cset (fa-alphabet A))
      do newline
      do (print-string "   Transitions: ")
      do (print-transitions (fa-transitions A))
      do newline
      do (print-string "   Start state: ")
      do (print-bin (fa-start-state A))
      do newline
      do (print-string "   End state(s): ")
      do (print-bset (fa-end-states A))
      do newline
      do (print-line "}")
      end (newline cont))

def char->fa chr as 
   (fa-make
      (cons 0 (enlist 1))
      (enlist chr)
      (bi (enlist (tri 0 chr 1)) nil)
      0
      (enlist 1))

def dfa-match? A str as
   def S alpha tr s0 F from A
   def transitions epsilons from tr
   def move state char as
      (first f 
         \t (t \from \via \to (and (= from state) (char-eq? via char)))
         transitions 3t)
      (if (nil?   (difference char-eq? (list->set char-eq? str) alpha))
            (go s0 str)
            where rec go state str is
               (if (nil? str)
                  (member? = state F)
                  (go (move state (car str)) (cdr str)))
         f)


[ building finite state automata from strings ]

def auto-string->fa str as
   (translate str t)
   where rec translate str is
      (switch (car str)
         case (char-eq? $+)
            def a str from (translate (cdr str))
            def b str from (translate str)
               (bi 
                  (fa-join a b) 
                  str)
         case (char-eq? $.)
            def a str from (translate (cdr str))
            def b str from (translate str)
               (bi 
                  (fa-catenate a b) 
                  str)
         case (char-eq? $*)
            def a str from (translate (cdr str))
               (bi 
                  (fa-kleene* a) 
                  str)
         else
            (bi 
               (char->fa (car str)) 
               (cdr str)))

def auto-string->dfa str as 
   (fa-to-minimal-dfa 
      (auto-string->fa str))

def infix-operators as "+-"

def infix-operator? x as
   (member? char-eq? x infix-operators)

def postfix-operators as "*"

def postfix-operator? x as
   (member? char-eq? x postfix-operators)

def parenthesis as "()"

def special-characters as 
   (append infix-operators
      (append postfix-operators 
         parenthesis))

def special-character? x as
   (member? char-eq? x special-characters)

def regular-character? x as
   (not (special-character? x))

def remove-spaces str as 
   (keep 
      \x (not (char-eq? x $space))
      str)

def add-catenators str as 
   (do f str)
   where rec do add? str is
      (cond
         case (nil? str)
            nil
         case add?
            (or (char-eq? (car str) $lp) (regular-character? (car str))
               (cons $.) I  (do f str))
         case (or (regular-character? (car str))
                  (or (char-eq? (car str) $rp)
                     (char-eq? (car str) $*)))
            (cons (car str)
               (do t (cdr str)))
         else
            (cons (car str)
               (do f (cdr str))))

def regular-expression->auto-string str as 
   def str as 
      (add-catenators (remove-spaces str))
   def str as 
      (append "(" 
         (append str ")"))
   ((go f (reverse str)) t) 
   where rec go acc? str is
      (switch (car str)
         case \x (or (char-eq? $* x) (char-eq? $. x))
            (go f (cdr str) \exp \left
               (acc?
                  (go acc? left \e \l
                     (bi (append e (cons (car str) exp)) l))
                  (bi (cons (car str) exp) left)))
         case (char-eq? $lp)
            (bi f str)
         case (char-eq? $+)
            (acc?
               (bi nil str)
               (go t (cdr str) \exp \left
                  (bi (cons $+ exp) left)))
         case (char-eq? $rp)
            (loop nil (cdr str))
            where rec loop done left is 
               (go t left \exp \left
                  (char-eq? (car left) $lp
                     (bi done (cdr left))
                     (loop (append exp done) left)))
         else
            (acc? 
               (go acc? (cdr str) \e \l
                  (bi
                     (append e (enlist (car str)))
                     l))
               (bi 
                  (enlist (car str)) 
                  (cdr str))))

def regular-expression->auto-string str as 
   def str as
      (add-catenators 
         (remove-spaces str)) 
   def str as
      (append "(" (append str ")"))
   (trans t (reverse str) t)
   where rec trans short? str is
         def compile-short as (trans t) 
         def compile-long as (trans f)
            (switch (car str)
               case (char-eq? $.)
                  def exp left from (compile-short (cdr str))
                  def exp as (cons $. exp)
                  (if short? 
                     (bi exp left)
                     def e l from (compile-long left)
                        (bi (append e exp) l))
               case (char-eq? $*)
                  def exp left from (compile-short (cdr str))
                  def exp as (cons $* exp)
                  (if short? 
                     (bi exp left)
                     def e l from (compile-long left)
                        (bi (append e exp) l))
               case (char-eq? $lp)
                  (bi nil str)
               case (char-eq? $+)
                  (short?
                     (bi nil str)
                     (compile-long (cdr str) \exp \left
                        (bi (cons $+ exp) left)))
               case (char-eq? $rp)
                  (loop nil (cdr str))
                  where rec loop done left is 
                     (compile-long left \exp \left
                        (char-eq? (car left) $lp
                           (bi (append exp done) (cdr left))
                           (loop (append exp done) left)))
               else
                  (short?
                     (bi 
                        (enlist (car str)) 
                        (cdr str))
                     (compile-long (cdr str) \e \l
                        (bi
                           (append e (enlist (car str)))
                           l))))

def regex->dfa str as 
   (auto-string->dfa
      (regular-expression->auto-string str))



