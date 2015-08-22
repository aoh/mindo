#include <stdio.h>
#include <stdint.h>

void exit(int status);
void *calloc(size_t number, size_t size);
int strcmp(const char *s1, const char *s2);
int atoi(const char *nptr);

typedef uintptr_t word;

#define wordsize           (sizeof(word))
#define num(x)             ((word) x)
#define ptr(x)             ((word *) x)
#define car(x)             *ptr(x)
#define cdr(x)             *ptr(x+1)
#define push()             tmp = ptr(car(rexp)); car(rexp) = num(rstack); rstack = rexp; rexp = tmp
#define pop()              tmp = rstack; rstack = ptr(car(rstack)); car(tmp) = num(rexp); rexp = tmp
#define popval(to)         pop(); to = ptr(cdr(rexp)); 
#define combp(x)           ptr((num(x) & 1))
#define tagp(x)            ptr((num(x) & 1))
#define ttag(x)            ptr((num(x) ^ 1))
#define mask                2
#define isbit_mark(x)      (num(x) & mask)
#define setbit_mark(x)     (num(x) | mask)
#define unsetbit_mark(x)   (num(x) ^ mask)
#define need(n)            if (nfree < n) { goto recycle; } else { nfree -= n; }
#define get4()             popval(r1); popval(r2); popval(r3); pop(); r4 = ptr(cdr(rexp))
#define get3()             popval(r1); popval(r2); pop(); r3 = ptr(cdr(rexp))
#define get2()             popval(r1); pop(); r2 = ptr(cdr(rexp))
#define consto(reg, a, b)  tmp = rfree; rfree = ptr(cdr(tmp)); car(tmp) = num(a); cdr(tmp) = num(b); reg = tmp
#define tok_s               5
#define tok_k               9
#define tok_i              13
#define tok_b              17
#define tok_c              21
#define tok_t              25
#define tok_y              29
#define tok_sx             33
#define tok_bx             37
#define tok_cx             41
#define tok_p0             45
#define tok_p1             49
#define tok_in             53
#define tok_nil            57

word *Heap;
word *rfree;
word nfree;
word *rt1;

int out_bits, out_chr, in_bits, in_chr;
int heap_size;
int verbose;

void mark(word *this) {
   word *foo;
   word *parent = NULL;
   process: 
      if(combp(this) || isbit_mark(car(this))) {
         goto backtrack;
      } else {   
         foo = ptr(car(this));
         car(this) = setbit_mark(parent);
         parent = ttag(this);
         this = foo;
         goto process;
      }
   backtrack:   
      if (parent == NULL) { 
         return;         
      } else if(tagp(parent)) {
         parent = ttag(parent);
         foo = ptr(cdr(parent));
         cdr(parent) = unsetbit_mark(car(parent));
         car(parent) = setbit_mark(this);
         this = foo;
         goto process;
      } else {
         foo = ptr(cdr(parent));
         cdr(parent) = num(this);
         this = parent;
         parent = foo;
         goto backtrack;
      }
}

void collect_freelist () {
   word *pos = Heap + heap_size - 2;
   rfree = NULL;
   nfree = 0;
   while(pos != Heap ) {
      if(isbit_mark(car(pos))) {
         car(pos) = unsetbit_mark(car(pos));
      } else {
         nfree++;
         cdr(pos) = num(rfree);
         rfree = pos;
      }
      pos -= 2;
   }
   if (verbose) 
      fprintf(stderr, "%dK of %dK used]\n", (((heap_size/2) - nfree)*wordsize*2)/1024, ((heap_size/2)*wordsize*2)/1024);
   if (!rfree) {
      puts("sen: out of heap space.");
      exit(1);
   }
} 

void init (int argc, char *argv[]) {
   int k;
   heap_size = wordsize * 1024 * 256; 
   verbose = 0;
   for (k=1; k<argc; k++) {
      if (strcmp(argv[k], "-H") == 0) {
         heap_size = atoi(argv[++k]) * 1024 * 256;
      } else if (strcmp(argv[k], "-V") == 0) {
         verbose = 1;
      } else if (strcmp(argv[k], "-v") == 0) {
         puts("sen: version 0.23");
         puts("Written by Aki Helin.");
         exit(0);
      } else if (strcmp(argv[k], "-h") == 0) {
         puts("sen: a combinator graph reducer."); 
         puts("options:"); 
         puts("  -H <number> set heap size to <number>Mb"); 
         puts("  -V          be verbose (show GC statistics)"); 
         puts("  -h          show this help"); 
         puts("  -v          show version"); 
         exit(0);
      } else {
         puts("Unknown arguments. Use -h for help.");
         exit(-1);
      }
   }
   Heap  = (word *) calloc(heap_size, sizeof(word *));
   if (!Heap) {
      puts("Unable to allocate initial memory.");
      exit(1);
   }
   out_bits = out_chr = in_bits = in_chr = 0;
   if (verbose) fprintf(stderr, "[init ");
   collect_freelist();
}

