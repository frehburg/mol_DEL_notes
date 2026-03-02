#import "utils/progress_bar.typ": *
#import "@preview/clean-math-paper:0.2.4": *
#import "examples/themes/filips-math-paper/template.typ": paper
#import "@preview/curryst:0.5.1": rule, prooftree
#import "utils/callout.typ": callout, intuition, example, theorem, proof, attention, remember, question, info, note, notation,
#import "utils/def.typ": def, def-group
#import "@preview/diagraph:0.3.6": *
#import "utils/splitgrid.typ": splitgrid
#import "utils/dot-graphviz.typ": graph-figure

#set page(
  header: context {
    // Hide header if we are on page 1
    if counter(page).get().first() > 1 {
      grid(
        columns: (1fr, 1fr),
        align(left)[Filip Rehburg],
        align(right)[DEL Homework 1],
      )
    }
  },
  footer: context {align(center)[
    #counter(page).display()
  ]},
  margin: (top: 3cm, bottom: 2cm)
)

#set par(justify: true)
#set enum(numbering: "1.")
#set heading(numbering: "1.")

#show heading.where(level: 1): it => {
  if it.body != [List of Definitions] and it.body != [List of Theorems] {
    pagebreak(weak: true)
  }
  block(it.body)
}
#show heading.where(level: 2): it => {
  let nums = counter(heading).at(it.location())
  let lvl1 = nums.at(0)
  let lvl2 = nums.at(1)
  
  block[
    #it.body
  ]
}

#set heading(numbering: (..n) => {
  let p = n.pos()
  if p.len() < 3 { numbering("1.1", ..p) } else { numbering("A.1.a.i", ..p.slice(2)) }
})
#set math.equation(numbering: "(1)")

#let split_equal = (47.5%,47.5%,)

// general math symbols
#let bar(x) = $macron(#x)$ //gr MACRON
#let powerset(set_) = $cal(P)(#set_)$

// DEL symbols
#let epistemic_op(base: "K", formula: $phi$, sup: none, inf: none) = {
  if sup == none {
    sup = ""
  }

  if inf == none {
    inf = ""
  }
  
  $base^sup_inf #h(0pt) formula$
}
#let Prop = $"Prop"$

#let knowledge(formula, sup: none, inf: none) = epistemic_op(base: "K", formula: formula, sup: sup, inf: inf)
#let belief(formula, sup: none, inf: none) = epistemic_op(base: "B", formula: formula, sup: sup, inf: inf)
#let common-knowledge(formula, sup: none, inf: none) = epistemic_op(base: $C square$, formula: formula, sup: sup, inf: inf)
#let common-k(formula, sup: none, inf: none) = epistemic_op(base: $C k$, formula: formula, sup: sup, inf: inf) // this one uses k to explicitly denote knowledge, differentiating from common true belief.
#let common-belief(formula, sup: none, inf: none) = epistemic_op(base: $C b$, formula: formula, sup: sup, inf: inf)
#let distributed-knowledge(formula, sup: none, inf: none) = epistemic_op(base: $D square$, formula: formula, sup: sup, inf: inf)
#let distributed-k(formula, sup: none, inf: none) = epistemic_op(base: $D k$, formula: formula, sup: sup, inf: inf)
#let interpretation(formula) = $norm(#formula)$
#let box-kripke(formula) = $[formula]$
#let diamond-kripke(formula) = $chevron.l formula chevron.r$
#let actual_state = $s_star$
#let transition(alpha, inf: none) = $scripts(arrow)^#alpha _#inf$
#let model = $bold("S")$

#let iff = $arrow.r.l.double$

// logics
#let S4 = $bold("S4")$
#let S5 = $bold("S5")$
#let K45 = $bold("K45")$
#let KD45 = $bold("KD45")$

== Homework 1

by Filip Rehburg

This homework is worth 100 points in total. This homework is *individual* (so, *no collaboration*!). Please *type in capital letters your full name*. Your answers should be *typed* as PDF, except for the drawings, which can scanned hand-drawings integrated with your pdf.

+ _(35 points)_ A non-standard version of the so-called _Singapore Problem_ goes as follows:

  Albert and Bernard just met Cheryl. "When is your birthday?" Albert asks Cheryl.
  Cheryl thinks a second and says, "Boys, I'm not going to tell you this, but I'll give you some clues, see how smart you are. Then I'll go out on a date with whoever of you finds the answer first".
  Then she writes down a list of 10 dates:

  _May 15, May 16, May 19, June 14, July 17, July 18, August 14, August 15, August 17, September 14, September 16._

  "My birthday is one of these," she tells them. "Now I am going to tell to one of you the month (and only the month) of my birthday, and tell to the other the day (and only the day) of my birthday."
  Then Cheryl whispers in Albert's ear the month (and only the month) of her birthday.
  To Bernard, she whispers the day (and only the day).

  "Do you think that Albert can figure our my exact birthday now?" she asks Bernard.

  Bernard: "Huh! I know for sure that Albert doesn't know when it is!"

  Albert (after hearing Bernard's statement): "Yes, but I also I know that right now poor Bernard doesn't know it either!"

  Bernard (after listening to Albert(: "Well, well, guess what: now I know your birthday, but... I also know that Albert knows it too! So hmm, you won't go out with either of us then?! Do you have another test for us? Or shall we throw a fair coin??""

  The problem is: _When is Cheryl's birthday?_

  (a) _(7 points)_ First, start by representing (drawing) the epistemic situation immediately after Cheryl gives the boys their pieces of information (but before she starts questioning them). Represent all the facts, as well as each agent's knowledge in this situation, using a Kripke model M with three agents $cal(A) = {"Albert", "Bernard", "Cheryl"}$ and ten atomic propositions 
  
  $ Prop = {"May", "June", "July", "August", "September", 14, 15, 16, 17, 18, 19}, $ 
  
  where the first four indicate "Cheryl's birthday is in month $x''$" and the others indicate "Cheryl's birthday is in day y". (You may disregard all the information about going out on a date, that is just for fun.) *Draw the model (as a graph)*, don't just describe it in words or formulas!
  #let Jn = $"Jn"$
  #let Jl = $"Jl"$
  #callout(title: "Answer to Exercise 1. (a)")[
    Let 

    $ cal(A) = {a, b, c} \ Prop_M = {M, Jn, Jl, A, S} \ Prop_D = {14, 15, 16, 17, 18, 19}\ Prop = Prop_M union Prop_D \ S = {(M,15), (M,16), (M,19), (Jn,14), (Jl,17), (Jl,18), (A,14), (A,15), (A,17), (S,14), (S,16)}$

    It is common knowledge that $a$ knows the birthday month and $b$ knows the date. $#common-k($(or.big_(m in Prop_M) #knowledge($m$, inf: $a$))$) and #common-k($(or.big_(d in Prop_D) #knowledge($d$, inf: $b$))$, inf:$a,b,c,$)$.

    The following is a graph describing epistemic model $#model = (S, {tilde_alpha}_(alpha in cal(A)), #interpretation($dot$))$. Since this is an epistemic #S5 model, all relations are reflexive, transitive, and thus symmetric. Reflexive and transitive arrows are omitted for visual clarity. Since Cheryl $c$ knows her own birthday, all worlds form their own equivalence class under $tilde_c$ ($forall s=(m,d), t=(m^prime, d^prime) in S: s tilde_c t arrow.r.l.double (m = m^prime and d = d^prime)$).

    #graph-figure(
      ```dot
      digraph Grid {
        // Basic node styling
        splines = line;
        node [shape=square, style=rounded, width=0.6, fixedsize=true];
        edge [penwidth=1, arrowhead=vee, arrowtail=vee];
        ranksep = 0.5; // Slightly increased so labels don't clip lines
        nodesep = 0.5;

        // 1. Define nodes and assign them to rigid vertical groups (columns)
        n00 [label="", style=invis, group=c1];
        Jn14 [label="Jn,14", group=c1];
        A14 [label="A,14", group=c1];
        S14 [label="S,14", group=c1];
        
        M15 [label="M,15", group=c2];
        A15 [label="A,15", group=c2];
        
        M16 [label="M,16", group=c3];
        S16 [label="S,16", group=c3];
        
        n13 [label="", style=invis, group=c4];
        Jl17 [label="Jl,17", group=c4];
        A17 [label="A,17", group=c4];
        n43 [label="", style=invis, group=c4];
        
        n14 [label="", style=invis, group=c5];
        Jl18 [label="Jl,18", group=c5];
        n34 [label="", style=invis, group=c5];
        n44 [label="", style=invis, group=c5];
        
        M19 [label="M,19", group=c6];
        n15 [label="", style=invis, group=c6];
        n25 [label="", style=invis, group=c6];
        n35 [label="", style=invis, group=c6];
        n45 [label="", style=invis, group=c6];

        // 2. Force horizontal alignment for each row
        { rank=same; n00; M15; M16; M19; }
        { rank=same; Jn14; n13; n14; n15; }
        { rank=same; Jl17; Jl18; n25; }
        { rank=same; A14; A15; A17; n34; n35; }
        { rank=same; S14; S16; n43; n44; n45; }

        // 3. Horizontal edges (Rows) - Mixing visible and invisible structural ties
        n00 -> M15 [style=invis];
        M15 -> M16 -> M19 [label="a", dir=both]; 
        
        n13 -> n14 -> n15 [style=invis];
        
        Jl17 -> Jl18 [label="a", dir=both];
        Jl18 -> n25 [style=invis];
        
        A14 -> A15 [label="a", dir=both]; A15 -> A17 [taillabel="a", dir=both, labeldistance=8.0, labelangle=8];
        A17 -> n34 -> n35 [style=invis];
        
        S14 -> S16 [label="a", dir=both];
        S16 -> n43 -> n44 -> n45 [style=invis];

        // 4. Vertical edges (Columns) - Mixing visible and invisible structural ties
        n00 -> Jn14 [style=invis];
        Jn14 -> A14 -> S14 [label=" b", dir=both];
        
        M15 -> A15 [label=" b", dir=both];
        
        M16 -> S16 [label=" b", dir=both];
        
        n13 -> Jl17 [style=invis];
        Jl17 -> A17 [label=" b", dir=both];
        A17 -> n43 [style=invis];
        
        n14 -> Jl18 -> n34 -> n44 [style=invis];
        
        M19 -> n15 -> n25 -> n35 -> n45 [style=invis];
    }
      ```
    )
  ]
  
  (b) _(7 points)_ As for the Muddy Children, write down an epistemic sentence encoding Bernard's first announcement (that he knows Albert doesn't know when her birthday is). As for the Muddy Children, interpret Bernard's first announcement as a truthful public announcement, and represent (draw) the updated model M' after this update.

  #callout(title: "Answer to Exercise 1. (b)")[
    #let hw1ex1announcement1 = $and.big_((m,d) in S) (not #knowledge($(m and d)$, inf:$a$))$
    Bernards first announcement encoded as an epistemic sentence is: 
    $ phi_1 =  #knowledge($(hw1ex1announcement1)$,inf:$b$) $

    // Eliminations:
    // 1. $(Jn, 14)$. _Reason_: If it were $Jn$, $a$ would know $(Jn, 14)$. Thus $b$ knows its not $Jn$.
    // 2. $(A,14), (S,14)$. Since $b$ knows its not $14$.

    The updated model $#model^prime$:
    #graph-figure(
      ```dot
      digraph Grid {
            // Basic node styling
            splines = line;
            node [shape=square, style=rounded, width=0.6, fixedsize=true];
            edge [penwidth=1, arrowhead=vee, arrowtail=vee];
            ranksep = 0.5; // Slightly increased so labels don't clip lines
            nodesep = 0.5;

            // 1. Define nodes and assign them to rigid vertical groups (columns)
            n00 [label="", style=invis, group=c1];
            Jn14 [label="", style=invis, group=c1];
            A14 [label="", style=invis, group=c1];
            S14 [label="", style=invis, group=c1];
            
            M15 [label="M,15", group=c2];
            A15 [label="A,15", group=c2];
            
            M16 [label="M,16", group=c3];
            S16 [label="S,16", group=c3];
            
            n13 [label="", style=invis, group=c4];
            Jl17 [label="Jl,17", group=c4];
            A17 [label="A,17", group=c4];
            n43 [label="", style=invis, group=c4];
            
            n14 [label="", style=invis, group=c5];
            Jl18 [label="Jl,18", group=c5];
            n34 [label="", style=invis, group=c5];
            n44 [label="", style=invis, group=c5];
            
            M19 [label="M,19", group=c6];
            n15 [label="", style=invis, group=c6];
            n25 [label="", style=invis, group=c6];
            n35 [label="", style=invis, group=c6];
            n45 [label="", style=invis, group=c6];

            // 2. Force horizontal alignment for each row
            { rank=same; n00; M15; M16; M19; }
            { rank=same; Jn14; n13; n14; n15; }
            { rank=same; Jl17; Jl18; n25; }
            { rank=same; A14; A15; A17; n34; n35; }
            { rank=same; S14; S16; n43; n44; n45; }

            // 3. Horizontal edges (Rows) - Mixing visible and invisible structural ties
            n00 -> M15 [style=invis];
            M15 -> M16 -> M19 [label="a", dir=both]; 
            
            n13 -> n14 -> n15 [style=invis];
            
            Jl17 -> Jl18 [label="a", dir=both];
            Jl18 -> n25 [style=invis];
            
            A14 -> A15 [style=invis, dir=both]; A15 -> A17 [taillabel="a", dir=both, labeldistance=8.0, labelangle=8];
            A17 -> n34 -> n35 [style=invis];
            
            S14 -> S16 [style=invis];
            S16 -> n43 -> n44 -> n45 [style=invis];

            // 4. Vertical edges (Columns) - Mixing visible and invisible structural ties
            n00 -> Jn14 [style=invis];
            Jn14 -> A14 [style=invis]; A14 -> S14 [style=invis];
            
            M15 -> A15 [label=" b", dir=both];
            
            M16 -> S16 [label=" b", dir=both];
            
            n13 -> Jl17 [style=invis];
            Jl17 -> A17 [label=" b", dir=both];
            A17 -> n43 [style=invis];
            
            n14 -> Jl18 -> n34 -> n44 [style=invis];
            
            M19 -> n15 -> n25 -> n35 -> n45 [style=invis];
        }
      ```)
  ]

  (c) _(7 points)_ Do the same as in previous part for Albert's first announcement (that now he also knows that Bernard doesn't know Cheryl's birthday): encode his statement as an epistemic sentence, and represent (draw) the updated model $M''$ after this new update.

  #callout(title: "Answer to Exercise 1. (c)")[
    #let hw1ex1announcement1 = $#knowledge($and.big_((m,d) in S) (not (m and d))$, inf:$a$)$
    #let hw1ex1announcement2 = $and.big_((m,d) in S) (not #knowledge($(m and d)$, inf:$b$))$
    Albert's first announcement encoded as an epistemic sentence is: 
    $ psi_1 =  (#hw1ex1announcement1) and (#knowledge($hw1ex1announcement2$,inf:$a$)) $

    // Eliminations:
    // 3. $(M, 19)$. _Reason_: If it were $19$, $b$ would know $(M, 19)$. Thus $b$ knows it's not $19$. Also, $a$ knows it's not $M$.
    // + $(M,15), (M,16)$. _Reason_: $a$ knows it's not $M$.
    // + $(Jl, 18)$. _Reason_: If it were $18$, $b$ would know $(Jl, 18)$. Thus $b$ knows it's not $18$.
    // + $(Jl, 17)$. _Reason_: todo

    The updated model $#model^prime.double$:
    #v(-12em)
    #graph-figure(
      ```dot
      digraph Grid {
            // Basic node styling
            splines = line;
            node [shape=square, style=rounded, width=0.6, fixedsize=true];
            edge [penwidth=1, arrowhead=vee, arrowtail=vee];
            ranksep = 0.5; // Slightly increased so labels don't clip lines
            nodesep = 0.5;

            // 1. Define nodes and assign them to rigid vertical groups (columns)
            n00 [label="", style=invis, group=c1];
            Jn14 [label="", style=invis, group=c1];
            A14 [style=invis, label="", group=c1];
            S14 [style=invis, label="", group=c1];
            
            M15 [label="", style=invis, group=c2];
            A15 [label="A,15", group=c2];
            
            M16 [label="", style=invis, group=c3];
            S16 [label="S,16", group=c3];
            
            n13 [label="", style=invis, group=c4];
            Jl17 [label="", style=invis, group=c4];
            A17 [label="A,17", group=c4];
            n43 [label="", style=invis, group=c4];
            
            n14 [label="", style=invis, group=c5];
            Jl18 [label="", style=invis, group=c5];
            n34 [label="", style=invis, group=c5];
            n44 [label="", style=invis, group=c5];
            
            M19 [label="", style=invis, group=c6];
            n15 [label="", style=invis, group=c6];
            n25 [label="", style=invis, group=c6];
            n35 [label="", style=invis, group=c6];
            n45 [label="", style=invis, group=c6];

            // 2. Force horizontal alignment for each row
            { rank=same; n00; M15; M16; M19; }
            { rank=same; Jn14; n13; n14; n15; }
            { rank=same; Jl17; Jl18; n25; }
            { rank=same; A14; A15; A17; n34; n35; }
            { rank=same; S14; S16; n43; n44; n45; }

            // 3. Horizontal edges (Rows) - Mixing visible and invisible structural ties
            n00 -> M15 [style=invis];
            M15 -> M16 [label="", dir=both, style=invis,]; M16 -> M19 [style=invis]; 
            
            n13 -> n14 -> n15 [style=invis];
            
            Jl17 -> Jl18 [style=invis];
            Jl18 -> n25 [style=invis];
            
            A14 -> A15 [style=invis, label="", dir=both]; A15 -> A17 [label="a", dir=both];
            A17 -> n34 -> n35 [style=invis];
            
            S14 -> S16 [style=invis, label="", dir=both];
            S16 -> n43 -> n44 -> n45 [style=invis];

            // 4. Vertical edges (Columns) - Mixing visible and invisible structural ties
            n00 -> Jn14 [style=invis];
            Jn14 -> A14 [style=invis]; A14 -> S14 [style=invis, label="", dir=both];
            
            M15 -> A15 [label=" ", style=invis, dir=both];
            
            M16 -> S16 [label=" ", style=invis, dir=both];
            
            n13 -> Jl17 [style=invis];
            Jl17 -> A17 [label="", style=invis, dir=both];
            A17 -> n43 [style=invis];
            
            n14 -> Jl18 -> n34 -> n44 [style=invis];
            
            M19 -> n15 -> n25 -> n35 -> n45 [style=invis];
        }
      ```)
  ]

  (d) _(7 points)_ Do the same for Bernard's second announcement (that now he knows the birthday, but that he also knows that Albert knows the birthday as well), computing the updated model $M''$ Use this to solve the puzzle: when is Cheryl's birthday?

  #callout(title: "Answer to Exercise 1. (d)")[
    Bernard's second announcement encoded as an epistemic sentence is:
    $ phi_2 = (or.big_((m,d) in S) #knowledge($(m and d)$, inf:$b$) and #knowledge($(or.big_((m,d) in S) #knowledge($(m and d)$, inf:$a$))$, inf: $b$)) $

    // Eliminations:
    // 3. $(M, 19)$. _Reason_: If it were $19$, $b$ would know $(M, 19)$. Thus $b$ knows it's not $19$. Also, $a$ knows it's not $M$.
    // + $(M,15), (M,16)$. _Reason_: $a$ knows it's not $M$.
    // + $(Jl, 18)$. _Reason_: If it were $18$, $b$ would know $(Jl, 18)$. Thus $b$ knows it's not $18$.
    // + $(Jl, 17)$. _Reason_: todo

    From $#model^prime.double$ we can deduce that $c$'s birthday is September the 16th ($#actual_state = (S,16)$).
  ]

  (e) _(7 points)_ Write a sentence in the language of Public Announcement Logic (PAL) saying that: "after Bernard's first announcement, followed by Albert's first announcement, Bernard knows Cheryl's birthday and he also knows that Albert knows it".

  #callout(title: "Answer to Exercise 1. (e)")[
      $!#box-kripke($phi_1$)!#box-kripke($psi_1$)phi_2$
  ]

