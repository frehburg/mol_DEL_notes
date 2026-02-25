#import "utils/progress_bar.typ": *
#import "@preview/clean-math-paper:0.2.4": *
#import "examples/themes/filips-math-paper/template.typ": paper
#import "@preview/curryst:0.5.1": rule, prooftree
#import "utils/callout.typ": callout, intuition, example, theorem, proof, attention, remember, question, info, note, notation,
#import "utils/def.typ": def, def-group
#import "@preview/diagraph:0.3.6": *
#import "utils/splitgrid.typ": splitgrid
#import "utils/dot-graphviz.typ": graph-figure

#let date = datetime.today().display("[month repr:long] [day], [year]")

#show: doc => paper(
  // Metadata
  journal: "Dynamic Epistemic Logic",
  title: "Study Notes",
  subtitle: [],
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
    Session #lvl1\-#lvl2 #it.body
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

#let iff = $arrow.r.l.double$

*Instructor*: Alexandru Baltag (#link("mailto:TheAlexandruBaltag@gmail.com")) \ *TA*: Giuseppe Manes 
(#link("giuseppe.manes@student.uva.nl"))

Do not distribute, please send this link: #link("https://github.com/frehburg/mol_DEL_notes")

#outline(depth:2)
#pagebreak()



#let STATUS = (
  "NOT_SEEN": -1,
  "NOT_STARTED": 0,
  "WORK_IN_PROGRESS": 1,
  "DONE": 2,
)

#let STATUS_SYMBOL = (
  str(STATUS.NOT_SEEN): $emptyset$,
  str(STATUS.NOT_STARTED): $crossmark$,
  str(STATUS.WORK_IN_PROGRESS): $"WIP"$,
  str(STATUS.DONE): $checkmark$
)

#let lectures = (
  "l1-1": (
    "status": STATUS.DONE, "name": "Introduction: Motivation, Main Themes, Puzzles", "ref": ref(<lecture1-1>)
    ),
  "l1-2": (
    "status": STATUS.DONE, "name": "Main Themes, Puzzles, and Paradoxes Continued", "ref": ref(<lecture1-2>)
    ),
  "l1-3": (
    "status": STATUS.DONE, "name": "Single-Agent Epistemic-Doxastic Logics: Kripke Models", "ref": ref(<lecture1-3>)
    ),
  "l2-1": (
    "status": STATUS.WORK_IN_PROGRESS, "name": "Multi-agent Models and Public Announcement Logic (PAL)", "ref": ref(<lecture2-1>)
    ),
  "l2-2": (
    "status": STATUS.NOT_STARTED, "name": "PAL Continued", "ref": ref(<lecture2-2>)
    ),
  "l2-3": (
    "status": STATUS.NOT_STARTED, "name": "Does this one even exist??", "ref": ref(<lecture2-3>)
    ),
  "l3-1": (
    "status": STATUS.NOT_STARTED, "name": "\"Learnability\" and \"Knowability\"", "ref": ref(<lecture3-1>)
    ),
  "t3-2": (
    "status": STATUS.NOT_STARTED, "name": "Tutorial 1", "ref": ref(<tutorial3-2>)
    ),
  "l3-3": (
    "status": STATUS.NOT_STARTED, "name": "The problem of belief revision", "ref": ref(<lecture3-3>)
    ),
  "l4-1": ("status": STATUS.WORK_IN_PROGRESS, "name": "Cheating and the Failure of Standard DEL", "ref": ref(<lecture3-3>)),
"t4-2": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<lecture4-1>)),
"l4-3": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<tutorial4-2>)),

"l5-1": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<lecture4-3>)),
"t5-2": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<lecture5-1>)),
"l5-3": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<tutorial5-2>)),

"l6-1": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<lecture5-3>)),
"t6-2": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<lecture6-1>)),
"l6-3": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<tutorial6-2>)),

"l7-1": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<lecture6-3>)),
"t7-2": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<lecture7-1>)),
"l7-3": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<tutorial7-2>)),

"l8-1": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<lecture7-3>)),
"t8-2": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<lecture8-1>)),
"l8-3": ("status": STATUS.NOT_SEEN, "name": "", "ref": ref(<tutorial8-2>)),
)

#let lecture-overview(data) = {
  // 1. Get keys and sort them so l1-1 comes before l1-2
  let sorted-keys = data.keys().sorted()

  // 2. Create a flat array of table cells
  let cells = sorted-keys.map(k => {
    let item = data.at(k)
    
    // Construct the description (Name + optional Reference)
    let description = [
      #item.name
      #if "ref" in item [ : #item.ref]
    ]
    
    // Construct the status symbol
    let status = STATUS_SYMBOL.at(str(item.status))
    
    // Return both cells for this row
    (description, status)
  }).flatten()

  // 3. Generate the table using the spread operator (..)
  table(
    columns: (80%, auto),
    column-gutter: 1em,
    [*Lecture*], [*Status*],
    ..cells 
  )
}

#lecture-overview(lectures)


#let progress_status = lectures.values().filter(item => item.status >= 0).map(item => item.status).sum()
#let max_progress_status = lectures.values().filter(item => item.status >= 0).len()*STATUS.DONE

#progress-bar(
  width: 93%,
  height: 15pt, 
  current: progress_status,
  min: 0,
  max: max_progress_status, 
  fill: gradient.linear(blue.darken(10%), aqua, purple.darken(60%)),
  radius: 2pt
)
#align(center)[#progress_status / #max_progress_status]
#pagebreak()


