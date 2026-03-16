#import "examples/themes/filips-math-paper/template.typ": paper
#import "utils/callout.typ": callout, intuition, example, theorem, proof, attention, remember, question, info, note, notation,
#import "utils/def.typ": def, def-group
#import "utils/dot-graphviz.typ": graph-figure

#show: doc => paper(
  // Metadata
  journal: "Computational Complexity",
  title: "Homework set 3",
  subtitle: [Due March 17, 2026, at 23:30 \
  via #link("https://canvas.uva.nl/courses/56624/assignments/661481").],
  // date: datetime(year: 2024, month: 10, day: 24), // Or remove to use today's date
  font: "New Computer Modern",

  // Author Data
  authors: (
    (
      name: "Filip Rehburg", 
      email: "filip.rehburg@student.uva.nl", 
      affiliations: (1,) 
    ),
  ),

  // Institution Data
  institutions: (
    (
      name: "University of Amsterdam", 
      address: "Amsterdam, The Netherlands"
    ),
  ),
  
  // The actual document content follows
  doc
)

// custom definitions
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
#let S = $bold("S")$
#let S4 = $bold("S4")$
#let S5 = $bold("S5")$
#let K45 = $bold("K45")$
#let KD45 = $bold("KD45")$
//end custom definitions


#set par(justify: true)
#set enum(numbering: "1.")
#v(-2em)
=== Question 1 (26 points)

In a far away country, the queen is giving distinctions of honor by placing hats on the heads of remarkable people. Alice and Bob are each due to receive a distinction. It is common knowledge that the queen has only three hats left, namely 2 red hats and 1 white hat. The queen has placed hats on both Alice and Bob's heads, in such a way that each can see the other's hat, but not his/her own. Let us suppose that in fact the queen placed red hats on both their heads.

#enum(numbering: "1.",
  [_(5 points)_ Represent the above situation as an epistemic state model $S$, for a set $cal(A)={a,b,q}$ of three agents (Alice, Bob and the Queen) and a set $Phi={r_a,w_a,r_b,w_b}$ of four atomic sentences (describing the colors of Alice's and Bob's hats).
  ],
  [_(7 points)_ Write a sentence in epistemic logic encoding all of the above information (including the knowledge of Alice and Bob about each other and themselves, the queen's knowledge and the common knowledge).
  ],
  [_(7 points)_ Now the following action happens: secretly and separately from each other, Alice and Bob look in their mirrors and see their own (red!) hats ; none of them suspects that the other one is doing this ; and each of them knows that the other doesn't suspect anything. Moreover, each of them thinks that the queen doesn't suspect them either. But in fact, the queen can see both of them, so she knows they're looking in the mirror. Represent all this scenario using an event model $Sigma$, with 4 actions.
  ],
  [_(7 points)_ Compute the update product $S times.circle Sigma$ of the two models, and draw the resulting state model.
  ],
)