+ _(35 points)_ Alice and Bob have each some positive natural number $n_a, n_b in {1,2,...,12}$ written on their forehead. It is common knowledge that 
  + each of them can see the other's number (Alice can see $n_b$ and Bob can see $n_a$), but neither of them can see his/her number; 
  + the two children are perfect logicians. 
  + both numbers are no larger than 12 (i.e. $1 <= n_a, n_b <= 12$); 
  + the two numbers are related by the function $g: NN -> NN$ given by: $g(n)=1$, if $n=2^k$ for some $k>0$; $g(n)=n+2$, if n is odd; $g(n)=n-2$ if n is even but not a power of 2.
  $ g(n) = cases(1 "if" n=2^k "for some"  k>0,n+2 "if n is odd", n-2 "if "n" is even, but not a power of two") $
  4. So it is common knowledge that either $n_a=g(n_b)$ or else $n_b=g(n_a)$.

The Father asks them, repeatedly: "Do you know your own number?". The two are supposed to answer truthfully, publicly, simultaneously (without any other communication). They both answer "I don't know" to the first 3 questions, after which Alice answers "Yes, now I know my number" to the 4th question (while Bob still answers "I don't know").

  (a) _(10 points)_ What is Alice's number?
  #callout(title: "Answer to Exercise 2 (a)")[
    $a$ has the number $3$ written on their forehead.
    
    $ n_a = 3 $
  ]
  (b) _(5 points)_ Will Bob ever know his number (without looking in the mirror or being told the number by Alice)? If so, when will he answer "I know my number"?
  #callout(title: "Answer to Exercise 2 (a)")[
    $b$ will never know his number (without looking in the mirror or being told the number by $a$.
  ]

  (c) _(20 points)_ Prove your conclusions in (a) and (b) semantically, by drawing the initial epistemic model, then applying repeated updates with the (semantic information conveyed by the) children's answers. Draw each intermediary model, and explain your conclusions.
  #callout(title: "Answer to Exercise 2 (c): Initial Situation")[
    #splitgrid((40%,auto))[All values of $g(n)$ computed: $ n &= 1, g(n) = 3 quad n = 2, g(n) = 1 \ n &= 3, g(n) = 5 quad n = 4, g(n) = 1 \ n &= 5, g(n) = 7 quad n = 6, g(n) = 4 \ n &= 7, g(n) = 9 quad n = 8, g(n) = 1 \ n &= 9, g(n) = 11 quad n = 10, g(n) = 8 \ n &= 11, g(n) = 13 > 12 arrow.zigzag \ n &= 12, g(n) = 10 $
    Denote by $G_i (n_y)$ the set of possible values for $n_x$ upon seeing $n_y$ under $g$ after announcement round $i$, where either $x = a$ and $y=b$ or vice versa.][ 
      #v(-4em)
      #scale(70%)[
      #table(columns: (20%,auto,auto,auto,auto),[],table.cell(colspan: 4)[*possible values for $n_x$*],[*$x$ sees*],[$i = 0$],[$i=1$],[$i=2$],[$i=3$],
      [$n_y=1$],[${2,3,4,8}$],[${3,4,8}$],[${3,8}$],[${3}$],
      [$n_y=2$],[${1}$],[$emptyset$],[$emptyset$],[$emptyset$],
      [$n_y=3$],[${1,5}$],[${1,5}$],[${1,5}$],[${1,5}$],
      [$n_y=4$],[${1,6}$],[${1}$],[$emptyset$],[$emptyset$],
      [$n_y=5$],[${3,7}$],[${3,7}$],[${3}$],[${3}$],
      [$n_y=6$],[${4}$],[$emptyset$],[$emptyset$],[$emptyset$],
      [$n_y=7$],[${5,9}$],[${5,9}$],[${5}$],[$emptyset$],
      [$n_y=8$],[${1,10}$],[${1,10}$],[${1}$],[$emptyset$],
      [$n_y=9$],[${7,11}$],[${7}$],[$emptyset$],[$emptyset$],
      [$n_y=10$],[${8,12}$],[${8}$],[$emptyset$],[$emptyset$],[$n_y=11$],[${9}$],[$emptyset$],[$emptyset$],[$emptyset$],
      [$n_y=12$],[${10}$],[$emptyset$],[$emptyset$],[$emptyset$])
    ]]
    #v(-3.5em)
    // I fought with dot for a long time but the edges just don't want to be straight lines. So it looks ugly but it contains the right information. 
    
    $#model$:
    
    #v(-23em)
    #scale(38%)[#graph-figure(
      ```dot
      digraph Grid12x12 {
    splines = line;
    node [shape=square, style=rounded, width=1, fixedsize=true, fontsize=25];
    edge [penwidth=1, arrowhead=vee, arrowtail=vee, fontsize=25];
    ranksep = 0.4; // Slightly increased so labels don't clip lines
    nodesep = 0.3;

        // Visible nodes with x_a^* y_b labels
    a1b3 [label="1_a^* 3_b"];
    a2b1 [label="2_a^* 1_b"];
    a3b5 [label="3_a^* 5_b"];
    a4b1 [label="4_a^* 1_b"];
    a5b7 [label="5_a^* 7_b"];
    a6b4 [label="6_a^* 4_b"];
    a7b9 [label="7_a^* 9_b"];
    a8b1 [label="8_a^* 1_b"];
    a9b11 [label="9_a^* 11_b"];
    a10b8 [label="10_a^* 8_b"];
    a12b10 [label="12_a^* 10_b"];

    // Visible nodes with x_a y^*_b labels
    a3b1 [label="3_a 1^*_b"];
    a1b2 [label="1_a 2^*_b"];
    a5b3 [label="5_a 3^*_b"];
    a1b4 [label="1_a 4^*_b"];
    a7b5 [label="7_a 5^*_b"];
    a4b6 [label="4_a 6^*_b"];
    a9b7 [label="9_a 7^*_b"];
    a1b8 [label="1_a 8^*_b"];
    a11b9 [label="11_a 9^*_b"];
    a8b10 [label="8_a 10^*_b"];
    a10b12 [label="10_a 12^*_b"];

    // Set invisible attributes for nodes not in the list
    a1b1 [style=invis, label=""];
    a1b5 [style=invis, label=""];
    a1b6 [style=invis, label=""];
    a1b7 [style=invis, label=""];
    a1b9 [style=invis, label=""];
    a1b10 [style=invis, label=""];
    a1b11 [style=invis, label=""];
    a1b12 [style=invis, label=""];

    a2b2 [style=invis, label=""];
    a2b3 [style=invis, label=""];
    a2b4 [style=invis, label=""];
    a2b5 [style=invis, label=""];
    a2b6 [style=invis, label=""];
    a2b7 [style=invis, label=""];
    a2b8 [style=invis, label=""];
    a2b9 [style=invis, label=""];
    a2b10 [style=invis, label=""];
    a2b11 [style=invis, label=""];
    a2b12 [style=invis, label=""];

    a3b2 [style=invis, label=""];
    a3b3 [style=invis, label=""];
    a3b4 [style=invis, label=""];
    a3b6 [style=invis, label=""];
    a3b7 [style=invis, label=""];
    a3b8 [style=invis, label=""];
    a3b9 [style=invis, label=""];
    a3b10 [style=invis, label=""];
    a3b11 [style=invis, label=""];
    a3b12 [style=invis, label=""];

    a4b2 [style=invis, label=""];
    a4b3 [style=invis, label=""];
    a4b4 [style=invis, label=""];
    a4b5 [style=invis, label=""];
    a4b7 [style=invis, label=""];
    a4b8 [style=invis, label=""];
    a4b9 [style=invis, label=""];
    a4b10 [style=invis, label=""];
    a4b11 [style=invis, label=""];
    a4b12 [style=invis, label=""];

    a5b1 [style=invis, label=""];
    a5b2 [style=invis, label=""];
    a5b4 [style=invis, label=""];
    a5b5 [style=invis, label=""];
    a5b6 [style=invis, label=""];
    a5b8 [style=invis, label=""];
    a5b9 [style=invis, label=""];
    a5b10 [style=invis, label=""];
    a5b11 [style=invis, label=""];
    a5b12 [style=invis, label=""];

    a6b1 [style=invis, label=""];
    a6b2 [style=invis, label=""];
    a6b3 [style=invis, label=""];
    a6b5 [style=invis, label=""];
    a6b6 [style=invis, label=""];
    a6b7 [style=invis, label=""];
    a6b8 [style=invis, label=""];
    a6b9 [style=invis, label=""];
    a6b10 [style=invis, label=""];
    a6b11 [style=invis, label=""];
    a6b12 [style=invis, label=""];

    a7b1 [style=invis, label=""];
    a7b2 [style=invis, label=""];
    a7b3 [style=invis, label=""];
    a7b4 [style=invis, label=""];
    a7b6 [style=invis, label=""];
    a7b7 [style=invis, label=""];
    a7b8 [style=invis, label=""];
    a7b10 [style=invis, label=""];
    a7b11 [style=invis, label=""];
    a7b12 [style=invis, label=""];

    a8b2 [style=invis, label=""];
    a8b3 [style=invis, label=""];
    a8b4 [style=invis, label=""];
    a8b5 [style=invis, label=""];
    a8b6 [style=invis, label=""];
    a8b7 [style=invis, label=""];
    a8b8 [style=invis, label=""];
    a8b9 [style=invis, label=""];
    a8b11 [style=invis, label=""];
    a8b12 [style=invis, label=""];

    a9b1 [style=invis, label=""];
    a9b2 [style=invis, label=""];
    a9b3 [style=invis, label=""];
    a9b4 [style=invis, label=""];
    a9b5 [style=invis, label=""];
    a9b6 [style=invis, label=""];
    a9b8 [style=invis, label=""];
    a9b9 [style=invis, label=""];
    a9b10 [style=invis, label=""];
    a9b12 [style=invis, label=""];

    a10b1 [style=invis, label=""];
    a10b2 [style=invis, label=""];
    a10b3 [style=invis, label=""];
    a10b4 [style=invis, label=""];
    a10b5 [style=invis, label=""];
    a10b6 [style=invis, label=""];
    a10b7 [style=invis, label=""];
    a10b9 [style=invis, label=""];
    a10b10 [style=invis, label=""];
    a10b11 [style=invis, label=""];

    a11b1 [style=invis, label=""];
    a11b2 [style=invis, label=""];
    a11b3 [style=invis, label=""];
    a11b4 [style=invis, label=""];
    a11b5 [style=invis, label=""];
    a11b6 [style=invis, label=""];
    a11b7 [style=invis, label=""];
    a11b8 [style=invis, label=""];
    a11b10 [style=invis, label=""];
    a11b11 [style=invis, label=""];
    a11b12 [style=invis, label=""];

    a12b1 [style=invis, label=""];
    a12b2 [style=invis, label=""];
    a12b3 [style=invis, label=""];
    a12b4 [style=invis, label=""];
    a12b5 [style=invis, label=""];
    a12b6 [style=invis, label=""];
    a12b7 [style=invis, label=""];
    a12b8 [style=invis, label=""];
    a12b9 [style=invis, label=""];
    a12b11 [style=invis, label=""];
    a12b12 [style=invis, label=""];

    { rank=same; a1b1; a1b2; a1b3; a1b4; a1b5; a1b6; a1b7; a1b8; a1b9; a1b10; a1b11; a1b12; }
    { rank=same; a2b1; a2b2; a2b3; a2b4; a2b5; a2b6; a2b7; a2b8; a2b9; a2b10; a2b11; a2b12; }
    { rank=same; a3b1; a3b2; a3b3; a3b4; a3b5; a3b6; a3b7; a3b8; a3b9; a3b10; a3b11; a3b12; }
    { rank=same; a4b1; a4b2; a4b3; a4b4; a4b5; a4b6; a4b7; a4b8; a4b9; a4b10; a4b11; a4b12; }
    { rank=same; a5b1; a5b2; a5b3; a5b4; a5b5; a5b6; a5b7; a5b8; a5b9; a5b10; a5b11; a5b12; }
    { rank=same; a6b1; a6b2; a6b3; a6b4; a6b5; a6b6; a6b7; a6b8; a6b9; a6b10; a6b11; a6b12; }
    { rank=same; a7b1; a7b2; a7b3; a7b4; a7b5; a7b6; a7b7; a7b8; a7b9; a7b10; a7b11; a7b12; }
    { rank=same; a8b1; a8b2; a8b3; a8b4; a8b5; a8b6; a8b7; a8b8; a8b9; a8b10; a8b11; a8b12; }
    { rank=same; a9b1; a9b2; a9b3; a9b4; a9b5; a9b6; a9b7; a9b8; a9b9; a9b10; a9b11; a9b12; }
    { rank=same; a10b1; a10b2; a10b3; a10b4; a10b5; a10b6; a10b7; a10b8; a10b9; a10b10; a10b11; a10b12; }
    { rank=same; a11b1; a11b2; a11b3; a11b4; a11b5; a11b6; a11b7; a11b8; a11b9; a11b10; a11b11; a11b12; }
    { rank=same; a12b1; a12b2; a12b3; a12b4; a12b5; a12b6; a12b7; a12b8; a12b9; a12b10; a12b11; a12b12; }

    // Horizontal edges (Row 1)
    a1b2 -> a1b3 [dir=both, label="a", headport=w, tailport=e];
    a1b3 -> a1b4 [dir=both, label="a",headport=w, tailport=e];
    a1b4 -> a1b8 [dir=both, label="a"];

    //inactive
    a1b1 -> a1b2 [dir=both, style=invis, label=""];
    a1b4 -> a1b5 [dir=both, style=invis, label=""];
    a1b5 -> a1b6 [dir=both, style=invis, label=""];
    a1b6 -> a1b7 [dir=both, style=invis, label=""];
    a1b7 -> a1b8 [dir=both, style=invis, label=""];
    a1b8 -> a1b9 [dir=both, style=invis, label=""];
    a1b9 -> a1b10 [dir=both, style=invis, label=""];
    a1b10 -> a1b11 [dir=both, style=invis, label=""];
    a1b11 -> a1b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 2)
    a2b1 -> a2b2 [dir=both, style=invis, label=""];
    a2b2 -> a2b3 [dir=both, style=invis, label=""];
    a2b3 -> a2b4 [dir=both, style=invis, label=""];
    a2b4 -> a2b5 [dir=both, style=invis, label=""];
    a2b5 -> a2b6 [dir=both, style=invis, label=""];
    a2b6 -> a2b7 [dir=both, style=invis, label=""];
    a2b7 -> a2b8 [dir=both, style=invis, label=""];
    a2b8 -> a2b9 [dir=both, style=invis, label=""];
    a2b9 -> a2b10 [dir=both, style=invis, label=""];
    a2b10 -> a2b11 [dir=both, style=invis, label=""];
    a2b11 -> a2b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 3)
    a3b1 -> a3b5 [dir=both, label="a"];
    // inactive
    a3b1 -> a3b2 [dir=both, style=invis, label=""];
    a3b2 -> a3b3 [dir=both, style=invis, label=""];
    a3b3 -> a3b4 [dir=both, style=invis, label=""];
    a3b4 -> a3b5 [dir=both, style=invis, label=""];
    a3b5 -> a3b6 [dir=both, style=invis, label=""];
    a3b6 -> a3b7 [dir=both, style=invis, label=""];
    a3b7 -> a3b8 [dir=both, style=invis, label=""];
    a3b8 -> a3b9 [dir=both, style=invis, label=""];
    a3b9 -> a3b10 [dir=both, style=invis, label=""];
    a3b10 -> a3b11 [dir=both, style=invis, label=""];
    a3b11 -> a3b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 4)
    a4b1 -> a4b6 [dir=both, label="a"];
    // inactive
    a4b1 -> a4b2 [dir=both, style=invis, label=""];
    a4b2 -> a4b3 [dir=both, style=invis, label=""];
    a4b3 -> a4b4 [dir=both, style=invis, label=""];
    a4b4 -> a4b5 [dir=both, style=invis, label=""];
    a4b5 -> a4b6 [dir=both, style=invis, label=""];
    a4b6 -> a4b7 [dir=both, style=invis, label=""];
    a4b7 -> a4b8 [dir=both, style=invis, label=""];
    a4b8 -> a4b9 [dir=both, style=invis, label=""];
    a4b9 -> a4b10 [dir=both, style=invis, label=""];
    a4b10 -> a4b11 [dir=both, style=invis, label=""];
    a4b11 -> a4b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 5)
    a5b3 -> a5b7 [dir=both, label="a"];
    // inactive
    a5b1 -> a5b2 [dir=both, style=invis, label=""];
    a5b2 -> a5b3 [dir=both, style=invis, label=""];
    a5b3 -> a5b4 [dir=both, style=invis, label=""];
    a5b4 -> a5b5 [dir=both, style=invis, label=""];
    a5b5 -> a5b6 [dir=both, style=invis, label=""];
    a5b6 -> a5b7 [dir=both, style=invis, label=""];
    a5b7 -> a5b8 [dir=both, style=invis, label=""];
    a5b8 -> a5b9 [dir=both, style=invis, label=""];
    a5b9 -> a5b10 [dir=both, style=invis, label=""];
    a5b10 -> a5b11 [dir=both, style=invis, label=""];
    a5b11 -> a5b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 6)
    a6b1 -> a6b2 [dir=both, style=invis, label=""];
    a6b2 -> a6b3 [dir=both, style=invis, label=""];
    a6b3 -> a6b4 [dir=both, style=invis, label=""];
    a6b4 -> a6b5 [dir=both, style=invis, label=""];
    a6b5 -> a6b6 [dir=both, style=invis, label=""];
    a6b6 -> a6b7 [dir=both, style=invis, label=""];
    a6b7 -> a6b8 [dir=both, style=invis, label=""];
    a6b8 -> a6b9 [dir=both, style=invis, label=""];
    a6b9 -> a6b10 [dir=both, style=invis, label=""];
    a6b10 -> a6b11 [dir=both, style=invis, label=""];
    a6b11 -> a6b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 7)
    a7b5 -> a7b9 [dir=both, label="a"];
    // inactive
    a7b1 -> a7b2 [dir=both, style=invis, label=""];
    a7b2 -> a7b3 [dir=both, style=invis, label=""];
    a7b3 -> a7b4 [dir=both, style=invis, label=""];
    a7b4 -> a7b5 [dir=both, style=invis, label=""];
    a7b5 -> a7b6 [dir=both, style=invis, label=""];
    a7b6 -> a7b7 [dir=both, style=invis, label=""];
    a7b7 -> a7b8 [dir=both, style=invis, label=""];
    a7b8 -> a7b9 [dir=both, style=invis, label=""];
    a7b9 -> a7b10 [dir=both, style=invis, label=""];
    a7b10 -> a7b11 [dir=both, style=invis, label=""];
    a7b11 -> a7b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 8)
    a8b1 -> a8b10 [dir=both, label="a"];
    // inactive
    a8b1 -> a8b2 [dir=both, style=invis, label=""];
    a8b2 -> a8b3 [dir=both, style=invis, label=""];
    a8b3 -> a8b4 [dir=both, style=invis, label=""];
    a8b4 -> a8b5 [dir=both, style=invis, label=""];
    a8b5 -> a8b6 [dir=both, style=invis, label=""];
    a8b6 -> a8b7 [dir=both, style=invis, label=""];
    a8b7 -> a8b8 [dir=both, style=invis, label=""];
    a8b8 -> a8b9 [dir=both, style=invis, label=""];
    a8b9 -> a8b10 [dir=both, style=invis, label=""];
    a8b10 -> a8b11 [dir=both, style=invis, label=""];
    a8b11 -> a8b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 9)
    a9b7 -> a9b11 [dir=both, label="a"];
    // inactive
    a9b1 -> a9b2 [dir=both, style=invis, label=""];
    a9b2 -> a9b3 [dir=both, style=invis, label=""];
    a9b3 -> a9b4 [dir=both, style=invis, label=""];
    a9b4 -> a9b5 [dir=both, style=invis, label=""];
    a9b5 -> a9b6 [dir=both, style=invis, label=""];
    a9b6 -> a9b7 [dir=both, style=invis, label=""];
    a9b7 -> a9b8 [dir=both, style=invis, label=""];
    a9b8 -> a9b9 [dir=both, style=invis, label=""];
    a9b9 -> a9b10 [dir=both, style=invis, label=""];
    a9b10 -> a9b11 [dir=both, style=invis, label=""];
    a9b11 -> a9b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 10)
    a10b8 -> a10b12 [dir=both, label="a"];
    // inactive
    a10b1 -> a10b2 [dir=both, style=invis, label=""];
    a10b2 -> a10b3 [dir=both, style=invis, label=""];
    a10b3 -> a10b4 [dir=both, style=invis, label=""];
    a10b4 -> a10b5 [dir=both, style=invis, label=""];
    a10b5 -> a10b6 [dir=both, style=invis, label=""];
    a10b6 -> a10b7 [dir=both, style=invis, label=""];
    a10b7 -> a10b8 [dir=both, style=invis, label=""];
    a10b8 -> a10b9 [dir=both, style=invis, label=""];
    a10b9 -> a10b10 [dir=both, style=invis, label=""];
    a10b10 -> a10b11 [dir=both, style=invis, label=""];
    a10b11 -> a10b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 11)
    a11b1 -> a11b2 [dir=both, style=invis, label=""];
    a11b2 -> a11b3 [dir=both, style=invis, label=""];
    a11b3 -> a11b4 [dir=both, style=invis, label=""];
    a11b4 -> a11b5 [dir=both, style=invis, label=""];
    a11b5 -> a11b6 [dir=both, style=invis, label=""];
    a11b6 -> a11b7 [dir=both, style=invis, label=""];
    a11b7 -> a11b8 [dir=both, style=invis, label=""];
    a11b8 -> a11b9 [dir=both, style=invis, label=""];
    a11b9 -> a11b10 [dir=both, style=invis, label=""];
    a11b10 -> a11b11 [dir=both, style=invis, label=""];
    a11b11 -> a11b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 12)
    a12b1 -> a12b2 [dir=both, style=invis, label=""];
    a12b2 -> a12b3 [dir=both, style=invis, label=""];
    a12b3 -> a12b4 [dir=both, style=invis, label=""];
    a12b4 -> a12b5 [dir=both, style=invis, label=""];
    a12b5 -> a12b6 [dir=both, style=invis, label=""];
    a12b6 -> a12b7 [dir=both, style=invis, label=""];
    a12b7 -> a12b8 [dir=both, style=invis, label=""];
    a12b8 -> a12b9 [dir=both, style=invis, label=""];
    a12b9 -> a12b10 [dir=both, style=invis, label=""];
    a12b10 -> a12b11 [dir=both, style=invis, label=""];
    a12b11 -> a12b12 [dir=both, style=invis, label=""];

    // Vertical edges (Column 1)
    a2b1 -> a3b1 [dir=both, label="b"];
    a3b1 -> a4b1 [dir=both, label="b"];
    a4b1 -> a8b1 [dir=both, label="b"];
    // inactive
    a1b1 -> a2b1 [dir=both, style=invis, label=""];
    a4b1 -> a5b1 [dir=both, style=invis, label=""];
    a5b1 -> a6b1 [dir=both, style=invis, label=""];
    a6b1 -> a7b1 [dir=both, style=invis, label=""];
    a7b1 -> a8b1 [dir=both, style=invis, label=""];
    a8b1 -> a9b1 [dir=both, style=invis, label=""];
    a9b1 -> a10b1 [dir=both, style=invis, label=""];
    a10b1 -> a11b1 [dir=both, style=invis, label=""];
    a11b1 -> a12b1 [dir=both, style=invis, label=""];

    // Vertical edges (Column 2)
    a1b2 -> a2b2 [dir=both, style=invis, label=""];
    a2b2 -> a3b2 [dir=both, style=invis, label=""];
    a3b2 -> a4b2 [dir=both, style=invis, label=""];
    a4b2 -> a5b2 [dir=both, style=invis, label=""];
    a5b2 -> a6b2 [dir=both, style=invis, label=""];
    a6b2 -> a7b2 [dir=both, style=invis, label=""];
    a7b2 -> a8b2 [dir=both, style=invis, label=""];
    a8b2 -> a9b2 [dir=both, style=invis, label=""];
    a9b2 -> a10b2 [dir=both, style=invis, label=""];
    a10b2 -> a11b2 [dir=both, style=invis, label=""];
    a11b2 -> a12b2 [dir=both, style=invis, label=""];

    // Vertical edges (Column 3)
    a1b3 -> a5b3 [dir=both, label="b"];
    // inactive
    a1b3 -> a2b3 [dir=both, style=invis, label=""];
    a2b3 -> a3b3 [dir=both, style=invis, label=""];
    a3b3 -> a4b3 [dir=both, style=invis, label=""];
    a4b3 -> a5b3 [dir=both, style=invis, label=""];
    a5b3 -> a6b3 [dir=both, style=invis, label=""];
    a6b3 -> a7b3 [dir=both, style=invis, label=""];
    a7b3 -> a8b3 [dir=both, style=invis, label=""];
    a8b3 -> a9b3 [dir=both, style=invis, label=""];
    a9b3 -> a10b3 [dir=both, style=invis, label=""];
    a10b3 -> a11b3 [dir=both, style=invis, label=""];
    a11b3 -> a12b3 [dir=both, style=invis, label=""];

    // Vertical edges (Column 4)
    a1b4 -> a6b4 [dir=both, label="b"];
    a1b4 -> a2b4 [dir=both, style=invis, label=""];
    a2b4 -> a3b4 [dir=both, style=invis, label=""];
    a3b4 -> a4b4 [dir=both, style=invis, label=""];
    a4b4 -> a5b4 [dir=both, style=invis, label=""];
    a5b4 -> a6b4 [dir=both, style=invis, label=""];
    a6b4 -> a7b4 [dir=both, style=invis, label=""];
    a7b4 -> a8b4 [dir=both, style=invis, label=""];
    a8b4 -> a9b4 [dir=both, style=invis, label=""];
    a9b4 -> a10b4 [dir=both, style=invis, label=""];
    a10b4 -> a11b4 [dir=both, style=invis, label=""];
    a11b4 -> a12b4 [dir=both, style=invis, label=""];

    // Vertical edges (Column 5)
    a3b5 -> a7b5 [dir=both, label="b"];
    a1b5 -> a2b5 [dir=both, style=invis, label=""];
    a2b5 -> a3b5 [dir=both, style=invis, label=""];
    a3b5 -> a4b5 [dir=both, style=invis, label=""];
    a4b5 -> a5b5 [dir=both, style=invis, label=""];
    a5b5 -> a6b5 [dir=both, style=invis, label=""];
    a6b5 -> a7b5 [dir=both, style=invis, label=""];
    a7b5 -> a8b5 [dir=both, style=invis, label=""];
    a8b5 -> a9b5 [dir=both, style=invis, label=""];
    a9b5 -> a10b5 [dir=both, style=invis, label=""];
    a10b5 -> a11b5 [dir=both, style=invis, label=""];
    a11b5 -> a12b5 [dir=both, style=invis, label=""];

    // Vertical edges (Column 6)
    a1b6 -> a2b6 [dir=both, style=invis, label=""];
    a2b6 -> a3b6 [dir=both, style=invis, label=""];
    a3b6 -> a4b6 [dir=both, style=invis, label=""];
    a4b6 -> a5b6 [dir=both, style=invis, label=""];
    a5b6 -> a6b6 [dir=both, style=invis, label=""];
    a6b6 -> a7b6 [dir=both, style=invis, label=""];
    a7b6 -> a8b6 [dir=both, style=invis, label=""];
    a8b6 -> a9b6 [dir=both, style=invis, label=""];
    a9b6 -> a10b6 [dir=both, style=invis, label=""];
    a10b6 -> a11b6 [dir=both, style=invis, label=""];
    a11b6 -> a12b6 [dir=both, style=invis, label=""];

    // Vertical edges (Column 7)
    a5b7 -> a9b7 [dir=both, label="b"];
    a1b7 -> a2b7 [dir=both, style=invis, label=""];
    a2b7 -> a3b7 [dir=both, style=invis, label=""];
    a3b7 -> a4b7 [dir=both, style=invis, label=""];
    a4b7 -> a5b7 [dir=both, style=invis, label=""];
    a5b7 -> a6b7 [dir=both, style=invis, label=""];
    a6b7 -> a7b7 [dir=both, style=invis, label=""];
    a7b7 -> a8b7 [dir=both, style=invis, label=""];
    a8b7 -> a9b7 [dir=both, style=invis, label=""];
    a9b7 -> a10b7 [dir=both, style=invis, label=""];
    a10b7 -> a11b7 [dir=both, style=invis, label=""];
    a11b7 -> a12b7 [dir=both, style=invis, label=""];

    // Vertical edges (Column 8)
    a1b8 -> a10b8 [dir=both, label="b"];
    a1b8 -> a2b8 [dir=both, style=invis, label=""];
    a2b8 -> a3b8 [dir=both, style=invis, label=""];
    a3b8 -> a4b8 [dir=both, style=invis, label=""];
    a4b8 -> a5b8 [dir=both, style=invis, label=""];
    a5b8 -> a6b8 [dir=both, style=invis, label=""];
    a6b8 -> a7b8 [dir=both, style=invis, label=""];
    a7b8 -> a8b8 [dir=both, style=invis, label=""];
    a8b8 -> a9b8 [dir=both, style=invis, label=""];
    a9b8 -> a10b8 [dir=both, style=invis, label=""];
    a10b8 -> a11b8 [dir=both, style=invis, label=""];
    a11b8 -> a12b8 [dir=both, style=invis, label=""];

    // Vertical edges (Column 9)
    a7b9 -> a11b9 [dir=both, label="b"];
    a1b9 -> a2b9 [dir=both, style=invis, label=""];
    a2b9 -> a3b9 [dir=both, style=invis, label=""];
    a3b9 -> a4b9 [dir=both, style=invis, label=""];
    a4b9 -> a5b9 [dir=both, style=invis, label=""];
    a5b9 -> a6b9 [dir=both, style=invis, label=""];
    a6b9 -> a7b9 [dir=both, style=invis, label=""];
    a7b9 -> a8b9 [dir=both, style=invis, label=""];
    a8b9 -> a9b9 [dir=both, style=invis, label=""];
    a9b9 -> a10b9 [dir=both, style=invis, label=""];
    a10b9 -> a11b9 [dir=both, style=invis, label=""];
    a11b9 -> a12b9 [dir=both, style=invis, label=""];

    // Vertical edges (Column 10)
    a8b10 -> a12b10 [dir=both, label="b"];
    a1b10 -> a2b10 [dir=both, style=invis, label=""];
    a2b10 -> a3b10 [dir=both, style=invis, label=""];
    a3b10 -> a4b10 [dir=both, style=invis, label=""];
    a4b10 -> a5b10 [dir=both, style=invis, label=""];
    a5b10 -> a6b10 [dir=both, style=invis, label=""];
    a6b10 -> a7b10 [dir=both, style=invis, label=""];
    a7b10 -> a8b10 [dir=both, style=invis, label=""];
    a8b10 -> a9b10 [dir=both, style=invis, label=""];
    a9b10 -> a10b10 [dir=both, style=invis, label=""];
    a10b10 -> a11b10 [dir=both, style=invis, label=""];
    a11b10 -> a12b10 [dir=both, style=invis, label=""];

    // Vertical edges (Column 11)
    a1b11 -> a2b11 [dir=both, style=invis, label=""];
    a2b11 -> a3b11 [dir=both, style=invis, label=""];
    a3b11 -> a4b11 [dir=both, style=invis, label=""];
    a4b11 -> a5b11 [dir=both, style=invis, label=""];
    a5b11 -> a6b11 [dir=both, style=invis, label=""];
    a6b11 -> a7b11 [dir=both, style=invis, label=""];
    a7b11 -> a8b11 [dir=both, style=invis, label=""];
    a8b11 -> a9b11 [dir=both, style=invis, label=""];
    a9b11 -> a10b11 [dir=both, style=invis, label=""];
    a10b11 -> a11b11 [dir=both, style=invis, label=""];
    a11b11 -> a12b11 [dir=both, style=invis, label=""];

    // Vertical edges (Column 12)
    a1b12 -> a2b12 [dir=both, style=invis, label=""];
    a2b12 -> a3b12 [dir=both, style=invis, label=""];
    a3b12 -> a4b12 [dir=both, style=invis, label=""];
    a4b12 -> a5b12 [dir=both, style=invis, label=""];
    a5b12 -> a6b12 [dir=both, style=invis, label=""];
    a6b12 -> a7b12 [dir=both, style=invis, label=""];
    a7b12 -> a8b12 [dir=both, style=invis, label=""];
    a8b12 -> a9b12 [dir=both, style=invis, label=""];
    a9b12 -> a10b12 [dir=both, style=invis, label=""];
    a10b12 -> a11b12 [dir=both, style=invis, label=""];
    a11b12 -> a12b12 [dir=both, style=invis, label=""];
}
      ```
    )]
    #v(-11em)
  ]
  #callout(title: "Answer to Exercise 2 (c) continued (i): After the first announcements of ignorance.")[
    _Eliminations:_

    (*ER1*) Elimination rule 1: Whenever $x$ sees $n_y = u$ and $G_i (u)$ is a singleton ${o}$, then $x$ knows their number is $o$. If they continue to pledge ignorance, $o$ cannot be $n_x$. (Note the symmetry in the updates while both answer that they don't know). 
    + $(1,2)$ and $(2,1)$: $G_0 (2) = {1}$. Thus upon seeing $n_y = 2$ $x$ knows $n_x = 1$. But the continued pledge of ignorance eliminates these worlds.
    + $(6,4)$ and $(4,6)$. following the same logic.
    + $(11,9)$ and $(9,11)$ following the same logic.
    + $(12,10)$ and $(10,12)$ following the same logic.

    $#model^prime$:
    
    #v(-18em)
    #scale(40%)[#graph-figure(
      ```dot
      digraph Grid12x12 {
    splines = line;
    node [shape=square, style=rounded, width=1, fixedsize=true, fontsize=25];
    edge [penwidth=1, arrowhead=vee, arrowtail=vee, fontsize=25];
    ranksep = 0.4; // Slightly increased so labels don't clip lines
    nodesep = 0.3;

    // Visible nodes with x_a^* y_b labels
    a1b3 [label="1_a^* 3_b"];
    a3b5 [label="3_a^* 5_b"];
    a4b1 [label="4_a^* 1_b"];
    a5b7 [label="5_a^* 7_b"];
    a7b9 [label="7_a^* 9_b"];
    a8b1 [label="8_a^* 1_b"];
    a10b8 [label="10_a^* 8_b"];

    // Visible nodes with x_a y^*_b labels
    a3b1 [label="3_a 1^*_b"];
    a5b3 [label="5_a 3^*_b"];
    a1b4 [label="1_a 4^*_b"];
    a7b5 [label="7_a 5^*_b"];
    a9b7 [label="9_a 7^*_b"];
    a1b8 [label="1_a 8^*_b"];
    a8b10 [label="8_a 10^*_b"];

    // Set invisible attributes for nodes not in the list
    a1b1 [style=invis, label=""];
    a1b2 [style=invis, label=""];
    a1b5 [style=invis, label=""];
    a1b6 [style=invis, label=""];
    a1b7 [style=invis, label=""];
    a1b9 [style=invis, label=""];
    a1b10 [style=invis, label=""];
    a1b11 [style=invis, label=""];
    a1b12 [style=invis, label=""];

    a2b1 [style=invis, label=""];
    a2b2 [style=invis, label=""];
    a2b3 [style=invis, label=""];
    a2b4 [style=invis, label=""];
    a2b5 [style=invis, label=""];
    a2b6 [style=invis, label=""];
    a2b7 [style=invis, label=""];
    a2b8 [style=invis, label=""];
    a2b9 [style=invis, label=""];
    a2b10 [style=invis, label=""];
    a2b11 [style=invis, label=""];
    a2b12 [style=invis, label=""];

    a3b2 [style=invis, label=""];
    a3b3 [style=invis, label=""];
    a3b4 [style=invis, label=""];
    a3b6 [style=invis, label=""];
    a3b7 [style=invis, label=""];
    a3b8 [style=invis, label=""];
    a3b9 [style=invis, label=""];
    a3b10 [style=invis, label=""];
    a3b11 [style=invis, label=""];
    a3b12 [style=invis, label=""];

    a4b2 [style=invis, label=""];
    a4b3 [style=invis, label=""];
    a4b4 [style=invis, label=""];
    a4b5 [style=invis, label=""];
    a4b6 [style=invis, label=""];
    a4b7 [style=invis, label=""];
    a4b8 [style=invis, label=""];
    a4b9 [style=invis, label=""];
    a4b10 [style=invis, label=""];
    a4b11 [style=invis, label=""];
    a4b12 [style=invis, label=""];

    a5b1 [style=invis, label=""];
    a5b2 [style=invis, label=""];
    a5b4 [style=invis, label=""];
    a5b5 [style=invis, label=""];
    a5b6 [style=invis, label=""];
    a5b8 [style=invis, label=""];
    a5b9 [style=invis, label=""];
    a5b10 [style=invis, label=""];
    a5b11 [style=invis, label=""];
    a5b12 [style=invis, label=""];

    a6b1 [style=invis, label=""];
    a6b2 [style=invis, label=""];
    a6b3 [style=invis, label=""];
    a6b4 [style=invis, label=""];
    a6b5 [style=invis, label=""];
    a6b6 [style=invis, label=""];
    a6b7 [style=invis, label=""];
    a6b8 [style=invis, label=""];
    a6b9 [style=invis, label=""];
    a6b10 [style=invis, label=""];
    a6b11 [style=invis, label=""];
    a6b12 [style=invis, label=""];

    a7b1 [style=invis, label=""];
    a7b2 [style=invis, label=""];
    a7b3 [style=invis, label=""];
    a7b4 [style=invis, label=""];
    a7b6 [style=invis, label=""];
    a7b7 [style=invis, label=""];
    a7b8 [style=invis, label=""];
    a7b10 [style=invis, label=""];
    a7b11 [style=invis, label=""];
    a7b12 [style=invis, label=""];

    a8b2 [style=invis, label=""];
    a8b3 [style=invis, label=""];
    a8b4 [style=invis, label=""];
    a8b5 [style=invis, label=""];
    a8b6 [style=invis, label=""];
    a8b7 [style=invis, label=""];
    a8b8 [style=invis, label=""];
    a8b9 [style=invis, label=""];
    a8b11 [style=invis, label=""];
    a8b12 [style=invis, label=""];

    a9b1 [style=invis, label=""];
    a9b2 [style=invis, label=""];
    a9b3 [style=invis, label=""];
    a9b4 [style=invis, label=""];
    a9b5 [style=invis, label=""];
    a9b6 [style=invis, label=""];
    a9b8 [style=invis, label=""];
    a9b9 [style=invis, label=""];
    a9b10 [style=invis, label=""];
    a9b11 [style=invis, label=""];
    a9b12 [style=invis, label=""];

    a10b1 [style=invis, label=""];
    a10b2 [style=invis, label=""];
    a10b3 [style=invis, label=""];
    a10b4 [style=invis, label=""];
    a10b5 [style=invis, label=""];
    a10b6 [style=invis, label=""];
    a10b7 [style=invis, label=""];
    a10b9 [style=invis, label=""];
    a10b10 [style=invis, label=""];
    a10b11 [style=invis, label=""];
    a10b12 [style=invis, label=""];

    a11b1 [style=invis, label=""];
    a11b2 [style=invis, label=""];
    a11b3 [style=invis, label=""];
    a11b4 [style=invis, label=""];
    a11b5 [style=invis, label=""];
    a11b6 [style=invis, label=""];
    a11b7 [style=invis, label=""];
    a11b8 [style=invis, label=""];
    a11b9 [style=invis, label=""];
    a11b10 [style=invis, label=""];
    a11b11 [style=invis, label=""];
    a11b12 [style=invis, label=""];

    a12b1 [style=invis, label=""];
    a12b2 [style=invis, label=""];
    a12b3 [style=invis, label=""];
    a12b4 [style=invis, label=""];
    a12b5 [style=invis, label=""];
    a12b6 [style=invis, label=""];
    a12b7 [style=invis, label=""];
    a12b8 [style=invis, label=""];
    a12b9 [style=invis, label=""];
    a12b10 [style=invis, label=""];
    a12b11 [style=invis, label=""];
    a12b12 [style=invis, label=""];

    { rank=same; a1b1; a1b2; a1b3; a1b4; a1b5; a1b6; a1b7; a1b8; a1b9; a1b10; a1b11; a1b12; }
    { rank=same; a2b1; a2b2; a2b3; a2b4; a2b5; a2b6; a2b7; a2b8; a2b9; a2b10; a2b11; a2b12; }
    { rank=same; a3b1; a3b2; a3b3; a3b4; a3b5; a3b6; a3b7; a3b8; a3b9; a3b10; a3b11; a3b12; }
    { rank=same; a4b1; a4b2; a4b3; a4b4; a4b5; a4b6; a4b7; a4b8; a4b9; a4b10; a4b11; a4b12; }
    { rank=same; a5b1; a5b2; a5b3; a5b4; a5b5; a5b6; a5b7; a5b8; a5b9; a5b10; a5b11; a5b12; }
    { rank=same; a6b1; a6b2; a6b3; a6b4; a6b5; a6b6; a6b7; a6b8; a6b9; a6b10; a6b11; a6b12; }
    { rank=same; a7b1; a7b2; a7b3; a7b4; a7b5; a7b6; a7b7; a7b8; a7b9; a7b10; a7b11; a7b12; }
    { rank=same; a8b1; a8b2; a8b3; a8b4; a8b5; a8b6; a8b7; a8b8; a8b9; a8b10; a8b11; a8b12; }
    { rank=same; a9b1; a9b2; a9b3; a9b4; a9b5; a9b6; a9b7; a9b8; a9b9; a9b10; a9b11; a9b12; }
    { rank=same; a10b1; a10b2; a10b3; a10b4; a10b5; a10b6; a10b7; a10b8; a10b9; a10b10; a10b11; a10b12; }
    { rank=same; a11b1; a11b2; a11b3; a11b4; a11b5; a11b6; a11b7; a11b8; a11b9; a11b10; a11b11; a11b12; }
    { rank=same; a12b1; a12b2; a12b3; a12b4; a12b5; a12b6; a12b7; a12b8; a12b9; a12b10; a12b11; a12b12; }

    // Horizontal edges (Row 1)
    a1b2 -> a1b3 [dir=both, style=invis, label=""];
    a1b3 -> a1b4 [dir=both, label="a",headport=w, tailport=e];
    a1b4 -> a1b8 [dir=both, label="a"];

    //inactive
    a1b1 -> a1b2 [dir=both, style=invis, label=""];
    a1b4 -> a1b5 [dir=both, style=invis, label=""];
    a1b5 -> a1b6 [dir=both, style=invis, label=""];
    a1b6 -> a1b7 [dir=both, style=invis, label=""];
    a1b7 -> a1b8 [dir=both, style=invis, label=""];
    a1b8 -> a1b9 [dir=both, style=invis, label=""];
    a1b9 -> a1b10 [dir=both, style=invis, label=""];
    a1b10 -> a1b11 [dir=both, style=invis, label=""];
    a1b11 -> a1b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 2)
    a2b1 -> a2b2 [dir=both, style=invis, label=""];
    a2b2 -> a2b3 [dir=both, style=invis, label=""];
    a2b3 -> a2b4 [dir=both, style=invis, label=""];
    a2b4 -> a2b5 [dir=both, style=invis, label=""];
    a2b5 -> a2b6 [dir=both, style=invis, label=""];
    a2b6 -> a2b7 [dir=both, style=invis, label=""];
    a2b7 -> a2b8 [dir=both, style=invis, label=""];
    a2b8 -> a2b9 [dir=both, style=invis, label=""];
    a2b9 -> a2b10 [dir=both, style=invis, label=""];
    a2b10 -> a2b11 [dir=both, style=invis, label=""];
    a2b11 -> a2b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 3)
    a3b1 -> a3b5 [dir=both, label="a"];
    // inactive
    a3b1 -> a3b2 [dir=both, style=invis, label=""];
    a3b2 -> a3b3 [dir=both, style=invis, label=""];
    a3b3 -> a3b4 [dir=both, style=invis, label=""];
    a3b4 -> a3b5 [dir=both, style=invis, label=""];
    a3b5 -> a3b6 [dir=both, style=invis, label=""];
    a3b6 -> a3b7 [dir=both, style=invis, label=""];
    a3b7 -> a3b8 [dir=both, style=invis, label=""];
    a3b8 -> a3b9 [dir=both, style=invis, label=""];
    a3b9 -> a3b10 [dir=both, style=invis, label=""];
    a3b10 -> a3b11 [dir=both, style=invis, label=""];
    a3b11 -> a3b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 4)
    a4b1 -> a4b6 [dir=both, style=invis, label=""];
    // inactive
    a4b1 -> a4b2 [dir=both, style=invis, label=""];
    a4b2 -> a4b3 [dir=both, style=invis, label=""];
    a4b3 -> a4b4 [dir=both, style=invis, label=""];
    a4b4 -> a4b5 [dir=both, style=invis, label=""];
    a4b5 -> a4b6 [dir=both, style=invis, label=""];
    a4b6 -> a4b7 [dir=both, style=invis, label=""];
    a4b7 -> a4b8 [dir=both, style=invis, label=""];
    a4b8 -> a4b9 [dir=both, style=invis, label=""];
    a4b9 -> a4b10 [dir=both, style=invis, label=""];
    a4b10 -> a4b11 [dir=both, style=invis, label=""];
    a4b11 -> a4b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 5)
    a5b3 -> a5b7 [dir=both, label="a"];
    // inactive
    a5b1 -> a5b2 [dir=both, style=invis, label=""];
    a5b2 -> a5b3 [dir=both, style=invis, label=""];
    a5b3 -> a5b4 [dir=both, style=invis, label=""];
    a5b4 -> a5b5 [dir=both, style=invis, label=""];
    a5b5 -> a5b6 [dir=both, style=invis, label=""];
    a5b6 -> a5b7 [dir=both, style=invis, label=""];
    a5b7 -> a5b8 [dir=both, style=invis, label=""];
    a5b8 -> a5b9 [dir=both, style=invis, label=""];
    a5b9 -> a5b10 [dir=both, style=invis, label=""];
    a5b10 -> a5b11 [dir=both, style=invis, label=""];
    a5b11 -> a5b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 6)
    a6b1 -> a6b2 [dir=both, style=invis, label=""];
    a6b2 -> a6b3 [dir=both, style=invis, label=""];
    a6b3 -> a6b4 [dir=both, style=invis, label=""];
    a6b4 -> a6b5 [dir=both, style=invis, label=""];
    a6b5 -> a6b6 [dir=both, style=invis, label=""];
    a6b6 -> a6b7 [dir=both, style=invis, label=""];
    a6b7 -> a6b8 [dir=both, style=invis, label=""];
    a6b8 -> a6b9 [dir=both, style=invis, label=""];
    a6b9 -> a6b10 [dir=both, style=invis, label=""];
    a6b10 -> a6b11 [dir=both, style=invis, label=""];
    a6b11 -> a6b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 7)
    a7b5 -> a7b9 [dir=both, label="a"];
    // inactive
    a7b1 -> a7b2 [dir=both, style=invis, label=""];
    a7b2 -> a7b3 [dir=both, style=invis, label=""];
    a7b3 -> a7b4 [dir=both, style=invis, label=""];
    a7b4 -> a7b5 [dir=both, style=invis, label=""];
    a7b5 -> a7b6 [dir=both, style=invis, label=""];
    a7b6 -> a7b7 [dir=both, style=invis, label=""];
    a7b7 -> a7b8 [dir=both, style=invis, label=""];
    a7b8 -> a7b9 [dir=both, style=invis, label=""];
    a7b9 -> a7b10 [dir=both, style=invis, label=""];
    a7b10 -> a7b11 [dir=both, style=invis, label=""];
    a7b11 -> a7b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 8)
    a8b1 -> a8b10 [dir=both, label="a"];
    // inactive
    a8b1 -> a8b2 [dir=both, style=invis, label=""];
    a8b2 -> a8b3 [dir=both, style=invis, label=""];
    a8b3 -> a8b4 [dir=both, style=invis, label=""];
    a8b4 -> a8b5 [dir=both, style=invis, label=""];
    a8b5 -> a8b6 [dir=both, style=invis, label=""];
    a8b6 -> a8b7 [dir=both, style=invis, label=""];
    a8b7 -> a8b8 [dir=both, style=invis, label=""];
    a8b8 -> a8b9 [dir=both, style=invis, label=""];
    a8b9 -> a8b10 [dir=both, style=invis, label=""];
    a8b10 -> a8b11 [dir=both, style=invis, label=""];
    a8b11 -> a8b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 9)
    a9b7 -> a9b11 [dir=both, style=invis, label=""];
    // inactive
    a9b1 -> a9b2 [dir=both, style=invis, label=""];
    a9b2 -> a9b3 [dir=both, style=invis, label=""];
    a9b3 -> a9b4 [dir=both, style=invis, label=""];
    a9b4 -> a9b5 [dir=both, style=invis, label=""];
    a9b5 -> a9b6 [dir=both, style=invis, label=""];
    a9b6 -> a9b7 [dir=both, style=invis, label=""];
    a9b7 -> a9b8 [dir=both, style=invis, label=""];
    a9b8 -> a9b9 [dir=both, style=invis, label=""];
    a9b9 -> a9b10 [dir=both, style=invis, label=""];
    a9b10 -> a9b11 [dir=both, style=invis, label=""];
    a9b11 -> a9b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 10)
    a10b8 -> a10b12 [dir=both, style=invis, label=""];
    // inactive
    a10b1 -> a10b2 [dir=both, style=invis, label=""];
    a10b2 -> a10b3 [dir=both, style=invis, label=""];
    a10b3 -> a10b4 [dir=both, style=invis, label=""];
    a10b4 -> a10b5 [dir=both, style=invis, label=""];
    a10b5 -> a10b6 [dir=both, style=invis, label=""];
    a10b6 -> a10b7 [dir=both, style=invis, label=""];
    a10b7 -> a10b8 [dir=both, style=invis, label=""];
    a10b8 -> a10b9 [dir=both, style=invis, label=""];
    a10b9 -> a10b10 [dir=both, style=invis, label=""];
    a10b10 -> a10b11 [dir=both, style=invis, label=""];
    a10b11 -> a10b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 11)
    a11b1 -> a11b2 [dir=both, style=invis, label=""];
    a11b2 -> a11b3 [dir=both, style=invis, label=""];
    a11b3 -> a11b4 [dir=both, style=invis, label=""];
    a11b4 -> a11b5 [dir=both, style=invis, label=""];
    a11b5 -> a11b6 [dir=both, style=invis, label=""];
    a11b6 -> a11b7 [dir=both, style=invis, label=""];
    a11b7 -> a11b8 [dir=both, style=invis, label=""];
    a11b8 -> a11b9 [dir=both, style=invis, label=""];
    a11b9 -> a11b10 [dir=both, style=invis, label=""];
    a11b10 -> a11b11 [dir=both, style=invis, label=""];
    a11b11 -> a11b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 12)
    a12b1 -> a12b2 [dir=both, style=invis, label=""];
    a12b2 -> a12b3 [dir=both, style=invis, label=""];
    a12b3 -> a12b4 [dir=both, style=invis, label=""];
    a12b4 -> a12b5 [dir=both, style=invis, label=""];
    a12b5 -> a12b6 [dir=both, style=invis, label=""];
    a12b6 -> a12b7 [dir=both, style=invis, label=""];
    a12b7 -> a12b8 [dir=both, style=invis, label=""];
    a12b8 -> a12b9 [dir=both, style=invis, label=""];
    a12b9 -> a12b10 [dir=both, style=invis, label=""];
    a12b10 -> a12b11 [dir=both, style=invis, label=""];
    a12b11 -> a12b12 [dir=both, style=invis, label=""];

    // Vertical edges (Column 1)
    a2b1 -> a3b1 [dir=both, style=invis, label=""];
    a3b1 -> a4b1 [dir=both, label="b"];
    a4b1 -> a8b1 [dir=both, label="b"];
    // inactive
    a1b1 -> a2b1 [dir=both, style=invis, label=""];
    a4b1 -> a5b1 [dir=both, style=invis, label=""];
    a5b1 -> a6b1 [dir=both, style=invis, label=""];
    a6b1 -> a7b1 [dir=both, style=invis, label=""];
    a7b1 -> a8b1 [dir=both, style=invis, label=""];
    a8b1 -> a9b1 [dir=both, style=invis, label=""];
    a9b1 -> a10b1 [dir=both, style=invis, label=""];
    a10b1 -> a11b1 [dir=both, style=invis, label=""];
    a11b1 -> a12b1 [dir=both, style=invis, label=""];

    // Vertical edges (Column 2)
    a1b2 -> a2b2 [dir=both, style=invis, label=""];
    a2b2 -> a3b2 [dir=both, style=invis, label=""];
    a3b2 -> a4b2 [dir=both, style=invis, label=""];
    a4b2 -> a5b2 [dir=both, style=invis, label=""];
    a5b2 -> a6b2 [dir=both, style=invis, label=""];
    a6b2 -> a7b2 [dir=both, style=invis, label=""];
    a7b2 -> a8b2 [dir=both, style=invis, label=""];
    a8b2 -> a9b2 [dir=both, style=invis, label=""];
    a9b2 -> a10b2 [dir=both, style=invis, label=""];
    a10b2 -> a11b2 [dir=both, style=invis, label=""];
    a11b2 -> a12b2 [dir=both, style=invis, label=""];

    // Vertical edges (Column 3)
    a1b3 -> a5b3 [dir=both, label="b"];
    // inactive
    a1b3 -> a2b3 [dir=both, style=invis, label=""];
    a2b3 -> a3b3 [dir=both, style=invis, label=""];
    a3b3 -> a4b3 [dir=both, style=invis, label=""];
    a4b3 -> a5b3 [dir=both, style=invis, label=""];
    a5b3 -> a6b3 [dir=both, style=invis, label=""];
    a6b3 -> a7b3 [dir=both, style=invis, label=""];
    a7b3 -> a8b3 [dir=both, style=invis, label=""];
    a8b3 -> a9b3 [dir=both, style=invis, label=""];
    a9b3 -> a10b3 [dir=both, style=invis, label=""];
    a10b3 -> a11b3 [dir=both, style=invis, label=""];
    a11b3 -> a12b3 [dir=both, style=invis, label=""];

    // Vertical edges (Column 4)
    a1b4 -> a6b4 [dir=both, style=invis, label=""];
    a1b4 -> a2b4 [dir=both, style=invis, label=""];
    a2b4 -> a3b4 [dir=both, style=invis, label=""];
    a3b4 -> a4b4 [dir=both, style=invis, label=""];
    a4b4 -> a5b4 [dir=both, style=invis, label=""];
    a5b4 -> a6b4 [dir=both, style=invis, label=""];
    a6b4 -> a7b4 [dir=both, style=invis, label=""];
    a7b4 -> a8b4 [dir=both, style=invis, label=""];
    a8b4 -> a9b4 [dir=both, style=invis, label=""];
    a9b4 -> a10b4 [dir=both, style=invis, label=""];
    a10b4 -> a11b4 [dir=both, style=invis, label=""];
    a11b4 -> a12b4 [dir=both, style=invis, label=""];

    // Vertical edges (Column 5)
    a3b5 -> a7b5 [dir=both, label="b"];
    a1b5 -> a2b5 [dir=both, style=invis, label=""];
    a2b5 -> a3b5 [dir=both, style=invis, label=""];
    a3b5 -> a4b5 [dir=both, style=invis, label=""];
    a4b5 -> a5b5 [dir=both, style=invis, label=""];
    a5b5 -> a6b5 [dir=both, style=invis, label=""];
    a6b5 -> a7b5 [dir=both, style=invis, label=""];
    a7b5 -> a8b5 [dir=both, style=invis, label=""];
    a8b5 -> a9b5 [dir=both, style=invis, label=""];
    a9b5 -> a10b5 [dir=both, style=invis, label=""];
    a10b5 -> a11b5 [dir=both, style=invis, label=""];
    a11b5 -> a12b5 [dir=both, style=invis, label=""];

    // Vertical edges (Column 6)
    a1b6 -> a2b6 [dir=both, style=invis, label=""];
    a2b6 -> a3b6 [dir=both, style=invis, label=""];
    a3b6 -> a4b6 [dir=both, style=invis, label=""];
    a4b6 -> a5b6 [dir=both, style=invis, label=""];
    a5b6 -> a6b6 [dir=both, style=invis, label=""];
    a6b6 -> a7b6 [dir=both, style=invis, label=""];
    a7b6 -> a8b6 [dir=both, style=invis, label=""];
    a8b6 -> a9b6 [dir=both, style=invis, label=""];
    a9b6 -> a10b6 [dir=both, style=invis, label=""];
    a10b6 -> a11b6 [dir=both, style=invis, label=""];
    a11b6 -> a12b6 [dir=both, style=invis, label=""];

    // Vertical edges (Column 7)
    a5b7 -> a9b7 [dir=both, label="b"];
    a1b7 -> a2b7 [dir=both, style=invis, label=""];
    a2b7 -> a3b7 [dir=both, style=invis, label=""];
    a3b7 -> a4b7 [dir=both, style=invis, label=""];
    a4b7 -> a5b7 [dir=both, style=invis, label=""];
    a5b7 -> a6b7 [dir=both, style=invis, label=""];
    a6b7 -> a7b7 [dir=both, style=invis, label=""];
    a7b7 -> a8b7 [dir=both, style=invis, label=""];
    a8b7 -> a9b7 [dir=both, style=invis, label=""];
    a9b7 -> a10b7 [dir=both, style=invis, label=""];
    a10b7 -> a11b7 [dir=both, style=invis, label=""];
    a11b7 -> a12b7 [dir=both, style=invis, label=""];

    // Vertical edges (Column 8)
    a1b8 -> a10b8 [dir=both, label="b"];
    a1b8 -> a2b8 [dir=both, style=invis, label=""];
    a2b8 -> a3b8 [dir=both, style=invis, label=""];
    a3b8 -> a4b8 [dir=both, style=invis, label=""];
    a4b8 -> a5b8 [dir=both, style=invis, label=""];
    a5b8 -> a6b8 [dir=both, style=invis, label=""];
    a6b8 -> a7b8 [dir=both, style=invis, label=""];
    a7b8 -> a8b8 [dir=both, style=invis, label=""];
    a8b8 -> a9b8 [dir=both, style=invis, label=""];
    a9b8 -> a10b8 [dir=both, style=invis, label=""];
    a10b8 -> a11b8 [dir=both, style=invis, label=""];
    a11b8 -> a12b8 [dir=both, style=invis, label=""];

    // Vertical edges (Column 9)
    a7b9 -> a11b9 [dir=both, style=invis, label=""];
    a1b9 -> a2b9 [dir=both, style=invis, label=""];
    a2b9 -> a3b9 [dir=both, style=invis, label=""];
    a3b9 -> a4b9 [dir=both, style=invis, label=""];
    a4b9 -> a5b9 [dir=both, style=invis, label=""];
    a5b9 -> a6b9 [dir=both, style=invis, label=""];
    a6b9 -> a7b9 [dir=both, style=invis, label=""];
    a7b9 -> a8b9 [dir=both, style=invis, label=""];
    a8b9 -> a9b9 [dir=both, style=invis, label=""];
    a9b9 -> a10b9 [dir=both, style=invis, label=""];
    a10b9 -> a11b9 [dir=both, style=invis, label=""];
    a11b9 -> a12b9 [dir=both, style=invis, label=""];

    // Vertical edges (Column 10)
    a8b10 -> a12b10 [dir=both, style=invis, label=""];
    a1b10 -> a2b10 [dir=both, style=invis, label=""];
    a2b10 -> a3b10 [dir=both, style=invis, label=""];
    a3b10 -> a4b10 [dir=both, style=invis, label=""];
    a4b10 -> a5b10 [dir=both, style=invis, label=""];
    a5b10 -> a6b10 [dir=both, style=invis, label=""];
    a6b10 -> a7b10 [dir=both, style=invis, label=""];
    a7b10 -> a8b10 [dir=both, style=invis, label=""];
    a8b10 -> a9b10 [dir=both, style=invis, label=""];
    a9b10 -> a10b10 [dir=both, style=invis, label=""];
    a10b10 -> a11b10 [dir=both, style=invis, label=""];
    a11b10 -> a12b10 [dir=both, style=invis, label=""];

    // Vertical edges (Column 11)
    a1b11 -> a2b11 [dir=both, style=invis, label=""];
    a2b11 -> a3b11 [dir=both, style=invis, label=""];
    a3b11 -> a4b11 [dir=both, style=invis, label=""];
    a4b11 -> a5b11 [dir=both, style=invis, label=""];
    a5b11 -> a6b11 [dir=both, style=invis, label=""];
    a6b11 -> a7b11 [dir=both, style=invis, label=""];
    a7b11 -> a8b11 [dir=both, style=invis, label=""];
    a8b11 -> a9b11 [dir=both, style=invis, label=""];
    a9b11 -> a10b11 [dir=both, style=invis, label=""];
    a10b11 -> a11b11 [dir=both, style=invis, label=""];
    a11b11 -> a12b11 [dir=both, style=invis, label=""];

    // Vertical edges (Column 12)
    a1b12 -> a2b12 [dir=both, style=invis, label=""];
    a2b12 -> a3b12 [dir=both, style=invis, label=""];
    a3b12 -> a4b12 [dir=both, style=invis, label=""];
    a4b12 -> a5b12 [dir=both, style=invis, label=""];
    a5b12 -> a6b12 [dir=both, style=invis, label=""];
    a6b12 -> a7b12 [dir=both, style=invis, label=""];
    a7b12 -> a8b12 [dir=both, style=invis, label=""];
    a8b12 -> a9b12 [dir=both, style=invis, label=""];
    a9b12 -> a10b12 [dir=both, style=invis, label=""];
    a10b12 -> a11b12 [dir=both, style=invis, label=""];
    a11b12 -> a12b12 [dir=both, style=invis, label=""];
}
    ```
    )]
    #v(-15em)
  ]

  #callout(title:"Answer to Exercise 2 (c) continued (ii): After the second announcements of ignorance.")[
    _Eliminations_:

    (*ER2*) Elimination rule 2: After eliminating possible worlds, the set of possible values $G_i (n_y)$ for $n_x$ upon seeing $n_y$ shrinks, allowing the iteration of (*ER1*).
    5. $(4,1)$ and $(1,4)$
    + $(9,7)$ and $(7,9)$
    + $(10,8)$ and $(8,10)$

    $#model^prime.double$:
    #v(-25em)
    #scale(40%)[#graph-figure(
      ```dot
      digraph Grid12x12 {
    splines = line;
    node [shape=square, style=rounded, width=1, fixedsize=true, fontsize=25];
    edge [penwidth=1, arrowhead=vee, arrowtail=vee, fontsize=25];
    ranksep = 0.4; // Slightly increased so labels don't clip lines
    nodesep = 0.3;

    // Visible nodes with x_a^* y_b labels
    a1b3 [label="1_a^* 3_b"];
    a3b5 [label="3_a^* 5_b"];
    a5b7 [label="5_a^* 7_b"];
    a8b1 [label="8_a^* 1_b"];

    // Visible nodes with x_a y^*_b labels
    a3b1 [label="3_a 1^*_b"];
    a5b3 [label="5_a 3^*_b"];
    a7b5 [label="7_a 5^*_b"];
    a1b8 [label="1_a 8^*_b"];

    // Set invisible attributes for nodes not in the list
    a1b1 [style=invis, label=""];
    a1b2 [style=invis, label=""];
    a1b4 [style=invis, label=""];
    a1b5 [style=invis, label=""];
    a1b6 [style=invis, label=""];
    a1b7 [style=invis, label=""];
    a1b9 [style=invis, label=""];
    a1b10 [style=invis, label=""];
    a1b11 [style=invis, label=""];
    a1b12 [style=invis, label=""];

    a2b1 [style=invis, label=""];
    a2b2 [style=invis, label=""];
    a2b3 [style=invis, label=""];
    a2b4 [style=invis, label=""];
    a2b5 [style=invis, label=""];
    a2b6 [style=invis, label=""];
    a2b7 [style=invis, label=""];
    a2b8 [style=invis, label=""];
    a2b9 [style=invis, label=""];
    a2b10 [style=invis, label=""];
    a2b11 [style=invis, label=""];
    a2b12 [style=invis, label=""];

    a3b2 [style=invis, label=""];
    a3b3 [style=invis, label=""];
    a3b4 [style=invis, label=""];
    a3b6 [style=invis, label=""];
    a3b7 [style=invis, label=""];
    a3b8 [style=invis, label=""];
    a3b9 [style=invis, label=""];
    a3b10 [style=invis, label=""];
    a3b11 [style=invis, label=""];
    a3b12 [style=invis, label=""];

    a4b1 [style=invis, label=""];
    a4b2 [style=invis, label=""];
    a4b3 [style=invis, label=""];
    a4b4 [style=invis, label=""];
    a4b5 [style=invis, label=""];
    a4b6 [style=invis, label=""];
    a4b7 [style=invis, label=""];
    a4b8 [style=invis, label=""];
    a4b9 [style=invis, label=""];
    a4b10 [style=invis, label=""];
    a4b11 [style=invis, label=""];
    a4b12 [style=invis, label=""];

    a5b1 [style=invis, label=""];
    a5b2 [style=invis, label=""];
    a5b4 [style=invis, label=""];
    a5b5 [style=invis, label=""];
    a5b6 [style=invis, label=""];
    a5b8 [style=invis, label=""];
    a5b9 [style=invis, label=""];
    a5b10 [style=invis, label=""];
    a5b11 [style=invis, label=""];
    a5b12 [style=invis, label=""];

    a6b1 [style=invis, label=""];
    a6b2 [style=invis, label=""];
    a6b3 [style=invis, label=""];
    a6b4 [style=invis, label=""];
    a6b5 [style=invis, label=""];
    a6b6 [style=invis, label=""];
    a6b7 [style=invis, label=""];
    a6b8 [style=invis, label=""];
    a6b9 [style=invis, label=""];
    a6b10 [style=invis, label=""];
    a6b11 [style=invis, label=""];
    a6b12 [style=invis, label=""];

    a7b1 [style=invis, label=""];
    a7b2 [style=invis, label=""];
    a7b3 [style=invis, label=""];
    a7b4 [style=invis, label=""];
    a7b6 [style=invis, label=""];
    a7b7 [style=invis, label=""];
    a7b8 [style=invis, label=""];
    a7b9 [style=invis, label=""];
    a7b10 [style=invis, label=""];
    a7b11 [style=invis, label=""];
    a7b12 [style=invis, label=""];

    a8b2 [style=invis, label=""];
    a8b3 [style=invis, label=""];
    a8b4 [style=invis, label=""];
    a8b5 [style=invis, label=""];
    a8b6 [style=invis, label=""];
    a8b7 [style=invis, label=""];
    a8b8 [style=invis, label=""];
    a8b9 [style=invis, label=""];
    a8b10 [style=invis, label=""];
    a8b11 [style=invis, label=""];
    a8b12 [style=invis, label=""];

    a9b1 [style=invis, label=""];
    a9b2 [style=invis, label=""];
    a9b3 [style=invis, label=""];
    a9b4 [style=invis, label=""];
    a9b5 [style=invis, label=""];
    a9b6 [style=invis, label=""];
    a9b7 [style=invis, label=""];
    a9b8 [style=invis, label=""];
    a9b9 [style=invis, label=""];
    a9b10 [style=invis, label=""];
    a9b11 [style=invis, label=""];
    a9b12 [style=invis, label=""];

    a10b1 [style=invis, label=""];
    a10b2 [style=invis, label=""];
    a10b3 [style=invis, label=""];
    a10b4 [style=invis, label=""];
    a10b5 [style=invis, label=""];
    a10b6 [style=invis, label=""];
    a10b7 [style=invis, label=""];
    a10b8 [style=invis, label=""];
    a10b9 [style=invis, label=""];
    a10b10 [style=invis, label=""];
    a10b11 [style=invis, label=""];
    a10b12 [style=invis, label=""];

    a11b1 [style=invis, label=""];
    a11b2 [style=invis, label=""];
    a11b3 [style=invis, label=""];
    a11b4 [style=invis, label=""];
    a11b5 [style=invis, label=""];
    a11b6 [style=invis, label=""];
    a11b7 [style=invis, label=""];
    a11b8 [style=invis, label=""];
    a11b9 [style=invis, label=""];
    a11b10 [style=invis, label=""];
    a11b11 [style=invis, label=""];
    a11b12 [style=invis, label=""];

    a12b1 [style=invis, label=""];
    a12b2 [style=invis, label=""];
    a12b3 [style=invis, label=""];
    a12b4 [style=invis, label=""];
    a12b5 [style=invis, label=""];
    a12b6 [style=invis, label=""];
    a12b7 [style=invis, label=""];
    a12b8 [style=invis, label=""];
    a12b9 [style=invis, label=""];
    a12b10 [style=invis, label=""];
    a12b11 [style=invis, label=""];
    a12b12 [style=invis, label=""];

    { rank=same; a1b1; a1b2; a1b3; a1b4; a1b5; a1b6; a1b7; a1b8; a1b9; a1b10; a1b11; a1b12; }
    { rank=same; a2b1; a2b2; a2b3; a2b4; a2b5; a2b6; a2b7; a2b8; a2b9; a2b10; a2b11; a2b12; }
    { rank=same; a3b1; a3b2; a3b3; a3b4; a3b5; a3b6; a3b7; a3b8; a3b9; a3b10; a3b11; a3b12; }
    { rank=same; a4b1; a4b2; a4b3; a4b4; a4b5; a4b6; a4b7; a4b8; a4b9; a4b10; a4b11; a4b12; }
    { rank=same; a5b1; a5b2; a5b3; a5b4; a5b5; a5b6; a5b7; a5b8; a5b9; a5b10; a5b11; a5b12; }
    { rank=same; a6b1; a6b2; a6b3; a6b4; a6b5; a6b6; a6b7; a6b8; a6b9; a6b10; a6b11; a6b12; }
    { rank=same; a7b1; a7b2; a7b3; a7b4; a7b5; a7b6; a7b7; a7b8; a7b9; a7b10; a7b11; a7b12; }
    { rank=same; a8b1; a8b2; a8b3; a8b4; a8b5; a8b6; a8b7; a8b8; a8b9; a8b10; a8b11; a8b12; }
    { rank=same; a9b1; a9b2; a9b3; a9b4; a9b5; a9b6; a9b7; a9b8; a9b9; a9b10; a9b11; a9b12; }
    { rank=same; a10b1; a10b2; a10b3; a10b4; a10b5; a10b6; a10b7; a10b8; a10b9; a10b10; a10b11; a10b12; }
    { rank=same; a11b1; a11b2; a11b3; a11b4; a11b5; a11b6; a11b7; a11b8; a11b9; a11b10; a11b11; a11b12; }
    { rank=same; a12b1; a12b2; a12b3; a12b4; a12b5; a12b6; a12b7; a12b8; a12b9; a12b10; a12b11; a12b12; }

    // Horizontal edges (Row 1)
    a1b3 -> a1b8 [dir=both, label=a]
    a1b2 -> a1b3 [dir=both, style=invis, label=""];
    a1b3 -> a1b4 [dir=both, style=invis, label=""];
    a1b4 -> a1b8 [dir=both, style=invis, label=""];

    //inactive
    a1b1 -> a1b2 [dir=both, style=invis, label=""];
    a1b4 -> a1b5 [dir=both, style=invis, label=""];
    a1b5 -> a1b6 [dir=both, style=invis, label=""];
    a1b6 -> a1b7 [dir=both, style=invis, label=""];
    a1b7 -> a1b8 [dir=both, style=invis, label=""];
    a1b8 -> a1b9 [dir=both, style=invis, label=""];
    a1b9 -> a1b10 [dir=both, style=invis, label=""];
    a1b10 -> a1b11 [dir=both, style=invis, label=""];
    a1b11 -> a1b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 2)
    a2b1 -> a2b2 [dir=both, style=invis, label=""];
    a2b2 -> a2b3 [dir=both, style=invis, label=""];
    a2b3 -> a2b4 [dir=both, style=invis, label=""];
    a2b4 -> a2b5 [dir=both, style=invis, label=""];
    a2b5 -> a2b6 [dir=both, style=invis, label=""];
    a2b6 -> a2b7 [dir=both, style=invis, label=""];
    a2b7 -> a2b8 [dir=both, style=invis, label=""];
    a2b8 -> a2b9 [dir=both, style=invis, label=""];
    a2b9 -> a2b10 [dir=both, style=invis, label=""];
    a2b10 -> a2b11 [dir=both, style=invis, label=""];
    a2b11 -> a2b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 3)
    a3b1 -> a3b5 [dir=both, label="a"];
    // inactive
    a3b1 -> a3b2 [dir=both, style=invis, label=""];
    a3b2 -> a3b3 [dir=both, style=invis, label=""];
    a3b3 -> a3b4 [dir=both, style=invis, label=""];
    a3b4 -> a3b5 [dir=both, style=invis, label=""];
    a3b5 -> a3b6 [dir=both, style=invis, label=""];
    a3b6 -> a3b7 [dir=both, style=invis, label=""];
    a3b7 -> a3b8 [dir=both, style=invis, label=""];
    a3b8 -> a3b9 [dir=both, style=invis, label=""];
    a3b9 -> a3b10 [dir=both, style=invis, label=""];
    a3b10 -> a3b11 [dir=both, style=invis, label=""];
    a3b11 -> a3b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 4)
    a4b1 -> a4b6 [dir=both, style=invis, label=""];
    // inactive
    a4b1 -> a4b2 [dir=both, style=invis, label=""];
    a4b2 -> a4b3 [dir=both, style=invis, label=""];
    a4b3 -> a4b4 [dir=both, style=invis, label=""];
    a4b4 -> a4b5 [dir=both, style=invis, label=""];
    a4b5 -> a4b6 [dir=both, style=invis, label=""];
    a4b6 -> a4b7 [dir=both, style=invis, label=""];
    a4b7 -> a4b8 [dir=both, style=invis, label=""];
    a4b8 -> a4b9 [dir=both, style=invis, label=""];
    a4b9 -> a4b10 [dir=both, style=invis, label=""];
    a4b10 -> a4b11 [dir=both, style=invis, label=""];
    a4b11 -> a4b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 5)
    a5b3 -> a5b7 [dir=both, label="a"];
    // inactive
    a5b1 -> a5b2 [dir=both, style=invis, label=""];
    a5b2 -> a5b3 [dir=both, style=invis, label=""];
    a5b3 -> a5b4 [dir=both, style=invis, label=""];
    a5b4 -> a5b5 [dir=both, style=invis, label=""];
    a5b5 -> a5b6 [dir=both, style=invis, label=""];
    a5b6 -> a5b7 [dir=both, style=invis, label=""];
    a5b7 -> a5b8 [dir=both, style=invis, label=""];
    a5b8 -> a5b9 [dir=both, style=invis, label=""];
    a5b9 -> a5b10 [dir=both, style=invis, label=""];
    a5b10 -> a5b11 [dir=both, style=invis, label=""];
    a5b11 -> a5b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 6)
    a6b1 -> a6b2 [dir=both, style=invis, label=""];
    a6b2 -> a6b3 [dir=both, style=invis, label=""];
    a6b3 -> a6b4 [dir=both, style=invis, label=""];
    a6b4 -> a6b5 [dir=both, style=invis, label=""];
    a6b5 -> a6b6 [dir=both, style=invis, label=""];
    a6b6 -> a6b7 [dir=both, style=invis, label=""];
    a6b7 -> a6b8 [dir=both, style=invis, label=""];
    a6b8 -> a6b9 [dir=both, style=invis, label=""];
    a6b9 -> a6b10 [dir=both, style=invis, label=""];
    a6b10 -> a6b11 [dir=both, style=invis, label=""];
    a6b11 -> a6b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 7)
    a7b5 -> a7b9 [dir=both, style=invis, label=""];
    // inactive
    a7b1 -> a7b2 [dir=both, style=invis, label=""];
    a7b2 -> a7b3 [dir=both, style=invis, label=""];
    a7b3 -> a7b4 [dir=both, style=invis, label=""];
    a7b4 -> a7b5 [dir=both, style=invis, label=""];
    a7b5 -> a7b6 [dir=both, style=invis, label=""];
    a7b6 -> a7b7 [dir=both, style=invis, label=""];
    a7b7 -> a7b8 [dir=both, style=invis, label=""];
    a7b8 -> a7b9 [dir=both, style=invis, label=""];
    a7b9 -> a7b10 [dir=both, style=invis, label=""];
    a7b10 -> a7b11 [dir=both, style=invis, label=""];
    a7b11 -> a7b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 8)
    a8b1 -> a8b10 [dir=both, style=invis, label=""];
    // inactive
    a8b1 -> a8b2 [dir=both, style=invis, label=""];
    a8b2 -> a8b3 [dir=both, style=invis, label=""];
    a8b3 -> a8b4 [dir=both, style=invis, label=""];
    a8b4 -> a8b5 [dir=both, style=invis, label=""];
    a8b5 -> a8b6 [dir=both, style=invis, label=""];
    a8b6 -> a8b7 [dir=both, style=invis, label=""];
    a8b7 -> a8b8 [dir=both, style=invis, label=""];
    a8b8 -> a8b9 [dir=both, style=invis, label=""];
    a8b9 -> a8b10 [dir=both, style=invis, label=""];
    a8b10 -> a8b11 [dir=both, style=invis, label=""];
    a8b11 -> a8b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 9)
    a9b7 -> a9b11 [dir=both, style=invis, label=""];
    // inactive
    a9b1 -> a9b2 [dir=both, style=invis, label=""];
    a9b2 -> a9b3 [dir=both, style=invis, label=""];
    a9b3 -> a9b4 [dir=both, style=invis, label=""];
    a9b4 -> a9b5 [dir=both, style=invis, label=""];
    a9b5 -> a9b6 [dir=both, style=invis, label=""];
    a9b6 -> a9b7 [dir=both, style=invis, label=""];
    a9b7 -> a9b8 [dir=both, style=invis, label=""];
    a9b8 -> a9b9 [dir=both, style=invis, label=""];
    a9b9 -> a9b10 [dir=both, style=invis, label=""];
    a9b10 -> a9b11 [dir=both, style=invis, label=""];
    a9b11 -> a9b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 10)
    a10b8 -> a10b12 [dir=both, style=invis, label=""];
    // inactive
    a10b1 -> a10b2 [dir=both, style=invis, label=""];
    a10b2 -> a10b3 [dir=both, style=invis, label=""];
    a10b3 -> a10b4 [dir=both, style=invis, label=""];
    a10b4 -> a10b5 [dir=both, style=invis, label=""];
    a10b5 -> a10b6 [dir=both, style=invis, label=""];
    a10b6 -> a10b7 [dir=both, style=invis, label=""];
    a10b7 -> a10b8 [dir=both, style=invis, label=""];
    a10b8 -> a10b9 [dir=both, style=invis, label=""];
    a10b9 -> a10b10 [dir=both, style=invis, label=""];
    a10b10 -> a10b11 [dir=both, style=invis, label=""];
    a10b11 -> a10b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 11)
    a11b1 -> a11b2 [dir=both, style=invis, label=""];
    a11b2 -> a11b3 [dir=both, style=invis, label=""];
    a11b3 -> a11b4 [dir=both, style=invis, label=""];
    a11b4 -> a11b5 [dir=both, style=invis, label=""];
    a11b5 -> a11b6 [dir=both, style=invis, label=""];
    a11b6 -> a11b7 [dir=both, style=invis, label=""];
    a11b7 -> a11b8 [dir=both, style=invis, label=""];
    a11b8 -> a11b9 [dir=both, style=invis, label=""];
    a11b9 -> a11b10 [dir=both, style=invis, label=""];
    a11b10 -> a11b11 [dir=both, style=invis, label=""];
    a11b11 -> a11b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 12)
    a12b1 -> a12b2 [dir=both, style=invis, label=""];
    a12b2 -> a12b3 [dir=both, style=invis, label=""];
    a12b3 -> a12b4 [dir=both, style=invis, label=""];
    a12b4 -> a12b5 [dir=both, style=invis, label=""];
    a12b5 -> a12b6 [dir=both, style=invis, label=""];
    a12b6 -> a12b7 [dir=both, style=invis, label=""];
    a12b7 -> a12b8 [dir=both, style=invis, label=""];
    a12b8 -> a12b9 [dir=both, style=invis, label=""];
    a12b9 -> a12b10 [dir=both, style=invis, label=""];
    a12b10 -> a12b11 [dir=both, style=invis, label=""];
    a12b11 -> a12b12 [dir=both, style=invis, label=""];

    // Vertical edges (Column 1)
    a3b1 -> a8b1 [dir=both, label=b]
    a2b1 -> a3b1 [dir=both, style=invis, label=""];
    a3b1 -> a4b1 [dir=both, style=invis, label=""];
    a4b1 -> a8b1 [dir=both, style=invis, label=""];
    // inactive
    a1b1 -> a2b1 [dir=both, style=invis, label=""];
    a4b1 -> a5b1 [dir=both, style=invis, label=""];
    a5b1 -> a6b1 [dir=both, style=invis, label=""];
    a6b1 -> a7b1 [dir=both, style=invis, label=""];
    a7b1 -> a8b1 [dir=both, style=invis, label=""];
    a8b1 -> a9b1 [dir=both, style=invis, label=""];
    a9b1 -> a10b1 [dir=both, style=invis, label=""];
    a10b1 -> a11b1 [dir=both, style=invis, label=""];
    a11b1 -> a12b1 [dir=both, style=invis, label=""];

    // Vertical edges (Column 2)
    a1b2 -> a2b2 [dir=both, style=invis, label=""];
    a2b2 -> a3b2 [dir=both, style=invis, label=""];
    a3b2 -> a4b2 [dir=both, style=invis, label=""];
    a4b2 -> a5b2 [dir=both, style=invis, label=""];
    a5b2 -> a6b2 [dir=both, style=invis, label=""];
    a6b2 -> a7b2 [dir=both, style=invis, label=""];
    a7b2 -> a8b2 [dir=both, style=invis, label=""];
    a8b2 -> a9b2 [dir=both, style=invis, label=""];
    a9b2 -> a10b2 [dir=both, style=invis, label=""];
    a10b2 -> a11b2 [dir=both, style=invis, label=""];
    a11b2 -> a12b2 [dir=both, style=invis, label=""];

    // Vertical edges (Column 3)
    a1b3 -> a5b3 [dir=both, label="b"];
    // inactive
    a1b3 -> a2b3 [dir=both, style=invis, label=""];
    a2b3 -> a3b3 [dir=both, style=invis, label=""];
    a3b3 -> a4b3 [dir=both, style=invis, label=""];
    a4b3 -> a5b3 [dir=both, style=invis, label=""];
    a5b3 -> a6b3 [dir=both, style=invis, label=""];
    a6b3 -> a7b3 [dir=both, style=invis, label=""];
    a7b3 -> a8b3 [dir=both, style=invis, label=""];
    a8b3 -> a9b3 [dir=both, style=invis, label=""];
    a9b3 -> a10b3 [dir=both, style=invis, label=""];
    a10b3 -> a11b3 [dir=both, style=invis, label=""];
    a11b3 -> a12b3 [dir=both, style=invis, label=""];

    // Vertical edges (Column 4)
    a1b4 -> a6b4 [dir=both, style=invis, label=""];
    a1b4 -> a2b4 [dir=both, style=invis, label=""];
    a2b4 -> a3b4 [dir=both, style=invis, label=""];
    a3b4 -> a4b4 [dir=both, style=invis, label=""];
    a4b4 -> a5b4 [dir=both, style=invis, label=""];
    a5b4 -> a6b4 [dir=both, style=invis, label=""];
    a6b4 -> a7b4 [dir=both, style=invis, label=""];
    a7b4 -> a8b4 [dir=both, style=invis, label=""];
    a8b4 -> a9b4 [dir=both, style=invis, label=""];
    a9b4 -> a10b4 [dir=both, style=invis, label=""];
    a10b4 -> a11b4 [dir=both, style=invis, label=""];
    a11b4 -> a12b4 [dir=both, style=invis, label=""];

    // Vertical edges (Column 5)
    a3b5 -> a7b5 [dir=both, label="b"];
    a1b5 -> a2b5 [dir=both, style=invis, label=""];
    a2b5 -> a3b5 [dir=both, style=invis, label=""];
    a3b5 -> a4b5 [dir=both, style=invis, label=""];
    a4b5 -> a5b5 [dir=both, style=invis, label=""];
    a5b5 -> a6b5 [dir=both, style=invis, label=""];
    a6b5 -> a7b5 [dir=both, style=invis, label=""];
    a7b5 -> a8b5 [dir=both, style=invis, label=""];
    a8b5 -> a9b5 [dir=both, style=invis, label=""];
    a9b5 -> a10b5 [dir=both, style=invis, label=""];
    a10b5 -> a11b5 [dir=both, style=invis, label=""];
    a11b5 -> a12b5 [dir=both, style=invis, label=""];

    // Vertical edges (Column 6)
    a1b6 -> a2b6 [dir=both, style=invis, label=""];
    a2b6 -> a3b6 [dir=both, style=invis, label=""];
    a3b6 -> a4b6 [dir=both, style=invis, label=""];
    a4b6 -> a5b6 [dir=both, style=invis, label=""];
    a5b6 -> a6b6 [dir=both, style=invis, label=""];
    a6b6 -> a7b6 [dir=both, style=invis, label=""];
    a7b6 -> a8b6 [dir=both, style=invis, label=""];
    a8b6 -> a9b6 [dir=both, style=invis, label=""];
    a9b6 -> a10b6 [dir=both, style=invis, label=""];
    a10b6 -> a11b6 [dir=both, style=invis, label=""];
    a11b6 -> a12b6 [dir=both, style=invis, label=""];

    // Vertical edges (Column 7)
    a5b7 -> a9b7 [dir=both, style=invis, label=""];
    a1b7 -> a2b7 [dir=both, style=invis, label=""];
    a2b7 -> a3b7 [dir=both, style=invis, label=""];
    a3b7 -> a4b7 [dir=both, style=invis, label=""];
    a4b7 -> a5b7 [dir=both, style=invis, label=""];
    a5b7 -> a6b7 [dir=both, style=invis, label=""];
    a6b7 -> a7b7 [dir=both, style=invis, label=""];
    a7b7 -> a8b7 [dir=both, style=invis, label=""];
    a8b7 -> a9b7 [dir=both, style=invis, label=""];
    a9b7 -> a10b7 [dir=both, style=invis, label=""];
    a10b7 -> a11b7 [dir=both, style=invis, label=""];
    a11b7 -> a12b7 [dir=both, style=invis, label=""];

    // Vertical edges (Column 8)
    a1b8 -> a10b8 [dir=both, style=invis, label=""];
    a1b8 -> a2b8 [dir=both, style=invis, label=""];
    a2b8 -> a3b8 [dir=both, style=invis, label=""];
    a3b8 -> a4b8 [dir=both, style=invis, label=""];
    a4b8 -> a5b8 [dir=both, style=invis, label=""];
    a5b8 -> a6b8 [dir=both, style=invis, label=""];
    a6b8 -> a7b8 [dir=both, style=invis, label=""];
    a7b8 -> a8b8 [dir=both, style=invis, label=""];
    a8b8 -> a9b8 [dir=both, style=invis, label=""];
    a9b8 -> a10b8 [dir=both, style=invis, label=""];
    a10b8 -> a11b8 [dir=both, style=invis, label=""];
    a11b8 -> a12b8 [dir=both, style=invis, label=""];

    // Vertical edges (Column 9)
    a7b9 -> a11b9 [dir=both, style=invis, label=""];
    a1b9 -> a2b9 [dir=both, style=invis, label=""];
    a2b9 -> a3b9 [dir=both, style=invis, label=""];
    a3b9 -> a4b9 [dir=both, style=invis, label=""];
    a4b9 -> a5b9 [dir=both, style=invis, label=""];
    a5b9 -> a6b9 [dir=both, style=invis, label=""];
    a6b9 -> a7b9 [dir=both, style=invis, label=""];
    a7b9 -> a8b9 [dir=both, style=invis, label=""];
    a8b9 -> a9b9 [dir=both, style=invis, label=""];
    a9b9 -> a10b9 [dir=both, style=invis, label=""];
    a10b9 -> a11b9 [dir=both, style=invis, label=""];
    a11b9 -> a12b9 [dir=both, style=invis, label=""];

    // Vertical edges (Column 10)
    a8b10 -> a12b10 [dir=both, style=invis, label=""];
    a1b10 -> a2b10 [dir=both, style=invis, label=""];
    a2b10 -> a3b10 [dir=both, style=invis, label=""];
    a3b10 -> a4b10 [dir=both, style=invis, label=""];
    a4b10 -> a5b10 [dir=both, style=invis, label=""];
    a5b10 -> a6b10 [dir=both, style=invis, label=""];
    a6b10 -> a7b10 [dir=both, style=invis, label=""];
    a7b10 -> a8b10 [dir=both, style=invis, label=""];
    a8b10 -> a9b10 [dir=both, style=invis, label=""];
    a9b10 -> a10b10 [dir=both, style=invis, label=""];
    a10b10 -> a11b10 [dir=both, style=invis, label=""];
    a11b10 -> a12b10 [dir=both, style=invis, label=""];

    // Vertical edges (Column 11)
    a1b11 -> a2b11 [dir=both, style=invis, label=""];
    a2b11 -> a3b11 [dir=both, style=invis, label=""];
    a3b11 -> a4b11 [dir=both, style=invis, label=""];
    a4b11 -> a5b11 [dir=both, style=invis, label=""];
    a5b11 -> a6b11 [dir=both, style=invis, label=""];
    a6b11 -> a7b11 [dir=both, style=invis, label=""];
    a7b11 -> a8b11 [dir=both, style=invis, label=""];
    a8b11 -> a9b11 [dir=both, style=invis, label=""];
    a9b11 -> a10b11 [dir=both, style=invis, label=""];
    a10b11 -> a11b11 [dir=both, style=invis, label=""];
    a11b11 -> a12b11 [dir=both, style=invis, label=""];

    // Vertical edges (Column 12)
    a1b12 -> a2b12 [dir=both, style=invis, label=""];
    a2b12 -> a3b12 [dir=both, style=invis, label=""];
    a3b12 -> a4b12 [dir=both, style=invis, label=""];
    a4b12 -> a5b12 [dir=both, style=invis, label=""];
    a5b12 -> a6b12 [dir=both, style=invis, label=""];
    a6b12 -> a7b12 [dir=both, style=invis, label=""];
    a7b12 -> a8b12 [dir=both, style=invis, label=""];
    a8b12 -> a9b12 [dir=both, style=invis, label=""];
    a9b12 -> a10b12 [dir=both, style=invis, label=""];
    a10b12 -> a11b12 [dir=both, style=invis, label=""];
    a11b12 -> a12b12 [dir=both, style=invis, label=""];
}
      ```
    )]
    #v(-22em)
  ]

  #callout(title:"Answer to Exercise 2 (c) continued (iii): After the third announcements of ignorance.")[
    _Eliminations_:
    8. $(8,1)$ and $(1,8)$
    9. $(7,5)$ and $(5,7)$


    #v(-18em)
    #scale(40%)[#graph-figure(
    ```dot
    digraph Grid12x12 {
    splines = line;
    node [shape=square, style=rounded, width=1, fixedsize=true, fontsize=25];
    edge [penwidth=1, arrowhead=vee, arrowtail=vee, fontsize=25];
    ranksep = 0.4; // Slightly increased so labels don't clip lines
    nodesep = 0.3;

    // Visible nodes with x_a^* y_b labels
    a1b3 [label="1_a^* 3_b"];
    a3b5 [label="3_a^* 5_b"];

    // Visible nodes with x_a y^*_b labels
    a3b1 [label="3_a 1^*_b"];
    a5b3 [label="5_a 3^*_b"];

    // Set invisible attributes for nodes not in the list
    a1b1 [style=invis, label=""];
    a1b2 [style=invis, label=""];
    a1b4 [style=invis, label=""];
    a1b5 [style=invis, label=""];
    a1b6 [style=invis, label=""];
    a1b7 [style=invis, label=""];
    a1b8 [style=invis, label=""];
    a1b9 [style=invis, label=""];
    a1b10 [style=invis, label=""];
    a1b11 [style=invis, label=""];
    a1b12 [style=invis, label=""];

    a2b1 [style=invis, label=""];
    a2b2 [style=invis, label=""];
    a2b3 [style=invis, label=""];
    a2b4 [style=invis, label=""];
    a2b5 [style=invis, label=""];
    a2b6 [style=invis, label=""];
    a2b7 [style=invis, label=""];
    a2b8 [style=invis, label=""];
    a2b9 [style=invis, label=""];
    a2b10 [style=invis, label=""];
    a2b11 [style=invis, label=""];
    a2b12 [style=invis, label=""];

    a3b2 [style=invis, label=""];
    a3b3 [style=invis, label=""];
    a3b4 [style=invis, label=""];
    a3b6 [style=invis, label=""];
    a3b7 [style=invis, label=""];
    a3b8 [style=invis, label=""];
    a3b9 [style=invis, label=""];
    a3b10 [style=invis, label=""];
    a3b11 [style=invis, label=""];
    a3b12 [style=invis, label=""];

    a4b1 [style=invis, label=""];
    a4b2 [style=invis, label=""];
    a4b3 [style=invis, label=""];
    a4b4 [style=invis, label=""];
    a4b5 [style=invis, label=""];
    a4b6 [style=invis, label=""];
    a4b7 [style=invis, label=""];
    a4b8 [style=invis, label=""];
    a4b9 [style=invis, label=""];
    a4b10 [style=invis, label=""];
    a4b11 [style=invis, label=""];
    a4b12 [style=invis, label=""];

    a5b1 [style=invis, label=""];
    a5b2 [style=invis, label=""];
    a5b4 [style=invis, label=""];
    a5b5 [style=invis, label=""];
    a5b6 [style=invis, label=""];
    a5b7 [style=invis, label=""];
    a5b8 [style=invis, label=""];
    a5b9 [style=invis, label=""];
    a5b10 [style=invis, label=""];
    a5b11 [style=invis, label=""];
    a5b12 [style=invis, label=""];

    a6b1 [style=invis, label=""];
    a6b2 [style=invis, label=""];
    a6b3 [style=invis, label=""];
    a6b4 [style=invis, label=""];
    a6b5 [style=invis, label=""];
    a6b6 [style=invis, label=""];
    a6b7 [style=invis, label=""];
    a6b8 [style=invis, label=""];
    a6b9 [style=invis, label=""];
    a6b10 [style=invis, label=""];
    a6b11 [style=invis, label=""];
    a6b12 [style=invis, label=""];

    a7b1 [style=invis, label=""];
    a7b2 [style=invis, label=""];
    a7b3 [style=invis, label=""];
    a7b4 [style=invis, label=""];
    a7b5 [style=invis, label=""];
    a7b6 [style=invis, label=""];
    a7b7 [style=invis, label=""];
    a7b8 [style=invis, label=""];
    a7b9 [style=invis, label=""];
    a7b10 [style=invis, label=""];
    a7b11 [style=invis, label=""];
    a7b12 [style=invis, label=""];

    a8b1 [style=invis, label=""];
    a8b2 [style=invis, label=""];
    a8b3 [style=invis, label=""];
    a8b4 [style=invis, label=""];
    a8b5 [style=invis, label=""];
    a8b6 [style=invis, label=""];
    a8b7 [style=invis, label=""];
    a8b8 [style=invis, label=""];
    a8b9 [style=invis, label=""];
    a8b10 [style=invis, label=""];
    a8b11 [style=invis, label=""];
    a8b12 [style=invis, label=""];

    a9b1 [style=invis, label=""];
    a9b2 [style=invis, label=""];
    a9b3 [style=invis, label=""];
    a9b4 [style=invis, label=""];
    a9b5 [style=invis, label=""];
    a9b6 [style=invis, label=""];
    a9b7 [style=invis, label=""];
    a9b8 [style=invis, label=""];
    a9b9 [style=invis, label=""];
    a9b10 [style=invis, label=""];
    a9b11 [style=invis, label=""];
    a9b12 [style=invis, label=""];

    a10b1 [style=invis, label=""];
    a10b2 [style=invis, label=""];
    a10b3 [style=invis, label=""];
    a10b4 [style=invis, label=""];
    a10b5 [style=invis, label=""];
    a10b6 [style=invis, label=""];
    a10b7 [style=invis, label=""];
    a10b8 [style=invis, label=""];
    a10b9 [style=invis, label=""];
    a10b10 [style=invis, label=""];
    a10b11 [style=invis, label=""];
    a10b12 [style=invis, label=""];

    a11b1 [style=invis, label=""];
    a11b2 [style=invis, label=""];
    a11b3 [style=invis, label=""];
    a11b4 [style=invis, label=""];
    a11b5 [style=invis, label=""];
    a11b6 [style=invis, label=""];
    a11b7 [style=invis, label=""];
    a11b8 [style=invis, label=""];
    a11b9 [style=invis, label=""];
    a11b10 [style=invis, label=""];
    a11b11 [style=invis, label=""];
    a11b12 [style=invis, label=""];

    a12b1 [style=invis, label=""];
    a12b2 [style=invis, label=""];
    a12b3 [style=invis, label=""];
    a12b4 [style=invis, label=""];
    a12b5 [style=invis, label=""];
    a12b6 [style=invis, label=""];
    a12b7 [style=invis, label=""];
    a12b8 [style=invis, label=""];
    a12b9 [style=invis, label=""];
    a12b10 [style=invis, label=""];
    a12b11 [style=invis, label=""];
    a12b12 [style=invis, label=""];

    { rank=same; a1b1; a1b2; a1b3; a1b4; a1b5; a1b6; a1b7; a1b8; a1b9; a1b10; a1b11; a1b12; }
    { rank=same; a2b1; a2b2; a2b3; a2b4; a2b5; a2b6; a2b7; a2b8; a2b9; a2b10; a2b11; a2b12; }
    { rank=same; a3b1; a3b2; a3b3; a3b4; a3b5; a3b6; a3b7; a3b8; a3b9; a3b10; a3b11; a3b12; }
    { rank=same; a4b1; a4b2; a4b3; a4b4; a4b5; a4b6; a4b7; a4b8; a4b9; a4b10; a4b11; a4b12; }
    { rank=same; a5b1; a5b2; a5b3; a5b4; a5b5; a5b6; a5b7; a5b8; a5b9; a5b10; a5b11; a5b12; }
    { rank=same; a6b1; a6b2; a6b3; a6b4; a6b5; a6b6; a6b7; a6b8; a6b9; a6b10; a6b11; a6b12; }
    { rank=same; a7b1; a7b2; a7b3; a7b4; a7b5; a7b6; a7b7; a7b8; a7b9; a7b10; a7b11; a7b12; }
    { rank=same; a8b1; a8b2; a8b3; a8b4; a8b5; a8b6; a8b7; a8b8; a8b9; a8b10; a8b11; a8b12; }
    { rank=same; a9b1; a9b2; a9b3; a9b4; a9b5; a9b6; a9b7; a9b8; a9b9; a9b10; a9b11; a9b12; }
    { rank=same; a10b1; a10b2; a10b3; a10b4; a10b5; a10b6; a10b7; a10b8; a10b9; a10b10; a10b11; a10b12; }
    { rank=same; a11b1; a11b2; a11b3; a11b4; a11b5; a11b6; a11b7; a11b8; a11b9; a11b10; a11b11; a11b12; }
    { rank=same; a12b1; a12b2; a12b3; a12b4; a12b5; a12b6; a12b7; a12b8; a12b9; a12b10; a12b11; a12b12; }

    // Horizontal edges (Row 1)
    a1b3 -> a1b8 [dir=both, style=invis, label=""]
    a1b2 -> a1b3 [dir=both, style=invis, label=""];
    a1b3 -> a1b4 [dir=both, style=invis, label=""];
    a1b4 -> a1b8 [dir=both, style=invis, label=""];

    //inactive
    a1b1 -> a1b2 [dir=both, style=invis, label=""];
    a1b4 -> a1b5 [dir=both, style=invis, label=""];
    a1b5 -> a1b6 [dir=both, style=invis, label=""];
    a1b6 -> a1b7 [dir=both, style=invis, label=""];
    a1b7 -> a1b8 [dir=both, style=invis, label=""];
    a1b8 -> a1b9 [dir=both, style=invis, label=""];
    a1b9 -> a1b10 [dir=both, style=invis, label=""];
    a1b10 -> a1b11 [dir=both, style=invis, label=""];
    a1b11 -> a1b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 2)
    a2b1 -> a2b2 [dir=both, style=invis, label=""];
    a2b2 -> a2b3 [dir=both, style=invis, label=""];
    a2b3 -> a2b4 [dir=both, style=invis, label=""];
    a2b4 -> a2b5 [dir=both, style=invis, label=""];
    a2b5 -> a2b6 [dir=both, style=invis, label=""];
    a2b6 -> a2b7 [dir=both, style=invis, label=""];
    a2b7 -> a2b8 [dir=both, style=invis, label=""];
    a2b8 -> a2b9 [dir=both, style=invis, label=""];
    a2b9 -> a2b10 [dir=both, style=invis, label=""];
    a2b10 -> a2b11 [dir=both, style=invis, label=""];
    a2b11 -> a2b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 3)
    a3b1 -> a3b5 [dir=both, label="a"];
    // inactive
    a3b1 -> a3b2 [dir=both, style=invis, label=""];
    a3b2 -> a3b3 [dir=both, style=invis, label=""];
    a3b3 -> a3b4 [dir=both, style=invis, label=""];
    a3b4 -> a3b5 [dir=both, style=invis, label=""];
    a3b5 -> a3b6 [dir=both, style=invis, label=""];
    a3b6 -> a3b7 [dir=both, style=invis, label=""];
    a3b7 -> a3b8 [dir=both, style=invis, label=""];
    a3b8 -> a3b9 [dir=both, style=invis, label=""];
    a3b9 -> a3b10 [dir=both, style=invis, label=""];
    a3b10 -> a3b11 [dir=both, style=invis, label=""];
    a3b11 -> a3b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 4)
    a4b1 -> a4b6 [dir=both, style=invis, label=""];
    // inactive
    a4b1 -> a4b2 [dir=both, style=invis, label=""];
    a4b2 -> a4b3 [dir=both, style=invis, label=""];
    a4b3 -> a4b4 [dir=both, style=invis, label=""];
    a4b4 -> a4b5 [dir=both, style=invis, label=""];
    a4b5 -> a4b6 [dir=both, style=invis, label=""];
    a4b6 -> a4b7 [dir=both, style=invis, label=""];
    a4b7 -> a4b8 [dir=both, style=invis, label=""];
    a4b8 -> a4b9 [dir=both, style=invis, label=""];
    a4b9 -> a4b10 [dir=both, style=invis, label=""];
    a4b10 -> a4b11 [dir=both, style=invis, label=""];
    a4b11 -> a4b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 5)
    a5b3 -> a5b7 [dir=both, style=invis, label=""];
    // inactive
    a5b1 -> a5b2 [dir=both, style=invis, label=""];
    a5b2 -> a5b3 [dir=both, style=invis, label=""];
    a5b3 -> a5b4 [dir=both, style=invis, label=""];
    a5b4 -> a5b5 [dir=both, style=invis, label=""];
    a5b5 -> a5b6 [dir=both, style=invis, label=""];
    a5b6 -> a5b7 [dir=both, style=invis, label=""];
    a5b7 -> a5b8 [dir=both, style=invis, label=""];
    a5b8 -> a5b9 [dir=both, style=invis, label=""];
    a5b9 -> a5b10 [dir=both, style=invis, label=""];
    a5b10 -> a5b11 [dir=both, style=invis, label=""];
    a5b11 -> a5b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 6)
    a6b1 -> a6b2 [dir=both, style=invis, label=""];
    a6b2 -> a6b3 [dir=both, style=invis, label=""];
    a6b3 -> a6b4 [dir=both, style=invis, label=""];
    a6b4 -> a6b5 [dir=both, style=invis, label=""];
    a6b5 -> a6b6 [dir=both, style=invis, label=""];
    a6b6 -> a6b7 [dir=both, style=invis, label=""];
    a6b7 -> a6b8 [dir=both, style=invis, label=""];
    a6b8 -> a6b9 [dir=both, style=invis, label=""];
    a6b9 -> a6b10 [dir=both, style=invis, label=""];
    a6b10 -> a6b11 [dir=both, style=invis, label=""];
    a6b11 -> a6b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 7)
    a7b5 -> a7b9 [dir=both, style=invis, label=""];
    // inactive
    a7b1 -> a7b2 [dir=both, style=invis, label=""];
    a7b2 -> a7b3 [dir=both, style=invis, label=""];
    a7b3 -> a7b4 [dir=both, style=invis, label=""];
    a7b4 -> a7b5 [dir=both, style=invis, label=""];
    a7b5 -> a7b6 [dir=both, style=invis, label=""];
    a7b6 -> a7b7 [dir=both, style=invis, label=""];
    a7b7 -> a7b8 [dir=both, style=invis, label=""];
    a7b8 -> a7b9 [dir=both, style=invis, label=""];
    a7b9 -> a7b10 [dir=both, style=invis, label=""];
    a7b10 -> a7b11 [dir=both, style=invis, label=""];
    a7b11 -> a7b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 8)
    a8b1 -> a8b10 [dir=both, style=invis, label=""];
    // inactive
    a8b1 -> a8b2 [dir=both, style=invis, label=""];
    a8b2 -> a8b3 [dir=both, style=invis, label=""];
    a8b3 -> a8b4 [dir=both, style=invis, label=""];
    a8b4 -> a8b5 [dir=both, style=invis, label=""];
    a8b5 -> a8b6 [dir=both, style=invis, label=""];
    a8b6 -> a8b7 [dir=both, style=invis, label=""];
    a8b7 -> a8b8 [dir=both, style=invis, label=""];
    a8b8 -> a8b9 [dir=both, style=invis, label=""];
    a8b9 -> a8b10 [dir=both, style=invis, label=""];
    a8b10 -> a8b11 [dir=both, style=invis, label=""];
    a8b11 -> a8b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 9)
    a9b7 -> a9b11 [dir=both, style=invis, label=""];
    // inactive
    a9b1 -> a9b2 [dir=both, style=invis, label=""];
    a9b2 -> a9b3 [dir=both, style=invis, label=""];
    a9b3 -> a9b4 [dir=both, style=invis, label=""];
    a9b4 -> a9b5 [dir=both, style=invis, label=""];
    a9b5 -> a9b6 [dir=both, style=invis, label=""];
    a9b6 -> a9b7 [dir=both, style=invis, label=""];
    a9b7 -> a9b8 [dir=both, style=invis, label=""];
    a9b8 -> a9b9 [dir=both, style=invis, label=""];
    a9b9 -> a9b10 [dir=both, style=invis, label=""];
    a9b10 -> a9b11 [dir=both, style=invis, label=""];
    a9b11 -> a9b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 10)
    a10b8 -> a10b12 [dir=both, style=invis, label=""];
    // inactive
    a10b1 -> a10b2 [dir=both, style=invis, label=""];
    a10b2 -> a10b3 [dir=both, style=invis, label=""];
    a10b3 -> a10b4 [dir=both, style=invis, label=""];
    a10b4 -> a10b5 [dir=both, style=invis, label=""];
    a10b5 -> a10b6 [dir=both, style=invis, label=""];
    a10b6 -> a10b7 [dir=both, style=invis, label=""];
    a10b7 -> a10b8 [dir=both, style=invis, label=""];
    a10b8 -> a10b9 [dir=both, style=invis, label=""];
    a10b9 -> a10b10 [dir=both, style=invis, label=""];
    a10b10 -> a10b11 [dir=both, style=invis, label=""];
    a10b11 -> a10b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 11)
    a11b1 -> a11b2 [dir=both, style=invis, label=""];
    a11b2 -> a11b3 [dir=both, style=invis, label=""];
    a11b3 -> a11b4 [dir=both, style=invis, label=""];
    a11b4 -> a11b5 [dir=both, style=invis, label=""];
    a11b5 -> a11b6 [dir=both, style=invis, label=""];
    a11b6 -> a11b7 [dir=both, style=invis, label=""];
    a11b7 -> a11b8 [dir=both, style=invis, label=""];
    a11b8 -> a11b9 [dir=both, style=invis, label=""];
    a11b9 -> a11b10 [dir=both, style=invis, label=""];
    a11b10 -> a11b11 [dir=both, style=invis, label=""];
    a11b11 -> a11b12 [dir=both, style=invis, label=""];

    // Horizontal edges (Row 12)
    a12b1 -> a12b2 [dir=both, style=invis, label=""];
    a12b2 -> a12b3 [dir=both, style=invis, label=""];
    a12b3 -> a12b4 [dir=both, style=invis, label=""];
    a12b4 -> a12b5 [dir=both, style=invis, label=""];
    a12b5 -> a12b6 [dir=both, style=invis, label=""];
    a12b6 -> a12b7 [dir=both, style=invis, label=""];
    a12b7 -> a12b8 [dir=both, style=invis, label=""];
    a12b8 -> a12b9 [dir=both, style=invis, label=""];
    a12b9 -> a12b10 [dir=both, style=invis, label=""];
    a12b10 -> a12b11 [dir=both, style=invis, label=""];
    a12b11 -> a12b12 [dir=both, style=invis, label=""];

    // Vertical edges (Column 1)
    a3b1 -> a8b1 [dir=both, style=invis, label=""]
    a2b1 -> a3b1 [dir=both, style=invis, label=""];
    a3b1 -> a4b1 [dir=both, style=invis, label=""];
    a4b1 -> a8b1 [dir=both, style=invis, label=""];
    // inactive
    a1b1 -> a2b1 [dir=both, style=invis, label=""];
    a4b1 -> a5b1 [dir=both, style=invis, label=""];
    a5b1 -> a6b1 [dir=both, style=invis, label=""];
    a6b1 -> a7b1 [dir=both, style=invis, label=""];
    a7b1 -> a8b1 [dir=both, style=invis, label=""];
    a8b1 -> a9b1 [dir=both, style=invis, label=""];
    a9b1 -> a10b1 [dir=both, style=invis, label=""];
    a10b1 -> a11b1 [dir=both, style=invis, label=""];
    a11b1 -> a12b1 [dir=both, style=invis, label=""];

    // Vertical edges (Column 2)
    a1b2 -> a2b2 [dir=both, style=invis, label=""];
    a2b2 -> a3b2 [dir=both, style=invis, label=""];
    a3b2 -> a4b2 [dir=both, style=invis, label=""];
    a4b2 -> a5b2 [dir=both, style=invis, label=""];
    a5b2 -> a6b2 [dir=both, style=invis, label=""];
    a6b2 -> a7b2 [dir=both, style=invis, label=""];
    a7b2 -> a8b2 [dir=both, style=invis, label=""];
    a8b2 -> a9b2 [dir=both, style=invis, label=""];
    a9b2 -> a10b2 [dir=both, style=invis, label=""];
    a10b2 -> a11b2 [dir=both, style=invis, label=""];
    a11b2 -> a12b2 [dir=both, style=invis, label=""];

    // Vertical edges (Column 3)
    a1b3 -> a5b3 [dir=both, label="b"];
    // inactive
    a1b3 -> a2b3 [dir=both, style=invis, label=""];
    a2b3 -> a3b3 [dir=both, style=invis, label=""];
    a3b3 -> a4b3 [dir=both, style=invis, label=""];
    a4b3 -> a5b3 [dir=both, style=invis, label=""];
    a5b3 -> a6b3 [dir=both, style=invis, label=""];
    a6b3 -> a7b3 [dir=both, style=invis, label=""];
    a7b3 -> a8b3 [dir=both, style=invis, label=""];
    a8b3 -> a9b3 [dir=both, style=invis, label=""];
    a9b3 -> a10b3 [dir=both, style=invis, label=""];
    a10b3 -> a11b3 [dir=both, style=invis, label=""];
    a11b3 -> a12b3 [dir=both, style=invis, label=""];

    // Vertical edges (Column 4)
    a1b4 -> a6b4 [dir=both, style=invis, label=""];
    a1b4 -> a2b4 [dir=both, style=invis, label=""];
    a2b4 -> a3b4 [dir=both, style=invis, label=""];
    a3b4 -> a4b4 [dir=both, style=invis, label=""];
    a4b4 -> a5b4 [dir=both, style=invis, label=""];
    a5b4 -> a6b4 [dir=both, style=invis, label=""];
    a6b4 -> a7b4 [dir=both, style=invis, label=""];
    a7b4 -> a8b4 [dir=both, style=invis, label=""];
    a8b4 -> a9b4 [dir=both, style=invis, label=""];
    a9b4 -> a10b4 [dir=both, style=invis, label=""];
    a10b4 -> a11b4 [dir=both, style=invis, label=""];
    a11b4 -> a12b4 [dir=both, style=invis, label=""];

    // Vertical edges (Column 5)
    a3b5 -> a7b5 [dir=both, style=invis, label=""];
    a1b5 -> a2b5 [dir=both, style=invis, label=""];
    a2b5 -> a3b5 [dir=both, style=invis, label=""];
    a3b5 -> a4b5 [dir=both, style=invis, label=""];
    a4b5 -> a5b5 [dir=both, style=invis, label=""];
    a5b5 -> a6b5 [dir=both, style=invis, label=""];
    a6b5 -> a7b5 [dir=both, style=invis, label=""];
    a7b5 -> a8b5 [dir=both, style=invis, label=""];
    a8b5 -> a9b5 [dir=both, style=invis, label=""];
    a9b5 -> a10b5 [dir=both, style=invis, label=""];
    a10b5 -> a11b5 [dir=both, style=invis, label=""];
    a11b5 -> a12b5 [dir=both, style=invis, label=""];

    // Vertical edges (Column 6)
    a1b6 -> a2b6 [dir=both, style=invis, label=""];
    a2b6 -> a3b6 [dir=both, style=invis, label=""];
    a3b6 -> a4b6 [dir=both, style=invis, label=""];
    a4b6 -> a5b6 [dir=both, style=invis, label=""];
    a5b6 -> a6b6 [dir=both, style=invis, label=""];
    a6b6 -> a7b6 [dir=both, style=invis, label=""];
    a7b6 -> a8b6 [dir=both, style=invis, label=""];
    a8b6 -> a9b6 [dir=both, style=invis, label=""];
    a9b6 -> a10b6 [dir=both, style=invis, label=""];
    a10b6 -> a11b6 [dir=both, style=invis, label=""];
    a11b6 -> a12b6 [dir=both, style=invis, label=""];

    // Vertical edges (Column 7)
    a5b7 -> a9b7 [dir=both, style=invis, label=""];
    a1b7 -> a2b7 [dir=both, style=invis, label=""];
    a2b7 -> a3b7 [dir=both, style=invis, label=""];
    a3b7 -> a4b7 [dir=both, style=invis, label=""];
    a4b7 -> a5b7 [dir=both, style=invis, label=""];
    a5b7 -> a6b7 [dir=both, style=invis, label=""];
    a6b7 -> a7b7 [dir=both, style=invis, label=""];
    a7b7 -> a8b7 [dir=both, style=invis, label=""];
    a8b7 -> a9b7 [dir=both, style=invis, label=""];
    a9b7 -> a10b7 [dir=both, style=invis, label=""];
    a10b7 -> a11b7 [dir=both, style=invis, label=""];
    a11b7 -> a12b7 [dir=both, style=invis, label=""];

    // Vertical edges (Column 8)
    a1b8 -> a10b8 [dir=both, style=invis, label=""];
    a1b8 -> a2b8 [dir=both, style=invis, label=""];
    a2b8 -> a3b8 [dir=both, style=invis, label=""];
    a3b8 -> a4b8 [dir=both, style=invis, label=""];
    a4b8 -> a5b8 [dir=both, style=invis, label=""];
    a5b8 -> a6b8 [dir=both, style=invis, label=""];
    a6b8 -> a7b8 [dir=both, style=invis, label=""];
    a7b8 -> a8b8 [dir=both, style=invis, label=""];
    a8b8 -> a9b8 [dir=both, style=invis, label=""];
    a9b8 -> a10b8 [dir=both, style=invis, label=""];
    a10b8 -> a11b8 [dir=both, style=invis, label=""];
    a11b8 -> a12b8 [dir=both, style=invis, label=""];

    // Vertical edges (Column 9)
    a7b9 -> a11b9 [dir=both, style=invis, label=""];
    a1b9 -> a2b9 [dir=both, style=invis, label=""];
    a2b9 -> a3b9 [dir=both, style=invis, label=""];
    a3b9 -> a4b9 [dir=both, style=invis, label=""];
    a4b9 -> a5b9 [dir=both, style=invis, label=""];
    a5b9 -> a6b9 [dir=both, style=invis, label=""];
    a6b9 -> a7b9 [dir=both, style=invis, label=""];
    a7b9 -> a8b9 [dir=both, style=invis, label=""];
    a8b9 -> a9b9 [dir=both, style=invis, label=""];
    a9b9 -> a10b9 [dir=both, style=invis, label=""];
    a10b9 -> a11b9 [dir=both, style=invis, label=""];
    a11b9 -> a12b9 [dir=both, style=invis, label=""];

    // Vertical edges (Column 10)
    a8b10 -> a12b10 [dir=both, style=invis, label=""];
    a1b10 -> a2b10 [dir=both, style=invis, label=""];
    a2b10 -> a3b10 [dir=both, style=invis, label=""];
    a3b10 -> a4b10 [dir=both, style=invis, label=""];
    a4b10 -> a5b10 [dir=both, style=invis, label=""];
    a5b10 -> a6b10 [dir=both, style=invis, label=""];
    a6b10 -> a7b10 [dir=both, style=invis, label=""];
    a7b10 -> a8b10 [dir=both, style=invis, label=""];
    a8b10 -> a9b10 [dir=both, style=invis, label=""];
    a9b10 -> a10b10 [dir=both, style=invis, label=""];
    a10b10 -> a11b10 [dir=both, style=invis, label=""];
    a11b10 -> a12b10 [dir=both, style=invis, label=""];

    // Vertical edges (Column 11)
    a1b11 -> a2b11 [dir=both, style=invis, label=""];
    a2b11 -> a3b11 [dir=both, style=invis, label=""];
    a3b11 -> a4b11 [dir=both, style=invis, label=""];
    a4b11 -> a5b11 [dir=both, style=invis, label=""];
    a5b11 -> a6b11 [dir=both, style=invis, label=""];
    a6b11 -> a7b11 [dir=both, style=invis, label=""];
    a7b11 -> a8b11 [dir=both, style=invis, label=""];
    a8b11 -> a9b11 [dir=both, style=invis, label=""];
    a9b11 -> a10b11 [dir=both, style=invis, label=""];
    a10b11 -> a11b11 [dir=both, style=invis, label=""];
    a11b11 -> a12b11 [dir=both, style=invis, label=""];

    // Vertical edges (Column 12)
    a1b12 -> a2b12 [dir=both, style=invis, label=""];
    a2b12 -> a3b12 [dir=both, style=invis, label=""];
    a3b12 -> a4b12 [dir=both, style=invis, label=""];
    a4b12 -> a5b12 [dir=both, style=invis, label=""];
    a5b12 -> a6b12 [dir=both, style=invis, label=""];
    a6b12 -> a7b12 [dir=both, style=invis, label=""];
    a7b12 -> a8b12 [dir=both, style=invis, label=""];
    a8b12 -> a9b12 [dir=both, style=invis, label=""];
    a9b12 -> a10b12 [dir=both, style=invis, label=""];
    a10b12 -> a11b12 [dir=both, style=invis, label=""];
    a11b12 -> a12b12 [dir=both, style=invis, label=""];
}
    ```
    )]
    #v(-30em)

    _Iteration 4_: $a$ knows, $b$ does not know

    How can $a$ know their number? Scenarios:
    1. $a$ sees $n_b = 1$: Then $a$ would know $n_a = 3$. 
    2. $a$ sees $n_b = 3$: $G_3 (3) = {1,5}$, so $a$ couldn't truthfully announce that they know $n_a$, since there would be $2$ choices left.
    3. $a$ sees $n_b = 5$: Then $a$ would know $n_a = 3$. 

    Thus, we rule out scenario 2. In either scenario 1 or 3, $n_a = 3$.
  ]