#callout(title: "Prompt for generating summaries")[
  Create a summary of the attached slides including the most important intuition, all mathematical formulas, relevant examples, and theorems, but no proofs. Pay special attention to the provided examples, their continuations and modifications. 
  
  Be concise and technical using expert vocabulary. Explain in a suitable manner for a master of Logic student familiar with the relevant background but unfamiliar with the discussed material as of yet. Write the summary in typst. The slides are attached. Only focus on content and leave out organizational information about the course. I am pasting all of this into my typst document where each lecture is a level two heading e.g. == Lecture 1, so subchapters have to be at the correct level, at least three e.g. === Core Intuitions and Definitions.

  Important: Wrap the generated typst syntax summary in \`\`\`\`\`\` to make it copyable

  *Notable features of typst syntax:*
  1. if there is more than one letter in a name in typst math block then it needs to be wrapped in “”.
  2. to make text bold, wrap it in singular stars and to make it italic wrap it in underscores
  3. If you are more used to different typesetting languages, typst always uses () as parentheses and only uses {} for set notation
  *Style guide:*
  + do not include and  or [cite: x] in your output
  + I have defined custom functions to represent definitions, theorems (“theorem”), proofs (“proof”), examples (“example”), intuitions \[only use this for informal introductions\] (“intuition”), warnings to watch out (“attention”), questions (“question”), calls to recall something learned before (“remember”), note something carefully ("note"), and an info ("info").
    - To define a new concept, call \`\#def("Name of Concept")\[Definition body\]\` 
    - For all others call \`\#callout(title: "Title", style: "style-name")\[Box body\]
    - Each box generates a tag \#label("def-concept-name-hyphenated"). Refer to any concept you reference back to always \@def-concept-name-hyphenated
    - use my custom definitions for common operators such as the set of propositional letters or epistemic operators:
]

*TODO:* For some reason bullet point markers after 1 have no symbols

*TODO:* fix that def title cannot be a `[content block]`

= Week 1

== (Lecture): #lectures.l1-1.name <lecture1-1>

#callout(title: "Motto of Dynamic Epistemic Logic")[
 _"The wise sees action and knowledge as one. They see truly."_ - Bhagavad Gita
]

=== Core Intuitions and Definitions

#callout(title: "Multi-Agent Systems", style: "example")[
  + *Computation*: a network of communicating computers (e.g., the internet)
  + *Games*: players in a game (e.g., chess or poker)
  + *AI*: a team of robots exploring their environment and interacting with each other
  + *Cryptographic Communication*: agents ("principals") using a cryptographic protocol to communicate in private
  + *Economics*: transactions in a market
  + *Society*: social activities
  + *Politics*: diplomacy, war
  + *Science*: a community of scientists, engaged in creating theories, making observations and performing experiments to test their theories
]

#def("Properties of Multi-Agent Systems")[
  - _dynamic_: Agents perform _actions_ which change the system (via interaction)
  - _informational_: Agents acquire, store, process, and exchange _information_ about each other and the environment
]

- _Evolving knowledge_: The knowledge an agent has may _change_ in time, due to their or other players' actions.
- Certain actions increase information.
- _General rule_: players try to minimize their uncertainty and increase their knowledge.
#def-group(
  def("Knowledge")[Truthful information.],
  def("Justified Belief")[Information that is plausible, well-justified, probable, but possibly false.],
  def("Belief Revision")[A sustained, dynamic, self-correcting, truth-tracking action. Non-monotonic. True knowledge can only be recovered by effort. Made more difficult by deceit.],
)

#callout(title:"", style: "question")[Is knowledge a form of belief, or is knowledge more fundamental than belief?]

#def-group(
  def("Uncertainty")[A corollary of imperfect knowledge or "imperfect information".],
  def("Game of imperfect information")[A game where some moves are hidden, preventing players from knowing everything that is going on; they only have a partial view of the situation.]
)

- An agent may be _uncertain_ (<def-uncertainty>) about the real situation at a given time: they cannot _distinguish_ between possible outcomes.

_Wrong Beliefs_: Agents...
- ... may be induced (even with malicious intent e.g., cheating) to acquire false "certainty" in their drive for more knowledge.
- ... causing them to "know" things that are not true (e.g., due to bluffing in poker).
- Wrong beliefs are indistinguishable from true beliefs for an agent once they have become "certainty" (they really think they "know").

#def("Strategic Ignorance")[It can be advantageous not to know (or pretend not to).]

=== Distributed, Nested, and Common Knowledge

#def("Distributed Knowledge")[
  Potential/virtual knowledge that is not reducible to one individual.

  Knowledge that is not necessarily held by any individual agent prior to communication, but is known when multiple agents pool their distinct information.
]

#callout(title: "Distributed Knowledge: Business dealings", style: "example")[
  - $A$ knows $B$ made a  deal with either $C$ or $E$ (exclusively).
  - $B$ actually made a deal with $E$, so $C$ knows $B$ did *not* go make a deal with them.
  - Neither $A$ nor $C$ individually know $B$ made a deal with $E$ before communicating.
  - If $A$ and $C$ communicate (pool their knowledge), they deduce the truth. The fact is _distributed knowledge_ among them.
]

#def-group(
  def("Nested Knowledge")[
    Knowledge about the knowledge of others, leading to potential infinite regress or deep epistemic reasoning (e.g., "how can you know that I do not know?").
  ],

  def("Introspection")[
    An agent's capability (or lack thereof) to reason about their own epistemic state. 
    - *Known knowns*: things we know we know.
    - *Known unknowns*: things we know we do not know.
    - *Unknown unknowns*: things we do not know that we do not know.
  ],

  def("Common Knowledge")[
    A condition where an entire group knows a fact, everybody knows that everybody knows it, and everybody knows that everybody knows that everybody knows it, ad infinitum.
  ]
)


#callout(title: "Common Knowledge vs. 'Everybody Knows'", style: "example")[
  - Suppose everybody knows the road rules (e.g., red means "stop") and respects them.
  - *Question*: Is this enough to drive safely? *No*.
  - *Reasoning*: Merely knowing the rule is insufficient if you lack the certainty that *others* know the rules and will abide by them.
  - *Resolution*: Safe driving requires the rules to be _Common Knowledge_ (@def-common-knowledge).
]
== (Lecture): #lectures.l1-2.name <lecture1-2>
=== Epistemic Puzzles and Paradoxes

#callout(title: "Puzzle 0: The Coordinated Attack", style: "example")[
  Two army divisions (A and B) must attack simultaneously to win. They communicate via messengers over a channel where messages might be captured.
  - A sends "attack at dawn" and B receives it.
  - B must acknowledge receipt, but A does not know if the acknowledgment will arrive.
  - A must acknowledge the acknowledgment, ad infinitum.
  *Result*: No finite sequence of successful message deliveries can achieve coordination.
]

#callout(title: "Fixpoints and Byzantine Generals", style: "remember")[
  #def("Fixpoint")[$x$ is a fixpoint iff $f:X arrow X; x=f(x)$.]

  In the case of Puzzle 0:
  $ #common-knowledge($phi$) equiv K_A #common-knowledge($phi$) and K_B #common-knowledge($phi$) $

  Where $K_X$ is the knowledge operator of agent $X$, #common-knowledge($$) is the common knowledge operator, $phi$ is the message about the attack time.
]

#callout(title: "Coordinated Attack Intuition", style: "intuition")[
  Achieving _Common Knowledge_ (@def-common-knowledge) over an unreliable communication channel is logically impossible in a finite number of steps. Unbounded nested knowledge (@def-nested-knowledge) does not equate to true common knowledge.
]

#callout(title: "Puzzle 1: To Learn is to Falsify", style: "example")[
  $A$ sends an email to her lover $C$: "$B$ doesn't know about us." 
  
  $B$ secretly intercepts and reads it.

  *Result*: The proposition was true right before reading, but the act of learning the message immediately falsifies it (a dynamic variant of Moore's Paradox).

  #callout(title: "Instantaneous truth value change", style: "note")[
    *Paradox*: usually learning $phi$ means believing phi $square phi$, but here reading $phi$ leads to not believing $phi$: $square not phi$.

    *Less paradoxical with dynamic thinking*: The truth value of the statement changes instantaneously when $B$ reads and accepts it.


  ]
]


#callout(title: "Non-standard Belief Revision", style: "attention")[
  Standard belief-revision postulates (e.g., AGM) fail for complex learning actions where the informational payload refers directly to the epistemic state of the receiver.
]

#callout(title: "Puzzle 2 & 3: Self-Fulfilling and Self-Enabling Falsehoods", style: "example")[
  - *Self-Fulfilling*: $A$ falsely believes $B$ knows about her affair and sends a warning message. $B$ intercepts it and thereby learns of the affair. Communicating a false belief makes it true.

  #align(center)["$B$ doesn't know about us."]

  - *Self-Enabling*: $C$ (wanting to seduce faithful $A$) forges a message to himself from $A$ saying $B$ knows they are having an affair. $B$ reads it and divorces $A$. $A$, on the rebound, starts an affair with $C$. The transmission of a falsehood causally enables its own validation.
]

=== The Muddy Children and Epistemic Updates

#callout(title: "Puzzle 4: Muddy Children", style: "example")[
  $4$ perfect logicians (children), exactly $3$ have dirty faces. They see others but not themselves.
  - Father publicly announces: "At least one of you is dirty."
  - Father iteratively asks: "Do you know if you are dirty or not?"
  - Children answer publicly and simultaneously based strictly on their knowledge without guessing.
  *Result*: For $2$ rounds, they answer in the negative. In the 3rd round, all $3$ dirty children confidently state they are dirty. In the 4th round, the clean child deduces they are clean.
]
#pagebreak()
#callout(title: "Socratic Questioning", style: "info")[
  Discovering answers by asking questions of students. (#link("https://en.wikipedia.org/wiki/Socratic_questioning")[Wikipedia])
]

#callout(title: "Muddy Children", style: "intuition")[
  1. _What's the point of the father's first announcement ("At least one of you is dirty")?_

  The initial announcement transforms distributed implicit knowledge into public _Common Knowledge_ (@def-common-knowledge). 
  
  2. _What's the point of the father's repeated questions?_

  The iterated Socratic questioning acts as sequential epistemic updates: public statements of ignorance incrementally eliminate possible worlds in the Kripke model until the true state is uniquely isolated.
]

#callout(title: "Modifications of Muddy Children", style: "example")[
  - *The Amazon Island*: Isomorphic to Muddy Children. A law mandates wifes to execute their cheating husbands at noon once discovered. Queen announces at least one cheater exists and if somebody's husband is cheating, all other wives know it. With $17$ cheaters, for $16$ days nothing happens, and all $17$ are shot on day $17$.
  - *The Dangers of Mercy*: Wives of the $17$ cheaters secretly decide to spare them, while others believe strict obedience to the law is common knowledge. No shots are fired on day $17$. On day $18$, all faithful husbands are erroneously shot by their wives, who logically deduce (from flawed public premises) that their husbands must be cheating.
]

#callout(title: "Puzzle 5: Sneaky Children", style: "example")[
  Children are incentivized for speed and punished for errors. After round 1, two dirty children cheat by secretly confirming to each other they are dirty, thus answering "I know" prematurely in round 2.
  - *Honest Children Always Suffer*: The 3rd dirty child logically deduces it must be clean, answers incorrectly in round 3, and is punished.
  - *Clean Children Always Go Crazy*: The 4th (clean) child faces a strict contradiction. If it blindly applies monotonic updates via classical logic, it undergoes logical explosion (believing everything).
]
#pagebreak()
=== Paradoxes of Induction and Probability

#callout(title: "Puzzle 6: Surprise Exam", style: "example", label_: "10-puzzle-6")[
  Teacher announces an exam next week, but the date will be a surprise (students won't even know the night before).
  - *Paradoxical Argumentation*: Students apply backward induction. It cannot be Friday (they'd know Thursday night). By elimination, it cannot be any day. They deduce the announcement is false.
  - *Result*: They dismiss the announcement. The exam occurs (e.g., Tuesday) and is indeed a complete surprise.
]

#callout(title: "Puzzle 7: The Lottery Paradox", style: "example")[
  A fair lottery with $"1,000,000"$ tickets. 
  - Probability of ticket $x$ winning is $0.000001$.
  - It is rational to hold the belief that ticket $x$ will lose.
  - This reasoning applies symmetrically to all tickets.
  - Yet, the agent knows one ticket will win.
  *Result*: The conjunction of highly probable rational beliefs yields a strict logical *inconsistency*.
]

#callout(title: "Puzzle 7 Modification: The Infinite Lottery", style: "example")[
  An infinite lottery over arbitrary natural numbers. The probability of any given ticket winning is exactly $0$. The agent is mathematically correct to believe a specific ticket will not win, yet one must win. Any finite subset of beliefs is consistent, but the infinite global set is inconsistent.
]
=== Backward Induction and Social Epistemology 

#callout(title: "Puzzle 8: The Centipede Game", style: "example")[
  A sequential game with alternating moves by $a$ and $b$, deciding between stopping the game or continuing:

  #align(center)[#scale(80%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
    node [shape=circle];

    // Group the v nodes on the top row
    {
        rank = same;
        "v_0: a"; "v_1: b"; "v_2: a";
    }

    // Group the o nodes on the second row
    {
        rank = same;
        "o_1: 3,0"; "o_2: 2,3"; "o_3: 5,2"; "o_4: 4,5";
    }

    // Edges
    "v_0: a" -> "v_1: b" -> "v_2: a";
    "v_0: a" -> "o_1: 3,0";
    "v_1: b" -> "o_2: 2,3";
    "v_2: a" -> "o_3: 5,2";
    "v_2: a" -> "o_4: 4,5";
}
  ```
))]]
In the leaves ("outcomes" $o_j$) the first number is $a$'s payoff, the second number is $b$'s payoff.
  
  - $v_0: a$ stops for $o_1(3,0)$ or continues to $v_1$
  - $v_1: b$ stops for $o_2(2,3)$ or continues to $v_2$
  - $v_2: a$ stops for $o_3(5,2)$ or continues to $o_4(4,5)$
]

*The Backwards Induction (BI) Method*
- Iteratively eliminate the _obviously_ "bad" moves
- Proceeding backwards from the leaves