word *rdexp () {
   word *this, *tmp;
   switch(getc(stdin)) {
      case 97: { 
         consto(this, tok_nil, tok_nil);
         nfree--;
         car(this) = num(rdexp());
         cdr(this) = num(rdexp());
         break; 
      }
      case 98:  this = ptr(tok_b); break;
      case 99:  this = ptr(tok_c); break;
      case 105: this = ptr(tok_i); break;
      case 107: this = ptr(tok_k); break;
      case 115: this = ptr(tok_s); break;
      case 121: this = ptr(tok_y); break;
      case 116: this = ptr(tok_t); break;
      case 108: this = ptr(tok_bx); break;
      case 110: this = ptr(tok_cx); break;
      case 109: this = ptr(tok_sx); break;
      default: exit(-1);
   }
   return this;
}

word *make_output_handler () {
   word *this, *tmp;
   consto(this, tok_c, tok_i);
   consto(this, this, tok_p1);
   consto(this, tok_c, this);
   consto(this, this, tok_p0);
   return this;
}


int revb (int k) {
   int n = 8, j = 0;
   while (n--) {
      j <<= 1;
      j |= k & 1;
      k >>= 1;
   }
   return j;
}

void eval (word *rexp, word *Heap) {
   word *rstack;
   word *tmp;
   word *r1;
   word *r2;
   word *r3;
   word *r4;
   r1 = r2 = r3 = r4 = rstack = tmp = ptr(tok_nil);
   recurse:
   if(combp(rexp)) {
      switch((word) rexp) {
         case tok_i:
            popval(r1); 
            pop();
            car(rexp) = num(r1);
            push();
            break;
         case tok_k:
            popval(r1);
            pop();
            car(rexp) = tok_i;
            cdr(rexp) = num(r1);
            break;
         case tok_t:
            need(1);
            get2();
            car(rexp) = num(r1);
            consto(r1, r1, r2);
            cdr(rexp) = num(r1);
            push();
            break;
         case tok_b:
            need(1);
            get3();
            car(rexp) = num(r1);
            consto(r2, r2, r3);
            cdr(rexp) = num(r2);
            push();
            break;
         case tok_c:
            need(1);
            get3();
            consto(r1, r1, r3);
            car(rexp) = num(r1);
            cdr(rexp) = num(r2);
            break;
         case tok_bx:
            need(2);
            get4();
            car(rexp) = num(r1);
            consto(r3, r3, r4);
            consto(r2, r2, r3);
            cdr(rexp) = num(r2);
            push();
            break;
         case tok_cx:
            need(2);
            get4();
            consto(r2, r2, r4);
            consto(r1, r1, r2);
            car(rexp) = num(r1);
            cdr(rexp) = num(r3);
            push();
            push();
            break;
         case tok_sx:
            need(3);
            get4();
            consto(r2, r2, r4);
            consto(r1, r1, r2);
            car(rexp) = num(r1);
            consto(r3, r3, r4);
            cdr(rexp) = num(r3);
            push();
            push();
            break;
         case tok_s:
            need(2);
            get3();
            consto(r1, r1, r3);
            consto(r2, r2, r3);
            car(rexp) = num(r1);
            cdr(rexp) = num(r2);
            push();
            push();
            break;
         case tok_p1:
            need(5);
            out_chr++;
            goto handle_output;
            break;
         case tok_p0:
            need(5);
            goto handle_output;
            break;
         case tok_y:
            pop();
            car(rexp) = cdr(rexp);
            cdr(rexp) = num(rexp);
            break;
         case tok_in:
            need(6);
            goto handle_input;
            break;
         default:
            puts("aborting on unknown combinator");
            exit(-1);
      }
      goto recurse; 
      handle_output: 
         out_bits++;
         popval(rexp);
         // make_output_handler(); // uses 4
         rt1 = make_output_handler();
         consto(rexp, rexp, rt1);
         if (out_bits == 8) {
            putchar(revb(out_chr));
            fflush(stdout);
            out_bits = out_chr = 0;
         } else {
            out_chr <<= 1;
         }
      goto recurse;
      handle_input: 
         popval(rexp);
         if (in_bits == 0) {
            in_chr = getchar();
            in_bits = 8;
            if (in_chr < 0) exit(0);
         }
         consto(rt1, tok_c, tok_i);
         if (in_chr & 1) {
            consto(rt1, rt1, tok_k);
         } else {
            consto(r2, tok_k, tok_i);
            consto(rt1, rt1, r2);
         }
         consto(rt1, tok_c, rt1);
         consto(rt1, rt1, tok_in);
         in_chr >>= 1;
         in_bits--;
         consto(rexp, rt1, rexp);
      goto recurse;
      recycle:
         if (verbose) fprintf(stderr, "[mark "); 
         mark(rexp);
         mark(rt1);
         mark(r1);
         mark(r2);
         mark(r3);
         mark(r4);
         mark(rstack);
         if (verbose) fprintf(stderr, "link "); 
         collect_freelist();
      goto recurse;
   } else {
      push();
      goto recurse;
   }
}

int main (int argc, char *argv[]) {
   word *program, *tmp;
   init(argc, argv);
   program = rdexp();
   nfree -= 6;
   consto(program, program, tok_in);
   rt1 = make_output_handler();
   consto(program, program, rt1);
   eval(program, Heap);
   exit(0);
}