3. _(30 points)_
#let dex3(formula) = $#distributed-k($(formula)$, inf: $a,b$)$

  (a) _(15 points)_ Is the following formula valid or not on epistemic models with two agents (a and b)?
    
    $ #knowledge($(dex3(p) or dex3(not p))$, inf: $a$) => dex3(#knowledge($(p)$, inf: $a$) or #knowledge($(not p)$, inf: $a$)) $<mol_del_hw1_ex3_a>
    
    *If your answer is yes, then give a semantic argument for this* (by reasoning on possible worlds in any arbitrary epistemic model, using the semantic clauses for $#knowledge("")$, $#distributed-k($$, inf: $a,b$)$, and propositional connectives). *If you are answer is no, then provide a counterexample* (by drawing an epistemic model, and presenting some world in that model, and showing that the premise is true and the conclusion false in that world).
    
    NOTE: Recall that epistemic models are Kripke models in which all relations are equivalence relations, $#knowledge("", inf: $x$)$ represents knowledge by a specific agent (indicated by the subscript $x$), while $#distributed-k($$, inf: $a,b$)$ represents distributed knowledge (in the group composed of agents $a$ and $b$).

    #callout(title:"Answer to Exercise 3 (a)")[
      Let $cal(A) = {a,b}$.

      Countermodel $#model = (S, {tilde_alpha}_(alpha in cal(A)), interpretation(dot))$: (Reflexive and transitive connections not drawn for simplicity)

      #graph-figure(
        ```dot
        graph G {
          node [shape=square, style=rounded];
          rankdir="LR";

          s [label= "s", xlabel="p"];
          t [label= "t", xlabel="p"];
          r [label= "r", xlabel="ㄱp"];
          
          s -- t [label="a,b"];
          t -- r [label="a"]

        }
        ```
      )

      _Proof Premise True:_

      The equivalence classes for the agents are:
      - $[s]_a = {s, t, r}$
      - $[s]_b = {s, t}$ and $[r]_b = {r}$

      The equivalence classes for distributed knowledge ($#distributed-k("",inf:$a,b$)$) are the intersections of the agents' classes:
      - $[s]_(a,b) = {s, t}$
      - $[r]_(a,b) = {r}$

      1. Since $forall x, y in {s,t}:x models_#model p$ and $[s]_(a,b) = {s,t}$, we deduce that $forall x in  [s]_(a,b)\:x models_#model #dex3($p$)$. 
      2. From $r models_model not p$ and $[r]_(a,b) = {r}$, we get $r models_model #dex3($not p$)$.

      By propositional weakening, we conclude $forall x in {s,t,r}: x models_#model (#dex3($p$) or #dex3($p$))$.

      Note $[s]_a = {r,s,t} = S$. Since the disjunction holds in all worlds $forall x in S: #dex3($p$) or #dex3($p$)$, we conclude $forall x in S: x models_model #knowledge($(#dex3($p$) or #dex3($p$))$, inf: $a$)$.

      _Proof conclusion false_: 

      In an S5 epistemic model, $x models #knowledge($(phi)$, inf: $a$)$ iff $phi$ is true in all worlds in $[x]_a$.
      - $s cancel(models) #knowledge($(p)$, inf: $a$)$ because $r in [s]_a$ and $r models not p$.
      - $s cancel(models) #knowledge($(p)$, inf: $a$)$ because $s in [s]_a$ and $s models p$.
      
      Since $#knowledge($(p)$, inf: $a$) and not #knowledge($(not p)$, inf: $a$)$ holds for all nodes, $dex3(#knowledge($(p)$, inf: $a$) or #knowledge($(not p)$, inf: $a$))$ cannot hold anywhere.
      #align(right,$square$)

    ]

  (b) _(15 points)_ Is the converse formula valid or not on epistemic models with two agents ($a$ and $b$)?
  
    $ dex3(#knowledge($(p)$, inf: $a$) or #knowledge($(not p)$, inf: $a$)) => #knowledge($(dex3(p) or dex3(not p))$, inf: $a$) $
    
    As before, *if your answer is yes then give a semantic argument for this, while you are answer is no then provide a counterexample.*

  #callout(title: "Answer to Exercise 3 (b)")[
    Take an arbitrary epistemic model $#model$ with two agents, w.l.o.g.: $cal(A)={a,b}$. Assume $models_model dex3(#knowledge($(p)$, inf: $a$) or #knowledge($(not p)$, inf: $a$))$. Take an arbitrary $s in model$. Denote its equivalence class under distributed knowledge as $[s]_(a,b)$.
    
    Note that  at most one term in the premise disjunction can hold at a time, since $#knowledge($(p)$, inf: $a$) and #knowledge($(not p)$, inf: $a$)$ is a contradiction. Thus, w.l.o.g., assume $s models_model dex3(#knowledge($(p)$, inf: $a$))$.
    
    Take an arbitrary $t$ s.t. $s tilde_a t$. Since $s models_model dex3(#knowledge($(p)$, inf: $a$))$, there must be a $w in [s]_(a,b)$: $w models_model #knowledge($(p)$, inf: $a$)$ (Note: $s tilde_a w$). Thus $forall x in [s]_(a,b): x models_model p$, in particular $s$ and $w$. From this we infer that $#dex3($p$)$ holds across $[s]_(a,b)$. By the Kripke semantics of distributed knowledge (intersection) $[s]_(a,b) subset.eq [s]_a$. Therefore, $w tilde_a t$ and from $w models_model #knowledge($(p)$, inf: $a$)$, we get $t models_model p$ and this holds across $[s]_a$. $forall x in [s]_(a): x models_model #dex3($p$)$. By propositional weakening $#dex3($p$) or #dex3($not p$)$ holds everywhere in $[s]_(a)$. By the semantics of knowledge, $#knowledge($(dex3(p) or dex3(not p))$, inf: $a$)$ holds across $[s]_a$, in particular at $s$, proving our goal.

    #align(right,$square$)
  ]