#grid(
  columns: (30%, 30%, 30%),
  column-gutter: 3%,
  [*Elimination Step 1*
    
    #align(center)[#scale(60%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
    node [shape=circle];

    // Group the v nodes on the top row
    {
        rank = same;
        "v_0: a"; "v_1: b"; "v_2: a";
    }

    // Group the o nodes on the second row
    {
        rank = same;
        "o_1: 3,0"; "o_2: 2,3"; "o_3: 5,2";
    }

    // Edges
    "v_0: a" -> "v_1: b" -> "v_2: a";
    "v_0: a" -> "o_1: 3,0";
    "v_1: b" -> "o_2: 2,3";
    "v_2: a" -> "o_3: 5,2";
}
  ```
))]]],
  [*Elimination Step 2*
    
    #align(center)[#scale(60%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
    node [shape=circle];

    // Group the v nodes on the top row
    {
        rank = same;
        "v_0: a"; "v_1: b";
    }

    // Group the o nodes on the second row
    {
        rank = same;
        "o_1: 3,0"; "o_2: 2,3";
    }

    // Edges
    "v_0: a" -> "v_1: b";
    "v_0: a" -> "o_1: 3,0";
    "v_1: b" -> "o_2: 2,3";
}
  ```
))]]],
  [*Elimination Step 3*
  #align(center)[#scale(60%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
    node [shape=circle];

    // Group the v nodes on the top row
    {
        rank = same;
        "v_0: a";
    }

    // Group the o nodes on the second row
    {
        rank = same;
        "o_1: 3,0";
    }

    // Edges
    "v_0: a";
    "v_0: a" -> "o_1: 3,0";
}
  ```
))]]]
)

- *BI outcome*: $o_1: 3,0$
- _Why not another outcome?_: Strikes many as irrational

#callout(title: "The BI Paradox and Rational Pessimism", style: "intuition")[
  - *Aumann's Argument*: Assuming _Common Knowledge_ (@def-common-knowledge) of Rationality ($"CKR"$), backward induction dictates $A$ chooses $o_3$ at $v_2$, so $B$ chooses $o_2$ at $v_1$, so $A$ chooses $o_1$ at $v_0$. The game terminates immediately at a suboptimal Pareto outcome.
  - *Counterargument*: If $B$ reaches $v_1$, he observes $A$ violating $"CKR"$ (she didn't stop at $v_0$). If $B$ adopts *Rational Pessimism*—assuming $A$ is irrational and will thus choose $o_4$ at $v_2$—he should continue. If $A$ anticipates this belief revision, her initial deviation becomes strictly rational. The epistemic foundation of backward induction contradicts its own counterfactuals.
]

=== Social Epistemology
Group dynamics often deviate from ideal individualized epistemic logic due to the recursive nature of social evidence.

#def("Pluralistic Ignorance")[
  A situation where the group collectively knows or acts upon less information than the individuals possess privately. Often observed in totalitarian regimes where public behavior contradicts private beliefs.
]

#callout(title: "Puzzle 9: Wisdom vs. Madness of the Crowds", style: "example")[
  - *Wisdom of the Crowds*: Distributed group knowledge often empirically exceeds the most expert individual (e.g., aggregating independent estimates).
  - *Madness of the Crowds*: Systems can fail systematically due to cascading social epistemology.
]

#callout(title: "Information Cascades", style: "intuition", label_: "intuition-information-cascades")[
  An information cascade occurs when agents base their decisions on the observable behavior of prior agents rather than their own private evidence, leading to a breakdown of _epistemic democracy_ (the wisdom of crowds).
]

#callout(title: "The Black and White Urn Problem", style: "example", label_: "urn-problem")[
  *Setup:* One urn is in a room. It is either Urn B (2/3 black marbles) or Urn W (2/3 white marbles). Agents enter one by one, draw a marble, replace it, and publicly record their guess of the urn on a blackboard.
  *The Cascade:* 1. Voter 1 draws Black and guesses Urn B.
  2. Voter 2 draws Black and guesses Urn B.
  3. Voter 3 draws White. However, the public evidence (two B votes) combined with their private evidence (one W draw) yields an aggregate evidence of (B, B, W). The rational epistemic choice is still to guess Urn B.
  *Result:* From Voter 3 onwards, everyone will vote Urn B regardless of their private draw. If the first two voters happened to draw the minority color (probability $1/9$), the entire crowd of $n$ voters will lock into the wrong conclusion.
]

#callout(title: "Biological and Geopolitical Cascades", style: "example", label_:  "example-biological-geopolitical-cascades")[
  - *Army Ant Circular Mill:* If an army ant loses the pheromone trail, it is biologically programmed to follow the ant directly in front of it. This simple rule works locally but can result in a massive recursive loop (a death spiral up to 400m in diameter) where the ants walk in a circle until they die.
  - *The Men Who Stare at Goats (Cold War):* A French newspaper published a fabricated story about US military research into psychic weapons. Soviet intelligence read this, assumed it was a cover-up, and initiated their own psychic research program. US intelligence discovered the Soviet program and, assuming the Soviets were onto a real threat, started their own actual research program, sparking a 30-year arms race built on an initial cascade of false information.
]

== (Lecture): #lectures.l1-3.name <lecture1-3>

=== Syntax and Core Definitions
Single-agent epistemic-doxastic logic expands standard propositional logic to formally capture an agent's knowledge and beliefs.

$ phi ::= p | not phi | phi and phi | #knowledge($phi$) | #belief($phi$) $ where $p in Prop$.

#def("Single-Agent, pointed Epistemic-Doxastic Model")[
  Is a tuple $bold("S") = (S, S_0, #interpretation($dot$), #actual_state)$, where
  - $S$: A set of _ontic_ states defining the agent's _epistemic state_ (epistemically possible).
  - $S_0$: A non-empty subset $S_0 subset.eq S$, called the _sphere of beliefs_ or the agent's _doxastic state_.
  - $#interpretation($dot$): Prop -> #powerset($S$)$: A _valuation_ map assigning atomic propositions to sets of states.
  - $#actual_state in S$: The designated "actual world" representing the real state of the world.
]
_Sphere-based_: represents beliefs as nested layers of possible worlds, ranking worlds by their plausibility

=== Semantics
#callout(title: "Interpretation", style: "intuition")[
  - *Epistemic state*: state of the agent's knowledge: they belief $#actual_state$ is among $S$, but cannot distinguish between $s_i, s_j in S; i!=j$.
  - *Doxastic state*: the agent beliefs $#actual_state in S_0$
]

#callout(title: "Truth", style: "notation")[We write the following if $phi$ is _true_ in world $w$. When the model $bold("S")$ is fixed, we skip the subscript.

$ w models_bold("S") phi $
]

#callout(title: "Atomic logical connectives", style: "note")[
  We interpret negation $not$ and conjunction $and$ as atomic logical connectives, but disjunction $or$, the conditional $arrow$, and the biconditional $arrow.r.l$ as compound connectives.
]

#def-group(
  def("Truth in an Interpretation")[
    A sentence $phi$ is true in a model $bold("S")$ under the valuation map $#interpretation($dot$)_bold("S")$ if
    #enum(numbering: "i.")[$phi = p; p in Prop$: $w models p "iff" w in #interpretation($p$)$,][$phi = not psi$: $w models not psi "iff" w cancel(models) psi$,][$phi = psi and chi$: $w models psi and chi "iff" w models psi "and" w models chi$,][$phi = #knowledge($phi$)$: $w models #knowledge($phi$) "iff" forall s in S, s models phi$,][$phi = #belief($phi$)$: $w models #knowledge($phi$) "iff" forall s in S_0, s models phi$.]
  ],
  def("Validity")[A sentence $phi$ is *valid* in a model $bold("S")$ if it is true at every state $w in bold("S")$.],
  def("Satisfiability")[A sentence $phi$ is *satisfiable* in a model $bold("S")$ if it is true at some state $w in bold("S")$.]
)

#callout(title: "Semantics of Knowledge and Belief", style: "note", label_:"semantics-knowledge-belief")[
  The universal quantifier over the domain of possibilities is interpreted as knowledge or belief.
  - *Knowledge* ($#knowledge($phi$)$): Truth in all epistemically possible worlds. 
  - *Belief* ($#belief($phi$)$): Truth in all doxastically possible worlds within the sphere of beliefs.
]


=== Learning and Mistaken Updates
Learning corresponds to world elimination. An update with a sentence $phi$ is the operation of deleting all non-$phi$ possibilities from the model.

#callout(title: "The Concealed Coin and Mistaken Updates", style: "example", label_: "concealed-coin")[
  #grid(columns: (85%, auto), column-gutter: 1em,
  [*Base Scenario:* A coin is on the table; the agent does not know if it is Heads ($H$) or Tails ($T$).],
  [#v(-.6em)
    #figure(
    align(center)[#scale(65%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
    node [shape=square, style=rounded];

    // Group the v nodes on the top row
    {
        rank = same;
        H;T;
    }
}
  ```
))]]
  )])

  #grid(columns: (85%, auto), column-gutter: 1em,
  [*Standard Update:* The agent looks and sees $H$. The $T$ world is eliminated, and only the $H$ epistemic possibility survives.],
  [#v(-.6em)
    #figure(
    align(center)[#scale(65%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
  H [shape=square, style=rounded];
    Node1 [
        shape=square,
        style="rounded, dashed, filled", 
        fillcolor="grey95", 
        color="grey50",       // Border color
        fontcolor="grey50",   // Text color
        label="T"
    ];
}
  ```
))]]
  )])

  #callout(title: "Update as World Elimination", style: "note")[
    In general, updating corresponds to world elimination: an update with a sentence $phi$ is simply the operation of deleting all the non-$phi$ possibilities.
  ]
  #splitgrid(
    (85%,auto)
  )[*Mistaken Update:* The agent mistakenly believes they saw $H$. If we eliminate $T$, the actual world $#actual_state$ is no longer in the agent's model, making it impossible to evaluate objective truth.][#v(-.6em)
    #figure(
    align(center)[#scale(65%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
        Node1 [
        shape=square,
        style="rounded, dashed, filled", 
        fillcolor="grey95", 
        color="grey50",       // Border color
        fontcolor="red",   // Text color
        label="T*"
    ];
    
  "H" [shape=square, style=rounded];
  { rank=same; H; Node1; }
  H -> Node1 [style=invis]
}
  ```
))]])]

  #splitgrid((85%,auto))[*Resolution (Third-Person Models):* We maintain an objective perspective where the real possibility always remains in the global model $S$, even if the agent believes it to be impossible. The sphere of beliefs $S_0$ ($square.stroked.rounded$ #h(-0.75em) $dot$ ) is restricted to $T$, meaning the agent believes $H$, but their belief is false because $#actual_state in S slash S_0$.][#v(-.6em)
    #figure(
    align(center)[#scale(65%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
    rankdir=LR;
    ranksep=0.25;
    subgraph cluster_0 {
        label = "";
        style = rounded;
        color = black;
        Node1 [
            shape=square,
            style="rounded, dashed, filled", 
            fillcolor="grey95", 
            color="grey50",       // Border color
            fontcolor="red",   // Text color
            label="T*"
        ];
    }
    
  H [shape=square, style=rounded];
  H -> Node1 [style=invis]
}
  ```
))]])]
]

#callout(title: [Continuation of #link(<example-10-puzzle-6>)[Puzzle 6: Surprise Exam]], style: "example")[
Situation before the teacher's announcement (we don't know $#actual_state$: no star in the figure):
  
  #figure(
    align(center)[#scale(75%, reflow: true)[#figure(
    raw-render(
  ```dot
  graph G {
    rankdir=LR;
    node [shape=square, style=rounded];

    subgraph cluster_0 {
        label = "";
        style = rounded;
        color = black;
        1; 2; 3; 4; 5;
    }

    

    // Optional edges to ensure they stay in a row
    1 -- 2 -- 3 -- 4 -- 5 [style=invis];
}```
))]])

A student beliefs (for some reason) the exam will be on Monday or Tuesday,\ but it is on Thursday ($#actual_state = 4$):
  
  #figure(
    align(center)[#scale(75%, reflow: true)[#figure(
    raw-render(
  ```dot
  graph G {
    rankdir=LR;
    node [shape=square, style=rounded];

    subgraph cluster_0 {
        label = "";
        style = rounded;
        color = black;
        1; 2; 
    }
    3; "4*" [fontcolor="red"]; 5;
    

    // Optional edges to ensure they stay in a row
    1 -- 2 -- 3 -- "4*" -- 5 [style=invis];
}```
))]])

]

#pagebreak()
=== Kripke Semantics for Epistemic-Doxastic Logic
Sphere models can be generalized using Kripke semantics to allow for varying strengths of knowledge and belief.

#callout(title: "Kripke Model", style: "remember")[#def("Kripke Model")[A Kripke model is a tuple $bold("S") = (S, {R_i}_(i in I), norm(.), #actual_state)$ with set of states $S$, accessibility relations $R_i$, valuation $#interpretation($dot$)$, and actual state $#actual_state$.]]

#def("Epistemic-Doxastic Kripke Model")[
  To model knowledge $#knowledge("")$ and belief $#belief("")$, this becomes $(S, tilde, ->, norm(.), #actual_state)$, where $tilde$ is the epistemic relation (for #knowledge("")) and $->$ is the doxastic relation (for $#belief("")$). 
]

For atomic sentences and for Boolean connectives, we use the same semantics (and notations) as on epistemic-doxastic models.

#def("Kripke modalities")[For every sentence $phi$, we can define a new sentence using the _universal Kripke modality_ $#box-kripke($R_i$)$ by universally quantifying over $R_i$ accessible worlds. The dual _existential Kripke modality_ $#diamond-kripke($R_i$)$ is given by
$ #diamond-kripke($R_i$) phi := not #box-kripke($R_i$) not phi. $
]
#callout(title: "Kripke modalities: subscript", style: "notation")[
  If $R$ is unique, we abbreviate $#box-kripke($R_i$) phi$ as $square phi$, and  $#diamond-kripke($R_i$) phi$ as $diamond phi$.
]

#def("Truth in an interpretation continued: Kripke modalities")[
  We continue @def-truth-in-an-interpretation by adding
  #enum(numbering: "i.", start: 6)[$phi = #box-kripke($R_i$) phi$: $w models #box-kripke($R_i$) phi "iff" v models phi forall v: w R_i v$.]
]

#callout(title: [@example-concealed-coin: Concealed coin continued], style: "example")[
  The agent's knowledge in the concealed coin scenario can be represented as:
  #v(-.6em)
    #figure(
    align(center)[#scale(65%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
    node [shape=square, style=rounded];

    // Group the v nodes on the top row
    {
        rank = same;
        H;T;
    }
    H -> H [arrowhead=rvee, tailport=w]; T -> T [arrowhead=lvee, tailport=e]; H -> T [dir=both, arrowhead=vee, arrowtail=vee, penwidth=0.5, minlen=2];
}
  ```
))]]
  )
  - The arrows represent the *epistemic relation* $tilde$, capturing the agent's uncertainty about the state of the world.
  - An arrow from state $s$ to state $t$ means that if $#actual_state = s$, the agent could not distinguish between $s$ and $t$.
]