#callout(title: "Answer to Exercise 1")[
  #enum(numbering: "1.",
    [
      $#S$:
      #graph-figure(
        ```dot
        digraph G {
          node [shape=square, style=rounded, fontsize=16, fixedsize=true, width=0.8, height=0.8];
          edge [arrowhead="plain", arrowtail="plain", fontsize=16];

          {
            rank=same;
            rr [label = "r_a, r_b *"];
            wr [label = "w_a, r_b"];
            rw [label = "r_a, w_b"];
          }
          
          // Linear connections
          wr -> rr [label="a"];
          rr -> rw [label="b"];

          // Reflexive connections (self-loops) all routed to the North (top)
          wr -> wr [label="a,b,q", headport="n", tailport="n"];
          rr -> rr [label="a,b,q", headport="n", tailport="n"];
          rw -> rw [label="a,b,q", headport="n", tailport="n"];
        }
        ```
      )
    ],
    [
      $ phi_q = #knowledge($(r_a and r_b)$, inf: $q$) \ 
  
      phi_C = #common-k($(not (w_a and w_b) and (r_a arrow.r.l not w_a) and (r_b arrow.r.l not w_b) and \ 
      (r_b arrow knowledge(r_b,inf: a)) and (w_b arrow knowledge(w_b,inf: a)) and (r_a arrow knowledge(r_a, inf: b)) and (w_a arrow knowledge(w_a, inf: b)) and \ 
      (r_b arrow knowledge(r_b,inf: q)) and (w_b arrow knowledge(w_b,inf: q)) and (r_a arrow knowledge(r_a, inf: q)) and (w_a arrow knowledge(w_a, inf: q)) )$)  \
      phi_1 = phi_q and phi_C
      $
    ],
    [
      $bold(Sigma)$, where $e_(a b)$ denotes the case that $a$ and $b$ look into the mirror, both seeing red and $q$ sees them both. $e_a$ denotes the event that $a$ looks in the mirror seeing red, without suspecting $b$ doing so too or being seen by $q$. Similarly for $e_b$. $e_"skip"$ is the case that nothing happens.
      #grid(
        columns: (50%, 50%),
        [#graph-figure(
        ```dot
        digraph G {
          node [shape=circle, fontsize=16, fixedsize=true, width=0.6, height=0.6];
          edge [arrowhead=vee, arrowtail=vee, fontsize=16];
          rankdir=LR;

          e [label="e_(s k i p)"];
          ea [label="e_a"];
          eb [label="e_b"];
          eab [label="e_(a b) *"];

          eab -> ea [label="a"];
          eab -> eb [label="b"];
          eab -> eab [label="q"];

          ea -> ea [label="a"];
          eb -> eb [label="b"];

          ea -> e [label="b,q"]; eb -> e [label="a,q"];
          e -> e [label="a,b,q"]
        }
        ```
      )],
      [
        $ "pre"(s) = cases({top} "if" s = e_"skip", {r_a} "if" s = e_a, {r_b} "if" s = e_b, {r_a, r_b} "if" s = e_(a b)) $
      ]
      )
    ],
    [
      $#S times.o bold(Sigma)$
      #graph-figure(
        ```dot
        digraph G {
          node [shape=square, style=rounded, fontsize=16, fixedsize=true, width=1, height=1];
          edge [arrowhead="plain", arrowtail="plain", fontsize=16];
          
          {
            rank=same;
            rrab [label="r_a r_b e_(a b)*"];
            rra [label="r_a r_b e_a"];
            rrb [label="r_a r_b e_b"];
            rrt [label="r_a r_b e_(s k i p)"];
          }
          {
            rank=same;
            wrb [label="w_a r_b e_b"];
            rwa [label="r_a w_b e_a"];
          }

          {
            rank=same;
            wrt [label="w_a r_b e_(s k i p)"];
            rwt [label="r_a w_b e_(s k i p)"];
          }

          rrab -> rrab [label="q", arrowport=w, tailport=w]
          rrab -> rra [label="a"];
          rrab -> rrb [label="b"];

          rra -> rra [label="a \ \ \ \ \ \ \ .", arrowport="n", tailport="n"];
          rra -> rrt [label="b,q"];
          rra -> rwt [label="b"];

          rrb -> rrb [label="b"];
          rrb -> rrt [label="a,q \ \ \ \ \ \ \ ."];
          rrb -> wrt [label="a"];

          rrt -> rrt [label="a,b,q"];
          // rrt -> wrt [label="a"];
          rrt -> rwt [label="b", dir=both];

          wrb -> rrt [label="a"];
          wrb -> wrb [label="b"];
          wrb -> wrt [label="a,q"];

          wrt -> rrt [label="a", dir=both];
          wrt -> wrt [label="a,b,q"];

          rwa -> rrt [label="b"];
          rwa -> rwa [label="a"];
          rwa -> rwt [label="b,q"];

          // rwt -> rrt [label="b"];
          rwt -> rwt [label="a,b,q"];
        }
        ```
      )
    ],
  )
]

=== Question 2 (38 points)

There are four agents: Alice, Bob, Charles and Eve (the evil outsider). A coin is on the table, and it is common knowledge that Alice, and ONLY Alice, can see the upper face of the coin. Let's suppose that, in reality, the coin lies Heads up.