#callout(title: [@example-concealed-coin: Concealed coin continued], style: "example")[
  The agent's belief after the mistaken update can be represented as: 
  #v(-.6em)
    #figure(
    align(center)[#scale(65%, reflow: true)[#figure(
    raw-render(
  ```dot
digraph Z {
    node [shape=square, style=rounded];


    {
        rank = same;
        H -> T [style=invis];
    }

    H -> H [arrowhead=rvee, tailport=w];
    // Note: Your T edge was missing a destination, fixed below
    T -> H [arrowhead=vee, arrowtail=vee, penwidth=0.5, minlen=2, tailport=w];
}
  ```
))]]
  )
  - The arrows represent the *epistemic relation* $tilde$, capturing the agent's uncertainty about the state of the world.
  - An arrow from state $s$ to state $t$ means that if $#actual_state = s$, the agent could not distinguish between $s$ and $t$.
]


#callout(title: "Named axioms in Modal Logic", style: "remember")[Certain axioms have set names in Modal Logic:
- $(bold("K"))$ Basic Modal Logic
- $(bold("T"))$ Reflexivity $square phi arrow phi$
- $(bold(4))$ Transitivity $square phi arrow square square phi$
- $(bold(5))$ Euclideaness $diamond phi arrow square diamond phi$
- $(bold("D"))$ Seriality $square phi arrow diamond phi$
- _Weak Epistemic Model_ $(bold("S4")) = (bold("K")) + (bold("T")) + (bold(4))$: No negatice introspection (only relfex. & trans.)
- _Epistemic Model_: $(bold("S5")) = (bold("K")) + (bold("T")) + (bold(5))$
  - Note: An $(bold("S5"))$-model is one where the accessibility relations are equivalence relations: \ reflexive, transitive, symmetric (with the other two properties, Symmetry $equiv$ Euclidean)
- _Doxastic Model_: $(bold("KD45")) = (bold("K")) + (bold("D")) + (bold(4)) + (bold(5))$
  - Note: Doxastic Models are not symmetric, but serial ($forall s: exists t: s arrow t$), transitive, Euclidean

]

#callout(title: "Axioms and Relational Properties", style: "theorem", label_: "axioms-relational-properties")[
  A Kripke model satisfying all the below conditions on the relations $tilde$ and $arrow$ is called an *epistemic-doxastic Kripke model*.

  Validities for Knowledge (Equivalence relation $tilde$, giving an S5 model):
  #enum(numbering: "i.", start: 1)[*Veracity* ($#knowledge($phi$) => phi$): $tilde$ is reflexive.][*Positive Introspection* ($#knowledge($phi$) => #knowledge(knowledge($phi$))$): $tilde$ is transitive ($bold(4)$).][*Negative Introspection* ($not #knowledge($phi$) => #knowledge($not #knowledge($phi$)$)$): $tilde$ is Euclidean (and symmetric) ($bold(5)$).]

  Validities for Belief (KD45 model properties for $->$):
  #enum(numbering: "i.", start: 4)[*Consistency* ($not B(phi and not phi)$): $->$ is serial.][*Positive Introspection* ($#belief($phi$) => #belief(belief($phi$))$): $->$ is transitive.][*Negative Introspection* ($not #belief($phi$) => "B" not #belief($phi$)$): $->$ is Euclidean.]

  $#knowledge($belief("")$)$ Interaction Properties:
  #enum(numbering: "i.", start: 7)[*Knowledge implies Belief* ($#knowledge($phi$) => #belief($phi$)$): If $s -> t$ then $s tilde t$.][*Strong Positive Introspection* ($#belief($phi$) => #knowledge(belief($phi$))$): If $s tilde t$ and $t -> w$ then $s -> w$.][*Strong Negative Introspection* ($not #belief($phi$) => #knowledge($not #belief($phi$)$)$): If $s tilde t$ and $t -> w$ then $s -> w$.]
]

*Observations*:
1. Epistemic-doxastic Kripke models are equivalent to Simple Epistemic-Doxastic Models(@def-single-agent-pointed-epistemic-doxastic-model) 
2. The epistemic relation is completely determined by the doxastic relation.

*Sound and Complete Proof System for single agent epistemic-doxastic logic*:
- Axioms: 
  - From above: i. - iv., vii. - ix.
  - All propositional tautologies
  - Modus Ponens: from $phi$ and $(phi arrow psi)$ infer $psi$
  - Necessitation: from $phi$ infer $#knowledge($phi$)$ and $#belief($phi$)$
  - Kripke's axioms for #knowledge("") and #belief(""):
    - $(#knowledge($phi arrow psi$)) arrow (#knowledge($phi$) arrow #knowledge($psi$))$ 
    - $(#belief($phi arrow psi$)) arrow (#belief($phi$) arrow #belief($psi$))$ 

*Generalization*
- It is convenient to have a more general semantics where the above do not hold
  - Introspection is not universally accepted
  - People may believe they know things they don't actually know
  - There might be "crazy" agents with inconsistent beliefs

#callout(title: "Equivalence of Models", style: "theorem", label_: "equivalence-of-models")[
  Every epistemic-doxastic sphere model $S = (S, S_0, norm(.), #actual_state)$ is completely equivalent to an epistemic-doxastic Kripke model $S' = (S, tilde, ->, norm(.), #actual_state)$ that satisfies the same sentences at $#actual_state$.
]

#callout(title: "Logical Omniscience", style: "attention", label_: "logical-omniscience")[
  Any Kripke modality validates axiom K ($K(phi => psi) => (#knowledge($phi$) => K psi)$) and the Necessitation rule (if $phi$ is valid, $#knowledge($phi$)$ is valid). Consequently, Kripke semantics models "ideal reasoners" with unlimited inference powers who know/believe all logical entailments, failing to capture bounded rationality.
]

= Week 2

== (Lecture): #lectures.l2-1.name <lecture2-1>

=== Multi-Agent Kripke Models & Modalities

#def("Multi-Agent Kripke Model")[
  A multi-agent Kripke model is a tuple $ bold("S") = (S, {->_a}_(a in cal(A)), #interpretation($dot$)) $ where $cal(A)$ is a set of labels representing the names of epistemic agents.
]

#def("Epistemic/ Doxastic Modalities")[
  For every sentence $phi$, we define $square_a phi$ by universally quantifying over $->_a$-accessible worlds:
  $s models_S square_a phi <=> t models_S phi$ for all $t$ such that $s ->_a t$.
  This is interpreted as knowledge, denoted $#knowledge($phi$, inf: "a")$, or belief, denoted $#belief($phi$, inf: "a")$. 
  
  Its existential dual $diamond_a phi := not square_a not phi$ denotes epistemic/ doxastic possibility.
]


#example("The Concealed Coin")[
  Two players $a$, $b$, along with a referee $c$ play a game. The referee throws a fair coin so nobody knows the outcome.

  #v(-.6em)
    #figure(
    align(center)[#scale(65%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
    node [shape=square, style=rounded];

    // Group the v nodes on the top row
    {
        rank = same;
        H;T;
    }
    H -> H [arrowhead=rvee, tailport=w, label="a,b,c"]; T -> T [arrowhead=lvee, tailport=e, label="a,b,c"]; H -> T [dir=both, arrowhead=vee, arrowtail=vee, penwidth=0.5, minlen=2, label="a,b,c"];
}
  ```
))]]
  )

  Using concatenated arrows, we can express iterated knowledge. For instance, $b$ knows that $a$ does not know the outcome but knows it is Heads ($H$) or Tails ($T$):
  $ w models square_b (not square_a H and not square_a T) and square_b square_a (H or T) $
]

=== Common Knowledge

#def("Common Knowledge (Group)")[
  Common knowledge within a group $G subset.eq cal(A)$, denoted $#common-knowledge($phi$, inf: "G")$, is evaluated by quantifying over all worlds accessible by any finite concatenation of arrows within $G$:

  $ s models_S #common-knowledge($phi$, inf: "G") <=> t models_S phi $ for every $t$ and every finite chain $s = s_0 ->_(a_1) s_1 ->_(a_2) dots ->_(a_n) s_n = t$ with $a_1, dots, a_n in G$.
]

#notation("Common Knowledge")[
  *Full common knowledge*: In the case that $G = cal(A)$, we omit the subscript and write $#common-knowledge($phi$)$.
  *Knowledge/ Belief*: In epistemic-doxastic models we have both 
  - _common knowledge_ $#common-k("")$ and 
  - _common true belief_ $#common-belief("")$.
]

#info("Common Knowledge equivalence to Kripke Modality", label_: "common-knowledge-equiv-kripke")[
  #common-knowledge($phi$, inf: $G$) is equivalent to the Kripke modality for the reflexive-transitive closure of the union of all epistemic relations: $[(union.big_(a in G) ->_a)^*]$.

  #remember("")[
    #def("Reflexive-transitive closure")[
      Given a relation $R$, its _reflexive-transitive closure_ $R^*$ is defined by:
      $ w R^* v "iff" exists "finite chain" ("length" n>=0): w=w_0 R w_1 R ... R w_n = v $
    ]
  ]
]

#callout(title: "Common Knowledge as Infinite Conjunction", style: "intuition")[
  Let $E_G phi := and_(a in G) square_a phi$ ("everybody in group $G$ knows $phi$").
  
  Then, common knowledge #common-knowledge($phi$, inf: "G") (@def-common-knowledge-group) is semantically equivalent to the infinite conjunction:
  $ phi and E_G phi and E_G E_G phi and dots $

  #attention("Infinitary definitions")[
    The most used modal-epistemic languages are _finitary_ s.t. #common-knowledge($$, inf: "G") cannot be defined as the infinite conjunction, which is impossible to form.

    Instead, #common-knowledge($$, inf: "G") is interpreted as a *primitive* operator induced by the semantic clause in @info-common-knowledge-equiv-kripke
  ]
]

#callout(title: "Validities for Common Modalities", style: "theorem", label_: "validities-for-common-modalities")[
  - *Fixed-Point Axiom* (Mix): $#common-knowledge($phi$, inf: "G") => (phi and E_G #common-knowledge($phi$, inf: "G"))$
  - *Induction Axiom*: $#common-knowledge($(phi => E_G phi)$, inf: "G") => (phi => #common-knowledge($phi$, inf: "G"))$
]

==== Syntax
#splitgrid((50%, 45%), column-gutter: 2em)[
*Epistemic logic with common knowledge* #h(1.4em) $|$
$ phi ::= p | not phi | phi and phi | #knowledge($phi$, inf: $a$) | #common-k($phi$, inf: "G") $][
*Doxastic logic with common true belief*
$ phi ::= p | not phi | phi and phi | #belief($phi$, inf: $a$) | #common-belief($phi$, inf: "G") $]
*Epistemic-doxastic logic with common knowledge and common (true) belief*
$ phi ::= p | not phi | phi and phi | #knowledge($phi$, inf: $a$) | #belief($phi$, inf: $a$) | #common-k($phi$, inf: "G") | #common-belief($phi$, inf: "G") $

*Complete axiomatization:*
- Multi-agent versions of the axioms in @theorem-axioms-relational-properties (modalities labeled with agents)
- Fixed-Point and Induction Axioms (@theorem-validities-for-common-modalities) for both $#common-k("", inf: "G")$ and $#common-belief("", inf: "G")$
- Kripke axioms for both $#common-k("", inf: "G")$ and $#common-belief("", inf: "G")$: $#common-knowledge($(phi arrow psi)$, inf: "G") arrow (#common-knowledge($phi$, inf: "G") arrow #common-knowledge($psi$, inf: "G"))$
- Necessitation for both $#common-k("", inf: "G")$ and $#common-belief("", inf: "G")$: $phi arrow #common-knowledge($phi$, inf: "G")$

=== Distributed Knowledge

#def("Distributed Knowledge (Group)")[
  Distributed knowledge within a group $G$, denoted $#distributed-knowledge($phi$, inf: "G")$ or $#distributed-k($phi$, inf: "G")$, is obtained by quantifying over all worlds simultaneously accessible by all arrows for agents in $G$:
  $s models_S D square_G phi <=> t models_S phi$ for every $t$ such that $s ->_a t$ holds for all $a in G$.
]
#callout(title: "Epistemic Potential", style: "intuition")[
  @def-distributed-knowledge-group captures the implicit (or virtual) knowledge of the group: what the agents in $G$ could come to know if they pooled all their private knowledge.
]
#info("Distributed Knowledge equivalence to Kripke Modality", label_: "distributd-knowledge-equiv-kripke")[
  #distributed-knowledge($$, inf: $G$) is equivalent to the Kripke modality corresponding to the intersection of epistemic relations $ inter.big_(a in G) ->_a $
]

#note("Interpretations of distributed modalities")[
  - when the relations $arrow_a$ are reflexive: #distributed-k($$, inf: $G$) as some sort of distributed knowledge
  - when the relations $arrow_a$ represent beliefs: #epistemic_op(base: $D b$, formula: $$, sup: "", inf: "G") may be inconsistent
]

#example("Two Muddy Children")[
  Two children (1 & 2) have dirty foreheads ($d_1$, $d_2$). Each sees the other but not themselves. In the real world $w = (d_1, d_2)$, neither knows both are dirty, but it is distributed knowledge:
  $w models not #knowledge($d_1 and d_2$, inf: "1") and not #knowledge($d_1 and d_2$, inf: "2") and D k (d_1 and d_2)$.
] #label("continue-here")


#callout(title: "Validities for Distributed Knowledge", style: "theorem")[
  - $#knowledge($phi$, inf: "a") => D k phi$
  - $(#knowledge($phi$, inf: "a") and #knowledge($psi$, inf: "b")) => D k (phi and psi)$
]

=== Dynamics & Public Announcements

#def("Public Announcement Logic")[
  A public announcement $!phi$ is a joint update that deletes all non-$phi$ worlds from a model. The model transformer maps $S$ to $S^(!phi) = (S_phi, ->_phi, #interpretation($dot$)_phi)$, where $S_phi = #interpretation($phi$)_S$, while the relations as well as valuations are restricted to $S_phi$. The dynamic modality is evaluated as:
  $s models_S #box-kripke($!phi$) psi <=> t models_(S^(!phi)) psi$ for all $t in S^(!phi)$ such that $s ->_(S)^(!phi) t$.
]


#callout(title: "PAL Reduction Axioms", style: "theorem")[
  PAL (@def-public-announcement-logic) allows translating dynamic formulas to basic modal logic via reduction axioms:
  - *Atomic Permanence*: $#box-kripke($!phi$) p <=> (phi => p)$
  - *Announcement-Negation*: $#box-kripke($!phi$) not psi <=> (phi => not #box-kripke($!phi$) psi)$
  - *Announcement-Conjunction*: $#box-kripke($!phi$) (psi_1 and psi_2) <=> (#box-kripke($!phi$) psi_1 and #box-kripke($!phi$) psi_2)$
  - *Announcement-Knowledge*: $#box-kripke($!phi$) square_a psi <=> (phi => square_a #box-kripke($!phi$) psi)$
]

#callout(title: "Expressivity & Succinctness", style: "info")[
  PAL has the exact same expressivity as basic modal logic because dynamic modalities can be eliminated using the reduction axioms. However, PAL is exponentially more succinct.
]

=== Moore Sentences & Paradoxes

#def("Moore Sentences")[
  Sentences that become false after being truthfully announced. For a Moore sentence $phi$, we have $#box-kripke($!phi$) not phi$. Therefore, they become known to be false after being announced: $#box-kripke($!phi$) #knowledge($not phi$, inf: "a")$.
]

#callout(title: "Moore Sentences in Muddy Children", style: "example")[
  "You are dirty but you do not know it" is a Moore sentence for child 1: $d_1 and not #knowledge($d_1$, inf: "1")$.
  This is initially true in the muddy children model. However, after it is publicly announced, child 1 learns they are dirty. The second conjunct becomes false, making the entire sentence false.
  
  _Continuation_: In the grand finale of the muddy children puzzle, children repeatedly announce their ignorance: $!(and_i (not #knowledge($d_i$, inf: "i") and not #knowledge($not d_i$, inf: "i")))$. Each round deletes worlds where a child would have known their state, converting distributed knowledge into common knowledge until the dirty children deduce they are dirty.
]

#theorem("Closure under Composition")[
  Performing two successive public announcements is equivalent to a single, more complex announcement:
  $#box-kripke($!phi$) #box-kripke($!psi$) theta <=> #box-kripke($!(phi and #box-kripke($!phi$) psi)$) theta$.
]

*TODO*: #link(<continue-here>)[Continue here \[click\]]

== (Lecture): #lectures.l2-2.name <lecture2-2>

== (Lecture): #lectures.l2-3.name <lecture2-3>

= Week 3

== (Lecture): #lectures.l3-1.name <lecture3-1>

== (Lecture): #lectures.t3-2.name <tutorial3-2>

== (Lecture): #lectures.l3-3.name <lecture3-3>

= Week 4

== (Lecture): #lectures.l4-1.name <lecture4-1>
Based on #raw("DEL 2019-20 Lectures 4.2.pdf")

=== The Failure of Standard DEL

#callout(title: "DEL Failure: The Problem with Standard Updates", style: "attention")[
  Standard Dynamic Epistemic Logic (DEL) update mechanisms fail when an agent is confronted with new information that contradicts their previously held _false_ beliefs. Under the standard update product, all doxastic relations originating from the real world are eliminated. This empty sphere of beliefs results in the agent believing everything (inconsistent beliefs), violating the consistency axiom (D). 
]

#example("Counterexample: Scenario 4")[
  _Scenario 4_: Recall the state model immediately after taking a peak:
  #v(-.6em)
    #figure(
    align(center)[#scale(65%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
    node [shape=square, style=rounded];
    splines="line";

    // Group the v nodes on the top row
    {
        rank = same;
        H;T;
    }
    N [label = "H", shape=doublecircle]
    N -> N [arrowhead=lvee, tailport=e, label="c"];
    N -> H [arrowhead=vee, tailport=s, label="a,b"]; N -> T [arrowhead=vee, tailport=s, label="a,b"];
    H -> H [arrowhead=rvee, tailport=w, label="a,b,c"]; T -> T [arrowhead=lvee, tailport=e, label="a,b,c"]; H -> T [dir=both, arrowhead=vee, arrowtail=vee, minlen=2, label="a,b,c"];
}
  ```
))]]
  )
  $c$ privately knows that the coin lies heads up: $phi = #knowledge($H$, inf: $c$)$ (also: $not #knowledge($phi$, inf: $a,b$)$).

  _Scenario 5_: $c$ sends a secret announcement to $a$: $!_(c,a) phi$, the event model is:
  #v(-.6em)
    #figure(
    align(center)[#scale(65%, reflow: true)[#figure(
    raw-render(
  ```dot
  digraph Z {
    node [shape=square, style=rounded];
    splines="line";

    // Group the v nodes on the top row
    {
        rank = same;
        N;T;
    }
    N [label = "phi", shape=doublecircle]
    T [label = "true"]
    N -> N [arrowhead=rvee, tailport=w, label="a, c"];
    N -> T [arrowhead=vee, tailport=e, label="b"];
}
  ```
))]]
  )
  #splitgrid((47.5%,47.5%), column-gutter: 5%)[
    Intuitive updated state model:

    #graph-figure(
      ```dot
      digraph Z {
        node [shape=square, style=rounded];
        splines="line";

        // Group the v nodes on the top row
        {
            rank = same;
            H;T;
        }
        N [label = "H", shape=doublecircle]
        N -> N [arrowhead=lvee, tailport=e, label="a,c"];
        N -> H [arrowhead=vee, tailport=s, label="b"]; N -> T [arrowhead=vee, tailport=s, label="b"];
        H -> H [arrowhead=rvee, tailport=w, label="a,b,c"]; T -> T [arrowhead=lvee, tailport=e, label="a,b,c"]; H -> T [dir=both, arrowhead=vee, arrowtail=vee, minlen=2, label="a,b,c"];
      }
    ```
    )
  ][
    Actual updated state model:

    #graph-figure(
      ```dot
      digraph Z {
        node [shape=square, style=rounded];
        splines="line";

        // Group the v nodes on the top row
        {
            rank = same;
            H;T;
        }
        N [label = "H", shape=doublecircle]
        N -> N [arrowhead=lvee, tailport=e, label="c"];
        N -> H [arrowhead=vee, tailport=s, label="b"]; N -> T [arrowhead=vee, tailport=s, label="b"];
        H -> H [arrowhead=rvee, tailport=w, label="a,b,c"]; T -> T [arrowhead=lvee, tailport=e, label="a,b,c"]; H -> T [dir=both, arrowhead=vee, arrowtail=vee, minlen=2, label="a,b,c"];
      }
    ```
    )
  ]
]