#enum(numbering: "1.",
  [_(5 points)_ Represent (draw) this situation as a state model $M_0$ (Use atomic sentences H, T, where H means that the coin lies Heads up, T means that the coin lies Tails up. Draw the accessibility relations $R_a$, $R_b$, $R_c$ and $R_e$ for each agent, indicate which atomic sentences hold at which states, and mark the "real" world with a star.) 
  ],
  [_(6 points)_ Alice sends a private email message to Bob, with BCC (Blind Carbon Copy) to Charles, saying "The coin lies Heads up". It is common knowledge that Alice never lies, and that the message is sent over a secure channel and is guaranteed to instantly reach (and be read by) its recipients. (Recall how BCC works: being in BCC, Charles sees the email, including the fact that it was sent to Bob: but Bob cannot see the BCC, so he doesn't know that Charles also got this email!) Moreover, we assume that (it is common knowledge that) Bob believes the email to be a completely private communication between Alice and himself (so he doesn't even suspect that the email was sent with BCC). Finally, the evil Eve doesn't suspect any of this happening. Represent (draw) this action using an event model $Sigma$ with 3 actions. (Specify the actions' preconditions, draw relations $R_a$, $R_b$, $R_c$, $R_e$ representing agents' beliefs about what is going on, and specify which action is the "real" one.) 
  ],
  [_(5 points)_ Draw a state model $M_1$ for the situation after the action described in part 2, by computing the update product $M_1 = M_0 times.circle Sigma$.
  ],
  [_(6 points)_ Let us now consider an alternative scenario: everything goes as in part 2 (Alice attempting to privately send to Bob with BCC to Charles the same true message "The coin lies Heads up"), EXCEPT that in fact the evil outsider Eve hacks the communication channel. So, unknown, and unsuspected, by anybody else, Eve reads the message (including the name of the sender, the receiver, and of the BCC recipient). Nothing else changes (so the message, while secretly read by Eve, is still delivered to all its recipients). Represent this action using an event model $Sigma'$ with 4 actions.
  ],
  [_(5 points)_ Assuming we start again from the initial situation (in model $M_0$), draw a model $M_1'$ for the situation after the action described in the previous part, by computing the update product $M_1' = M_0 times.circle Sigma'$.
  ],
  [_(6 points)_ Finally, let us now consider yet another alternative scenario: everything goes as in part 4 (Alice attempting to privately send the message "The coin lies Heads up" to Bob with BCC to Charles, while Eve in fact hacks the communication channel and secretly reads the message), EXCEPT that in addition Eve blocks the message from being delivered to any of its recipients. (So Bob and Charles don't get any message, and don't even suspect this communication was attempted. Alice of course also doesn't suspect that her message was hacked and blocked.)  Represent this action using an event model $Sigma''$ with 4 actions.
  ],
  [_(5 points)_ Assuming we start again from the initial situation (in model $M_0$), draw a model $M_1''$ for the situation after the action described in the previous part, by computing the update product $M_1'' = M_0 times.circle Sigma''$.
  ],
)