#callout(title: "Surprise Exam continued", style: "example")[
  If an agent strongly believes an exam is on Monday or Tuesday, and updates with $!(not 1)$ (not Monday) and then $!(not 2)$ (not Tuesday), the resulting model has no states left in their belief sphere $S_0 = emptyset$. The agent has inconsistent beliefs, violating axiom $(bold("D"))$ Consistency of Beliefs.
  #splitgrid(
    (47.5%, 47.5%),
    column-gutter: 5%,
  )[
  #graph-figure(
    ```dot
        graph G {
          rankdir=LR;
          node [shape=square, style=rounded];

          subgraph cluster_0 {
              label = "";
              style = rounded;
              color = black;
              1; 2; 
          }
          3; 4; 5;
          

          // Optional edges to ensure they stay in a row
          1 -- 2 -- 3 -- 4 -- 5 [style=invis];
      }```
  )][
    #splitgrid(
        (10%, auto),
        column-gutter: 5%,
    )[#v(3.5%)
      $arrow.r.double$
    ][
    #v(3%)
    #graph-figure(
      ```dot
          graph G {
            rankdir=LR;
            node [shape=square, style=rounded];
            3; 4; 5;
            

            // Optional edges to ensure they stay in a row
            3 -- 4 -- 5 [style=invis];
        }```
    )] 
  ]#v(-1%)
]

#example("Newton")[
  _It gets worse_: Agent $a$ used to believe that Newton was the first to discover the laws of gravitation ($p$) after being inspired by being hit on the head by a falling apple ($q$). Belief set: $T={p,q,(p and q)}$

  $a$ learned this was a myth: $not (p and q)$. Belief set $T={p,q,not (p and q)}$. #text(red)[Inconsistent!]

  $a$ needs to remove $p$ or $q$ from the belief set, logic cannot tell $a$ which.
]

=== Belief Revision and AGM Theory
We can fix our update with *Belief Revision Theory*.
#info("The Problem of Belief Revision")[What happens if an agent $a$ learns a new fact $phi$ that contradicts previous beliefs?

$a$ has to give up some previous beliefs. But which of them? All of them?

No, $a$ should try to maintain as many previous beliefs as possible, while still accepting the new fact $phi$ and without arriving at a contradiction.
]

#callout(title: "AGM Theory Intuition", style: "intuition")[
  Standard Belief Revision Theory (AGM#footnote[Name after its authors: Carlos Alchourrón, Peter Gärdenfors, and David Makinson (1985).]) attempts to solve this via an axiomatic approach on theories (belief sets) $T$. 
  
  Given input $phi$, AGM defines:
  - _Expansion operator_ $T + phi$: $T union {phi}$ closed under logical inference (which can be inconsistent if the new information contradicts $T$).
  - _Revision operator_ $T * phi$: maintains consistency: only adds consistent inference results
]

#note("Standard AGM fails to capture higher-order beliefs.")[]

#def("AGM Postulates for Belief Revision")[
  Let $T$ be a theory and $phi, psi$ be formulas. The AGM revision operator $*$ satisfies:
  1. *Closure:* $T * phi$ is a belief set.
  2. *Success:* $phi in T * phi$.
  3. *Inclusion:* $T * phi subset.eq T + phi$.
  4. *Preservation:* If $not phi in.not T$ then $T + phi subset.eq T * phi$.
  5. *Vacuity:* $T * phi$ is inconsistent iff $tack not phi$.
  6. *Extensionality:* If $tack phi <-> psi$, then $T * phi = T * psi$.
  7. *Subexpansion:* $T * (phi and psi) subset.eq (T * phi) + psi$ (Note: symmetry of conjunction).
  8. *Superexpansion:* If $not psi in.not T * phi$, then $T * (phi and psi) supset.eq (T * phi) + psi$.
]

#question("Are the postulates 'correct'?")[This is impossible to say without formal semantics; no defintion for $*$. AGM only defines syntax.]

#callout(title: "Higher-Order Beliefs and AGM", style: "attention")[
  AGM postulates become inconsistent when applied to higher-order beliefs. For a Moore sentence $phi := p and not #belief($p$)$, the Success postulate requires believing $phi$ after learning it, which forces an introspective agent to acquire inconsistent beliefs. Furthermore, Vacuity is too liberal, allowing revision with any consistent sentence even if the agent already *knows* its negation. 
]

*Limiting Vacuity* $A G M^K$: Updated axioms (@def-agm-postulates-for-belief-revision)
- Vacuity states: successful revision with _any_ logically consistent sentence $phi$ (not a contradiction)
- Accounting for the agent's knowledge $T$: if $not phi in T$, should never revise with $phi$
$arrow.r.double$ restrict Vacuity to formulas that are logically consistent and consistent with $T$: $ "if" not #knowledge($not phi$) "then" T star phi "is consistent" $

=== Defining a more expressive language for Belief Revision
_Strategy_ for defining a more expressive language + proof system:
1. *Syntax*: (Non-monotonic) Conditional Logic: Conditional belief operators as contingency plans for belief revision.
2. *Semantics*: Conditional Logic
#v(-0.5em)
#splitgrid((47.5%, 47.5%), column-gutter: 5%)[
  #list(marker: "", list([Grove sphere models (Lewis-Stalnaker \ semantics for counterfactual conditionals)],[Spohn ordinal ranking models],
  [Preferential models (J. Halpern)],))
][
  #list(marker: "", list(
  [Belief revision models (O. Board)],
  [Plausibility models (Baltag, Smets)],
  [Probabilistic models and spaces (Popper, Brandenburger)]))
]

==== Sphere Models
#callout(title: "Fallback Beliefs", style: "intuition")[
  To accommodate belief revision semantically, agents need a contingency plan—weaker secondary beliefs they can fall back on if their primary beliefs are contradicted. This is formalized using nested spheres $S_0, S_1,...$ or plausibility orders over states.
]