#callout(title: "Answer to Exercise 2")[
  #enum(numbering: "1.",
    [
    $M_0$:
      #graph-figure(
        ```dot
        digraph G {
          node [shape=square, style=rounded, fontsize=16, fixedsize=true, width=0.8, height=0.8];
          edge [arrowhead="plain", arrowtail="plain", fontsize=16];

          {
            rank=same;
            T; H [label="H *"];
          }

          T -> H [label="b,c,e"];
          T -> T [label="a,b,c,e", arrowport="w", tailport="w"];
          H -> H [label="a,b,c,e"]
        }
        ```
      )
    ],
    [ 
      $bold(Sigma):$ $e_(b)$ is the action where $a$ sends a secret message to $b$, $e_(b c)$ is the action where $a$ also sends the BCC to $c$, and $e_"skip"$ is the action where nothing happens
      #grid(
        columns: (50%, 50%),
        [#graph-figure(
        ```dot
        digraph G {
          node [shape=circle, fontsize=16, fixedsize=true, width=0.8, height=0.8];
          edge [arrowhead="plain", arrowtail="plain", fontsize=16];
          rankdir=LR;

          {
            ebc [label="e_(b c) *"];
            eb [label="e_b"];
            e [label="e_(s k i p)"];
          }

          ebc -> ebc [label="a, c"];
          ebc -> eb [label="b"];
          ebc -> e [label="e"];

          eb -> eb [label="a,b"];
          eb -> e [label="c,e"];

          e -> e [label="a,b,c,e"]
          
        }
        ```
      )],
      [
        $ "pre"(s) = cases({top} "if" s = e_"skip", {H} "if" s = e_b, {H} "if" s = e_(b c)) $
      ]
      )
    ],
    [$M_1 = M_0 times.o bold(Sigma):$
      #graph-figure(
        ```dot
        digraph G {
          node [shape=square, style=rounded, fontsize=16, fixedsize=true, width=0.8, height=0.8];
          edge [arrowhead="plain", arrowtail="plain", fontsize=16];
          rankdir=LR;

          Ht [label="H e_(s k i p)"];
          Tt [label="T e_(s k i p)"]; 
          Hbc [label="H e_(b c) *"];
          Hb [label="H e_b"];

          Hbc -> Hbc [label="a,c"];
          Hbc -> Tt [label="e"];
          Hbc -> Ht [label="e"];
          Hbc -> Hb [label="b"];

          Hb -> Hb [label="a,b"];
          Hb -> Ht [label="c,e"];
          Hb -> Tt [label="c,e"];

          Ht -> Ht [label="a"];

          Ht -> Tt [label="b,c,e", dir="both"];

          Tt -> Tt [label="a"];
        }
        ```
      )
    ],
    [$bold(Sigma)^prime:$ $e_(b c e)$ is the action of $e$'s hack, the rest is the same as in 2.
      #grid(
        columns: (50%, 50%),
        [#graph-figure(
        ```dot
        digraph G {
          node [shape=circle, fontsize=16, fixedsize=true, width=0.8, height=0.8];
          edge [arrowhead="plain", arrowtail="plain", fontsize=16];
          rankdir=LR;

          {
            ebce [label="e_(b c e) *"]
            ebc [label="e_(b c)"];
            eb [label="e_b"];
            e [label="e_(s k i p)"];
          }

          ebce -> ebce [label="e"];
          ebce -> ebc [label="a,c"];
          ebce -> eb [label="b"];

          ebc -> ebc [label="a, c"];
          ebc -> eb [label="b"];
          ebc -> e [label="e"];

          eb -> eb [label="a,b"];
          eb -> e [label="c,e"];

          e -> e [label="a,b,c,e"]
          
        }
        ```
      )],
      [
        $ "pre"(s) = cases({top} "if" s = e_"skip", {H} "if" s = e_b, {H} "if" s = e_(b c), {H} "if" s = e_(b c e)) $
      ]
      )
    ],
    [$M_1^prime = M_0 times.o bold(Sigma)^prime:$
      #graph-figure(
        ```dot
        digraph G {
          node [shape=square, style=rounded, fontsize=16, fixedsize=true, width=0.8, height=0.8];
          edge [arrowhead="plain", arrowtail="plain", fontsize=16];
          rankdir=LR;

          Ht [label="H e_(s k i p)"];
          Tt [label="T e_(s k i p)"]; 
          Hbc [label="H e_(b c)"];
          Hbce [label="H e_(b c e) *"];
          Hb [label="H e_b"];

          Hbce -> Hbce [label="e"];
          Hbce -> Hbc [label="a,c"];
          Hbce -> Hb [label="b"];

          Hbc -> Hbc [label="a,c"];
          Hbc -> Tt [label="e"];
          Hbc -> Ht [label="e"];
          Hbc -> Hb [label="b"];

          Hb -> Hb [label="a,b"];
          Hb -> Ht [label="c,e"];
          Hb -> Tt [label="c,e"];

          Ht -> Ht [label="a"];

          Ht -> Tt [label="b,c,e", dir="both"];

          Tt -> Tt [label="a"];
        }
        ```
      )
    ],
  )
]

#callout(title: "Answer to Exercise 2 (continued)")[
  #enum(numbering: "1.", start: 6,
    [$bold(Sigma)^prime.double:$ $e_e$ is the action of $e$'s hack and delivery block, the rest is the same as in 2.
      #grid(
        columns: (50%, 50%),
        [#graph-figure(
        ```dot
        digraph G {
          node [shape=circle, fontsize=16, fixedsize=true, width=0.8, height=0.8];
          edge [arrowhead="plain", arrowtail="plain", fontsize=16];
          rankdir=LR;

          {
            ee [label="e_e *"]
            ebc [label="e_(b c)"];
            eb [label="e_b"];
            e [label="e_(s k i p)"];
          }

          ee -> ee [label="e"];
          ee -> e [label="b,c"];
          ee -> ebc [label="a"];

          ebc -> ebc [label="a, c"];
          ebc -> eb [label="b"];
          ebc -> e [label="e"];

          eb -> eb [label="a,b"];
          eb -> e [label="c,e"];

          e -> e [label="a,b,c,e"]
          
        }
        ```
      )],
      [
        $ "pre"(s) = cases({top} "if" s = e_"skip", {H} "if" s = e_b, {H} "if" s = e_(b c), {H} "if" s = e_(e)) $
      ]
      )
    ],
    [$M_1^prime.double = M_0 times.o bold(Sigma)^prime.double:$
      #graph-figure(
        ```dot
        digraph G {
          node [shape=square, style=rounded, fontsize=16, fixedsize=true, width=0.8, height=0.8];
          edge [arrowhead="plain", arrowtail="plain", fontsize=16];
          rankdir=LR;

          {
            rank=1;
            Hbc [label="H e_(b c)"];
            He [label="H e_e *"];
          };

          {
            rank=2;
            Hb [label="H e_b"];
          };
          {
            rank=3;
            Ht [label="H e_(s k i p)"];
            Tt [label="T e_(s k i p)"]; 
          };

          He -> He [label="e"];
          He -> Hbc [label="a"];
          He -> Ht [label="b,c"];
          He -> Tt [label="b,c"];

          Hbc -> Hbc [label="a,c", arrowport="w",tailport="s"];
          Hbc -> Tt [label="e"];
          Hbc -> Ht [label="e"];
          Hbc -> Hb [label="b"];

          Hb -> Hb [label="a,b"];
          Hb -> Ht [label="c,e"];
          Hb -> Tt [label="c,e"];

          Ht -> Ht [label="a"];

          Ht -> Tt [label="b,c,e", dir="both"];

          Tt -> Tt [label="a", arrowport="w",tailport="s"];
        }
        ```
      )
    ],
  )
]


=== Exercise 3 (36 points)

We say that a property $P$ is preserved by product update iff: for every initial Kripke model M having property $P$ and every event model $Sigma$ having property $P$, their product update $M times.o Sigma$ also has property $P$. For each of the properties below, specify whether or not they are preserved by product update. If your answer is "yes", give a brief semantic argument (proof). If your answer is "no", give a counterexample.

#enum(numbering: "1.",
  [_(9 points)_ symmetry: if $v R_a s$ then $s R_a w$.
  ],
  [_(9 points)_ transitivity: if $w R_a s$ and $s R_a t$ then $w R_a t$.
  ],
  [_(9 points)_ Euclideaness: if $w R_a s$ and $w R_a t$, then $s R_a t$.
  ],
  [_(9 points)_ Diamond property: if $w R_a s$ and $w R_a t$ then there exists some world v such that $s R_a v$ and $t R_a v$.
  ],
)

#callout(title: [Answer to Exercise 3])[
  #enum(numbering: "1.",
    [
      I don't think so.
    ],
    [
      
    ],
    [Answer here.
    ],
    [Answer here.
    ],
  )
]