#example("Suprise Exam")[
  #splitgrid(split_equal, column-gutter: 1%)[
    Student $a$ has tiered levels of belief: 
  - _strongest_: $S_0 = {1,2}$
  - _a bit weaker_: $S_1 = {1,2,3,4}$
  - _weakest_ (implicit): $S_2 = S = {1,2,3,4,5}$
  ][
    #graph-figure(
    ```dot
      graph G {
        rankdir=LR;
        node [shape=square, style=rounded];

        subgraph cluster_1 {
          margin = 4;
          style = rounded;
          color = black;
            subgraph cluster_0 {
                margin = 4;
                style = rounded;
                color = black;
                1; 2; 
            }
            3; 4; 
        }    
        5;
        

        // Optional edges to ensure they stay in a row
        1 -- 2 -- 3 -- 4 -- 5 [style=invis];
    }```
  )
  ]
  #v(-1.5em)
  If $a$'s first belief $S_0$ (Monday or Tuesday) is wrong, then $a$'s contingency is to belief in $S_1$ (Wednesday or Thursday).

  #splitgrid((70%,auto), column-gutter: 5%)[
    Now, after updates $!not 1, !not 2$, $a$ still holds consistent beliefs:

    We can repeat this with the implicit last sphere of belief $S_2$, \ maintaining consistency and allowing for automatic belief revision.
  ][
    #graph-figure(
      ```dot
        graph G {
          rankdir=LR;
          node [shape=square, style=rounded];


          subgraph cluster_0 {
              margin = 4;
              style = rounded;
              color = black;
              3; 4; 
          }
                
          5;
          

          // Optional edges to ensure they stay in a row
          3 -- 4 -- 5 [style=invis];
      }```
    )
  ]
]

#remember("Well-foundedness and converse well-foundedness")[
  #def-group(
    def("Well-foundedness")[
      Means there are *no infinite descending chains* ($S_0 > S_1 > dots > S_n > dots$). This guarantees that every non-empty subset has a minimal element (e.g., a "closest" world or "smallest" sphere).
    ],
    def("Converse well-foundedness")[
      Means there are *no infinite ascending chains* ($S_0 < S_1 < dots < S_n < dots$) of better and better worlds. This guarantees that every non-empty subset has a maximal element (e.g., a "most plausible" world).
    ],
  )
]#v(-0.5em)

#def("Single-Agent Sphere Model for Belief Revision (Grove Model)")[
  A Grove model is a tuple $bold("S") = (S, cal(F), #interpretation($dot$), #actual_state)$, where $cal(F)$ is a nested, well-founded, and exhaustive family of subsets of $S$ (spheres) such that:
  1. Nested: $forall S', S'' in cal(F)$, either $S' subset.eq S''$ or $S'' subset.eq S'$.
  2. Smallest intersecting sphere: $ forall P subset.eq S "with" P eq.not emptyset, quad exists S' in cal(F): forall S'' in cal(F): P inter S'' eq.not emptyset iff S' subset.eq S'' $
  3. Exhaustive: $inter cal(F) eq.not emptyset$ and $S = union cal(F)$.
  The smallest sphere $S_0 = inter cal(F)$ represents the agent's strongest beliefs.
]

#note("")[The above is an extension of simple models (not yet Kripke).]

*Spohn Ordinals*
Because the family of spheres $cal(F)$ is well-founded, we can sequentially identify the smallest spheres and index them:
- *Smallest sphere:* $S_0 := inter cal(F)$, which has the property that $S_0 subset.eq S'$ for all spheres $S' in cal(F)$.
- *Next smallest:* $S_1 in cal(F) backslash {S_0}$, such that $S_1 subset.eq S'$ for all remaining spheres $S' in cal(F) backslash {S_0}$.
- *Indexing:* This allows the family $cal(F)$ to be indexed by ordinals (or natural numbers in finite cases) up to some ordinal $beta$:
  $S_0 subset S_1 subset dots subset S_alpha subset S_(alpha+1) subset dots subset S_beta = S$

#def-group(
  def("Spohn Ordinal / Degree of Implausibility")[
    For every world $w in S$, the Spohn ordinal $"ord"(w)$ of world $w$ is defined as the _least ordinal_ $alpha$ such that $w in S_alpha$, it represents the _"degree of implausibility"_ of $w$.
    #v(-0.3em)
  ],
  def("Belief and Knowledge in Grove models")[
    As in epistemic-doxastic models (@def-epistemic-doxastic-kripke-model): \ by quantifying respectively over
    - $S$ for knowledge, and over
    - $S_0$ for belief. (Student question: quantify over $S_1,S_2,...$ for weaker beliefs?)
    #v(-0.3em)
  ],
  def("Updates in Grove models")[
    An _update_ $!phi$ with a sentence $phi$ is defined on full sphere models $bold("S") = (S, cal(F), #interpretation($dot$), #actual_state)$ similarly as on sphere-based epistemic-doxastic models (@def-epistemic-doxastic-kripke-model), except the family of spheres is restricted to worlds in $interpretation(phi)_bold("S")$, the new family of spheres is $ cal(F)^prime = {S^prime inter interpretation(phi)_bold("S") space | space S^prime in cal(F): S^prime inter interpretation(phi)_bold("S") != emptyset} $
    #v(-0.4em)
  ]
)

==== Plausibility Models
#remember("")[
  #def-group(
    def("Preorder")[Reflexive and transitive binary relation $R$ on set $S$: 
    $ forall s in S: s <= s "and" forall s,t,w in S: (s <= t and t <= w) arrow s<=w $#v(-0.5em)],
    def("Totality of a binary relation")[
      $ forall s,t in S: s <= t or t <= s $#v(-0.5em)
    ]
  )
]#v(-0.5em)
#let le_ = $lt.eq$
#let plaus = "pl."
#let le_plaus = $#le_ _#plaus$ // change to prec?
#let le_plaus_not = $cancel(#le_) _#plaus$
#def("Single-Agent Plausibility Model")[
  A plausibility model is a tuple $bold("S") = (S, #le_plaus, #interpretation($dot$), #actual_state)$ where:
  - $S$ is a non-empty set of states (_possible worlds_).
  - $#le_plaus op(subset.eq) S times S$ is a converse-well-founded total preorder (_plausibility order_).
  - $interpretation(dot)$ assigns a set of worlds $interpretation(p)_bold("S") subset S$ to each $p in Prop$ (_valuation_).
]#v(-0.5em)
#intuition("Plausibility order")[
  $s #le_plaus t$ means:
  1. $s$ is at least as plausible as $t$.
  2. $t$ is in at least as many spheres as $s$.
  3. Independent of what agent $a$ learns, as long as $s$ is consistent with $a$'s beliefs and $t$ is epistemically possible, $t$ is also consistent with $a$'s beliefs. 
]
#v(-0.5em)

#callout(title: "Equivalence of Spheres and Plausibility", style: "note")[
  Grove models (@def-single-agent-sphere-model-for-belief-revision-grove-model) and plausibility models (@def-single-agent-plausibility-model) are mathematically equivalent. The plausibility relation can be extracted via $ s #le_plaus t iff forall S' in cal(F) : (s in S' arrow t in S') $ An alternative statement using Spohn Ordinals (@def-spohn-ordinal--degree-of-implausibility): $ s #le_plaus t arrow.r.l.double "ord"(s) >= "ord"(t). $
  
  Conversely, spheres can be generated by $ cal(F) := {w^(lt.eq) : w in S}; w^(lt.eq) = {s in S : w #le_plaus s}. $
]#v(-0.5em)

#notation("Strict plausibility")[
  A bit of syntactic sugar: abbreviate $(s<=t "and" t #le_plaus_not)$ as $s<t$.
]
#note("Most plausible states")[
  Totality + converse well-foundedness together are equivalent to requiring that in every set of states $S$ there are some “most
plausible” ones: for every $P subset.eq S$, if $P$ is non-empty then the set
$ "bestP" = max_#le_plaus P := {s in P | forall t in P: t #le_plaus s} $
is also nonempty: $"bestP" != emptyset$.
]

#def-group(
  def("Interpretation Map on Plausibility models")[
    We extend the valuation $norm(p)_S$ to an interpretation map $#interpretation($dot$)_S$ for all propositional formulas using standard Boolean connectives.
    - *Knowledge*: Truth in all possible worlds. A sentence $phi$ is known iff its interpretation is the whole state space:
      $ #interpretation($#knowledge($phi$)$)_S = {s in S : #interpretation($phi$)_S = S} $
      Meaning $#interpretation($#knowledge($phi$)$)_S = S$ iff $#interpretation($phi$)_S = S$, and $emptyset$ otherwise.
    - *Belief*: Truth in all the most plausible worlds.
      $ #interpretation($#belief($phi$)$)_S = {s in S : "best" S subset.eq #interpretation($phi$)_S} $
      Meaning $#interpretation($#belief($phi$)$)_S = S$ iff $"best" S subset.eq #interpretation($phi$)_S$, and $emptyset$ otherwise.
  ],
  // def("Knowledge and Belief in Plausibility Models")[
  //   - *Knowledge:* $s models #knowledge($phi$)$ iff $#interpretation($phi$)_S = S$.
  //   - *Belief:* $s models #belief($phi$)$ iff $"best" S subset.eq #interpretation($phi$)_S$. 
  // ],
)

=== Conditional Beliefs and The Logic of Knowledge

#def("Conditional Belief")[
  Let $P,Q subset.eq S$ be two propositions over a model $bold("S")$ and let $phi,psi$ be sentences. We say that at any world $s in S$,
  - $belief(P, sup: Q)$: $P$ is believed conditional on $Q$, if $P$ is true in the most plausible $Q$-worlds:

  $ "bestQ" subset.eq P $

  - $belief(psi, sup: Q)$: $psi$ is believed conditional on $Q$, if $psi$ is true in the most plausible $Q$-worlds:

  $ "bestQ" subset.eq interpretation(psi)_bold("S") $
  
  - $#belief($psi$, sup: $phi$)$: $psi$ is believed conditional on $phi$, if  $interpretation(psi)_bold("S")$ is believed given $interpretation(phi)_bold("S")$:

  $ #interpretation($#belief($psi$, sup: $phi$)$)_bold("S") = {s in S : "best" #h(-0.05em) #interpretation($phi$)_S subset.eq #interpretation($psi$)_S} $
]

#intuition("Conditional Beliefs as Contingency Plans")[
  Think of $belief(psi, sup: phi)$ as contingency plans for belief change: 

  In case find out $phi$, change belief to $psi$.
]

#callout(title: "Conditional Belief as Belief Revision", style: "note")[
  We can semantically capture the AGM(@def-agm-postulates-for-belief-revision) revision operator using conditional belief  (@def-conditional-belief): $T * phi := {theta : #actual_state models #belief($theta$, sup: $phi$)}$. This interpretation guarantees that all modified AGM axioms are sound.
]




#example("Surprise Exam")[
  When drawing a plausibility model:
  - Preorder: Assume reflexivity and transitivity $arrow.r.double$ (not drawn) 
  - $s arrow t$: $t #le_plaus s$ (e.g., $4 #le_plaus 5$ and $5 arrow 4$).
  #graph-figure(
    ```dot
    digraph G {
          rankdir=LR;
          node [shape=square, style=rounded];
          
          // Setting the global arrowhead style
          edge [arrowhead=vee, arrowtail=vee];

          A [label="1"]; 
          B [label="2"]; 
          C [label="3"]; 
          D [label="4"]; 
          E [label="5"];

          // A and B point to each other
          A -> B [dir=both];
          C -> D [dir=both];
          
          // Nodes are laid out B to E, but arrows point backwards (E -> D -> C -> B)
          B -> C [dir=back]; D -> E [dir=back];
    }```
  )
  - $belief((1 or 2))$, $belief((3 or 4), sup: not (1 or 2))$
]

#example("Professor Wine - Formalization", label_: "professor-wine")[
  Professor Wine knows there are only two explanations for feeling like a genius: he is a genius ($g$) or he's drunk ($d$). He doesn't feel drunk, so he believes he is a sober genius. If he realized he was drunk, he would conditionally believe his genius feeling was just the drink (drunk non-genius). In reality, he is both drunk and a genius.
  - *Assumptions*: $#belief($g$)$, $#knowledge($g or d$)$, $#belief($not d$)$, $#belief($not g$, sup: $d$)$, and $d and g$.
  - *The Model*: Worlds are $(d, g)$, $(d, not g)$, $(not d, g)$. The actual world is $(d, g)$.
  - *Plausibility Order*: $(not d, g) < (d, not g) < (d, g)$. No $(not d, not g)$ world exists because he knows $#knowledge($g or d$)$.
  - *Conclusion*: He believes he is a genius ($(d, g) models #belief($g$)$), but he does not *know* it, since $(d, not g)$ is a possible world. True belief is not knowledge because it can be lost upon learning new facts (like learning $d$).

  #graph-figure(
    ```dot
    digraph G {
          rankdir=LR;
          node [shape=square, style=rounded];
          
          // Setting the global arrowhead style
          edge [arrowhead=vee, arrowtail=vee];

          A [label="* d,g", fontcolor="red"]; 
          B [label="d, ㄱg"]; 
          C [label="ㄱd, g"]; 
          
          A -> B -> C;
    }```
  )
]

#theorem("Full Introspection of Conditional Beliefs")[
  Strong introspection holds for knowledge and standard beliefs, and it importantly extends to conditional beliefs:
  $ #belief($phi$, sup: $psi$) arrow #knowledge(belief($phi$, sup: $psi$)) $ $ not #belief($phi$, sup: $psi$) arrow #knowledge($not belief(phi, sup: psi)$) $
]

#note("Knowledge vs. True Belief")[
  Knowledge implies true belief ($#knowledge($phi$) arrow phi and #belief($phi$)$), but the converse is false in this setting. 
  
  Not every true belief qualifies as "knowledge", as it lacks stability against belief revision. (Recall @example-professor-wine)
]

=== Kripke Semantics and Belief Modalities

#callout(title: "Difference from Standard Kripke Semantics", style: "attention")[
  While plausibility models are single-agent Kripke models, the semantics of belief is *not* given by the standard Kripke semantics for the plausibility relation $#le_plaus$. 

  Belief is *not* the Kripke modality for the plausibility relation.
]

#question("Knowledge as a Kripke Modality")[
  For a set $S$, we must have:
  $ s models knowledge(phi) arrow.r.l.double forall t: (s R_"knowledge" t) arrow (t models phi) $
]

#theorem("Belief and Conditional Belief as Kripke Modalities")[
  We can define appropriate accessibility relations to make belief a Kripke modality:
  - *Doxastic Accessibility Relation* $R_"belief"$:
    $s R_"belief" t iff t in "bestS"$
    #list(marker: none)[Then $s models #belief($phi$)$ iff $forall t (s R_"belief" t arrow t models phi)$.][Endowed with $R_"belief"$, plausibility models become KD45 doxastic models.]
  - *Conditional Doxastic Accessibility Relation* $R_"belief"^psi$:
    $ s R_"belief"^psi t iff t in "best" #interpretation($psi$)_S $
    Then conditional belief is a Kripke modality: $s models #belief($phi$, sup: $psi$)$ iff $forall t (s R_"belief"^psi t arrow t models phi)$.
]

#note("Seriality and Consistency of Conditional Belief")[
  The conditional doxastic arrows $R_"belief"^psi$ are *not necessarily serial*. They are serial only if the condition $psi$ is consistent with the agent's knowledge (i.e., $not #knowledge($not psi$)$ or $#interpretation($psi$)_S != emptyset$).
  - *Interpretation*: Revision is restricted by knowledge. If $phi$ is known to be false, the agent should not be able to revise with $phi$.
  - *Warning - Counterfactual vs. Conditional*:   
    - _Counterfactually_, an agent may consistently imagine possibilities that go against their knowledge. 
    - _Conditionally_, consistent beliefs must be based on possibilities consistent with their knowledge.
]

*Interpreting $A G M^K$ using conditional beliefs*:
Given a plausibility model $bold("S") = (S, #le_plaus, interpretation(dot), #actual_state)$
$ T = {theta in L | #actual_state models_bold("S") belief(theta)} $
where $L$ is the language of epistemic-doxastic logic.

_Note_: the agent's current theory $T$ consists of all the sentences beliefed in model $bold("S")$ at the real world $#actual_state$.

For a sentence $phi in L$:
$ T star phi := {theta in L | #actual_state models_bold("S") belief(theta, sup: phi)} $

If we interpret revision with $phi$ in terms of doxastic conditioning with $phi$, all the $A G M^K$ axioms are sound. In fact $A G M^K$ are a subset of the following.

#callout(title: "Axiomatization of Knowledge and Conditional Belief", style: "theorem")[
  The complete logic bridging knowledge and conditional belief includes:
  - *Propositional tautologies*
  - *Modus Ponens*
  - *Necessitation:* From $tack phi$ infer $tack #belief($phi$, sup: $psi$)$ and $tack #knowledge($phi$)$
  - *Normality:* $#belief($phi => theta$, sup: $psi$) => (#belief($phi$, sup: $psi$) => #belief($theta$, sup: $psi$))$
  - *Truthfulness of Knowledge:* $tack #knowledge($phi$) => phi$
  - *Persistence of Knowledge:* $tack #knowledge($phi$) => #belief($phi$, sup: $psi$)$
  - *Full Introspection:* $tack #belief($phi$, sup: $psi$) => #knowledge(belief($phi$, sup: $psi$))$ and $tack not #belief($phi$, sup: $psi$) => #knowledge($not #belief($phi$, sup: $psi$)$)$
  - *Success of Belief Revision:* $tack #belief($phi$, sup: $phi$)$
  - *Consistency of Belief Revision:* $tack not #knowledge($not phi$) => not #belief($"False"$, sup: $phi$)$
  - *Inclusion:* $tack #belief($theta$, sup: $phi and psi$) => #belief($psi => theta$, sup: $phi$)$
  - *Rational Monotonicity:* $tack not #belief($not psi$, sup: $phi$) and #belief($theta$, sup: $phi$) => #belief($theta$, sup: $phi and psi$)$
]

=== Dropping Well-foundedness

#callout(title: "Infinite Models and Generalization", style: "intuition")[
  In finite models, converse well-foundedness of $#le_plaus$ is automatically satisfied. If we drop this condition for infinite cases (keeping only the totality of the preorder $#le_plaus$), we can no longer guarantee the existence of "most plausible" states ($"best" S$ might be empty).
]

#def("Belief in Non-Wellfounded Models")[
  We redefine conditional belief as "truth in all worlds that are plausible enough":
  $ #interpretation($#belief($phi$, sup: $psi$)$)_S = {s in S : exists w in #interpretation($psi$)_S (#interpretation($psi$)_S inter w^(lt.eq) subset.eq #interpretation($phi$)_S)} $
  where $w^(lt.eq) = {t in S : w #le_plaus t}$ is the sphere determined by $w$.
]

#theorem("Properties of Generalized Plausibility Models")[
  - On converse-wellfounded models, this new definition is equivalent to the standard one.
  - The logic of conditional beliefs on totally preordered (generalized) plausibility models is *exactly the same* as on converse-wellfounded plausibility models (the proof system remains sound and complete).
  - *Key Differences*: Belief is *not* a Kripke modality in generalized models. Most importantly, the set of sentences that are believed may be *inconsistent* in such models, even though any finite subset of them is consistent.
]

== (Lecture): #lectures.t4-2.name <tutorial4-2>

== (Lecture): #lectures.l4-3.name <lecture4-3>

== Homework 1
September 16

= Week 5

== (Lecture): #lectures.l5-1.name <lecture5-1>

== (Lecture): #lectures.t5-2.name <tutorial5-2>

== (Lecture): #lectures.l5-3.name <lecture5-3>

= Week 6

== (Lecture): #lectures.l6-1.name <lecture6-1>

== (Lecture): #lectures.t6-2.name <tutorial6-2>

== (Lecture): #lectures.l6-3.name <lecture6-3>

= Week 7

== (Lecture): #lectures.l7-1.name <lecture7-1>

== (Lecture): #lectures.t7-2.name <tutorial7-2>

== (Lecture): #lectures.l7-3.name <lecture7-3>

= Week 8

== (Lecture): #lectures.l8-1.name <lecture8-1>

== (Lecture): #lectures.t8-2.name <tutorial8-2>

== (Lecture): #lectures.l8-3.name <lecture8-3>

#heading(numbering: "A")[Glossary: Definitions and Theorems]
#outline(
  title: "List of Definitions",
  target: figure.where(kind: "definition")
)

#outline(
  title: "List of Theorems",
  target: figure.where(kind: "theorem-box")
)
