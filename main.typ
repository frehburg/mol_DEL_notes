#import "utils/progress_bar.typ": *
#import "@preview/clean-math-paper:0.2.4": *
#import "examples/themes/filips-math-paper/template.typ": paper
#import "@preview/curryst:0.5.1": rule, prooftree
#import "utils/box.typ": box
#import "utils/def.typ": def, def-group
#import "@preview/diagraph:0.3.6": *

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

#set list(marker: ([$circle.filled.tiny$], [], []))
#show heading.where(level: 1): it => {
  if it.body != [List of Definitions] and it.body != [List of Theorems] {
    pagebreak(weak: true)
  }
  it
}
#show heading.where(level: 2): it => {
  let nums = counter(heading).at(it.location())
  let lvl1 = nums.at(0)
  let lvl2 = nums.at(1)
  
  block[
    Session #lvl1\-#lvl2 #it.body
  ]
}
#set math.equation(numbering: "(1)")

#let bar(x) = $macron(#x)$ //gr MACRON

// DEL symbols
#let common-knowledge = $C square$

Instructor: Alexandru Baltag (#link("mailto:TheAlexandruBaltag@gmail.com")) \ TA: Giuseppe Manes 
(#link("giuseppe.manes@student.uva.nl"))

Do not distribute, please send this link: #link("https://github.com/frehburg/mol_DEL_notes")

#outline()
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
  str(STATUS.WORK_IN_PROGRESS): $Theta$,
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
    "status": STATUS.WORK_IN_PROGRESS, "name": "Single-Agent Epistemic-Doxastic Logics: Kripke Models", "ref": ref(<lecture1-3>)
    ),
  "l2-1": (
    "status": STATUS.NOT_STARTED, "name": "Multi-agent Models and Public Announcement Logic (PAL)", "ref": ref(<lecture2-1>)
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
  "l4-1": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<lecture3-3>)),
"t4-2": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<lecture4-1>)),
"l4-3": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<tutorial4-2>)),

"l5-1": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<lecture4-3>)),
"t5-2": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<lecture5-1>)),
"l5-3": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<tutorial5-2>)),

"l6-1": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<lecture5-3>)),
"t6-2": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<lecture6-1>)),
"l6-3": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<tutorial6-2>)),

"l7-1": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<lecture6-3>)),
"t7-2": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<lecture7-1>)),
"l7-3": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<tutorial7-2>)),

"l8-1": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<lecture7-3>)),
"t8-2": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<lecture8-1>)),
"l8-3": ("status": STATUS.NOT_STARTED, "name": "", "ref": ref(<tutorial8-2>)),
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


#let progress_status = lectures.values().map(item => item.status).sum()
#let max_progress_status = lectures.len()*STATUS.DONE

#progress-bar(
  width: 93%,
  height: 15pt, 
  current: progress_status,
  min: 0,
  max: max_progress_status, 
  fill: gradient.linear(red, orange),
  radius: 2pt
)
#align(center)[#progress_status / #max_progress_status]
#pagebreak()


#box(title: "Prompt for generating summaries")[
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
    - For all others call \`\#box(title: "Title", style: "style-name")\[Box body\]
    - Each box generates a tag \#label("def-concept-name-hyphenated"). Refer to any concept you reference back to always \@def-concept-name-hyphenated
]

= Week 1

== (Lecture): #lectures.l1-1.name <lecture1-1>

#box(title: "Motto of Dynamic Epistemic Logic")[
 _"The wise sees action and knowledge as one. They see truly."_ - Bhagavad Gita
]

=== Core Intuitions and Definitions

#box(title: "Multi-Agent Systems", style: "example")[
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

#box(title:"", style: "question")[Is knowledge a form of belief, or is knowledge more fundamental than belief?]

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

#box(title: "Distributed Knowledge: Business dealings", style: "example")[
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


#box(title: "Common Knowledge vs. 'Everybody Knows'", style: "example")[
  - Suppose everybody knows the road rules (e.g., red means "stop") and respects them.
  - *Question*: Is this enough to drive safely? *No*.
  - *Reasoning*: Merely knowing the rule is insufficient if you lack the certainty that *others* know the rules and will abide by them.
  - *Resolution*: Safe driving requires the rules to be _Common Knowledge_ (@def-common-knowledge).
]
== (Lecture): #lectures.l1-2.name <lecture1-2>
=== Epistemic Puzzles and Paradoxes

#box(title: "Puzzle 0: The Coordinated Attack", style: "example")[
  Two army divisions (A and B) must attack simultaneously to win. They communicate via messengers over a channel where messages might be captured.
  - A sends "attack at dawn" and B receives it.
  - B must acknowledge receipt, but A does not know if the acknowledgment will arrive.
  - A must acknowledge the acknowledgment, ad infinitum.
  *Result*: No finite sequence of successful message deliveries can achieve coordination.
]

#box(title: "Fixpoints and Byzantine Generals", style: "remember")[
  #def("Fixpoint")[$x$ is a fixpoint iff $f:X arrow X; x=f(x)$.]

  In the case of Puzzle 0:
  $ #common-knowledge phi equiv K_A #common-knowledge phi and K_B #common-knowledge phi $

  Where $K_X$ is the knowledge operator of agent $X$, #common-knowledge is common knowledge, $phi$ is the message about the attack time.
]

#box(title: "Coordinated Attack Intuition", style: "intuition")[
  Achieving _Common Knowledge_ (@def-common-knowledge) over an unreliable communication channel is logically impossible in a finite number of steps. Unbounded nested knowledge (@def-nested-knowledge) does not equate to true common knowledge.
]

#box(title: "Puzzle 1: To Learn is to Falsify", style: "example")[
  $A$ sends an email to her lover $C$: "$B$ doesn't know about us." 
  
  $B$ secretly intercepts and reads it.

  *Result*: The proposition was true right before reading, but the act of learning the message immediately falsifies it (a dynamic variant of Moore's Paradox).

  #box(title: "Instantaneous truth value change", style: "note")[
    *Paradox*: usually learning $phi$ means believing phi $square phi$, but here reading $phi$ leads to not believing $phi$: $square not phi$.

    *Less paradoxical with dynamic thinking*: The truth value of the statement changes instantaneously when $B$ reads and accepts it.


  ]
]


#box(title: "Non-standard Belief Revision", style: "attention")[
  Standard belief-revision postulates (e.g., AGM) fail for complex learning actions where the informational payload refers directly to the epistemic state of the receiver.
]

#box(title: "Puzzle 2 & 3: Self-Fulfilling and Self-Enabling Falsehoods", style: "example")[
  - *Self-Fulfilling*: $A$ falsely believes $B$ knows about her affair and sends a warning message. $B$ intercepts it and thereby learns of the affair. Communicating a false belief makes it true.

  #align(center)["$B$ doesn't know about us."]

  - *Self-Enabling*: $C$ (wanting to seduce faithful $A$) forges a message to himself from $A$ saying $B$ knows they are having an affair. $B$ reads it and divorces $A$. $A$, on the rebound, starts an affair with $C$. The transmission of a falsehood causally enables its own validation.
]

=== The Muddy Children and Epistemic Updates

#box(title: "Puzzle 4: Muddy Children", style: "example")[
  $4$ perfect logicians (children), exactly $3$ have dirty faces. They see others but not themselves.
  - Father publicly announces: "At least one of you is dirty."
  - Father iteratively asks: "Do you know if you are dirty or not?"
  - Children answer publicly and simultaneously based strictly on their knowledge without guessing.
  *Result*: For $2$ rounds, they answer in the negative. In the 3rd round, all $3$ dirty children confidently state they are dirty. In the 4th round, the clean child deduces they are clean.
]
#pagebreak()
#box(title: "Socratic Questioning", style: "info")[
  Discovering answers by asking questions of students. (#link("https://en.wikipedia.org/wiki/Socratic_questioning")[Wikipedia])
]

#box(title: "Muddy Children", style: "intuition")[
  1. _What's the point of the father's first announcement ("At least one of you is dirty")?_

  The initial announcement transforms distributed implicit knowledge into public _Common Knowledge_ (@def-common-knowledge). 
  
  2. _What's the point of the father's repeated questions?_

  The iterated Socratic questioning acts as sequential epistemic updates: public statements of ignorance incrementally eliminate possible worlds in the Kripke model until the true state is uniquely isolated.
]

#box(title: "Modifications of Muddy Children", style: "example")[
  - *The Amazon Island*: Isomorphic to Muddy Children. A law mandates wifes to execute their cheating husbands at noon once discovered. Queen announces at least one cheater exists and if somebody's husband is cheating, all other wives know it. With $17$ cheaters, for $16$ days nothing happens, and all $17$ are shot on day $17$.
  - *The Dangers of Mercy*: Wives of the $17$ cheaters secretly decide to spare them, while others believe strict obedience to the law is common knowledge. No shots are fired on day $17$. On day $18$, all faithful husbands are erroneously shot by their wives, who logically deduce (from flawed public premises) that their husbands must be cheating.
]

#box(title: "Puzzle 5: Sneaky Children", style: "example")[
  Children are incentivized for speed and punished for errors. After round 1, two dirty children cheat by secretly confirming to each other they are dirty, thus answering "I know" prematurely in round 2.
  - *Honest Children Always Suffer*: The 3rd dirty child logically deduces it must be clean, answers incorrectly in round 3, and is punished.
  - *Clean Children Always Go Crazy*: The 4th (clean) child faces a strict contradiction. If it blindly applies monotonic updates via classical logic, it undergoes logical explosion (believing everything).
]
#pagebreak()
=== Paradoxes of Induction and Probability

#box(title: "Puzzle 6: Surprised Children (Unexpected Hanging)", style: "example")[
  Teacher announces an exam next week, but the date will be a surprise (students won't even know the night before).
  - *Paradoxical Argumentation*: Students apply backward induction. It cannot be Friday (they'd know Thursday night). By elimination, it cannot be any day. They deduce the announcement is false.
  - *Result*: They dismiss the announcement. The exam occurs (e.g., Tuesday) and is indeed a complete surprise.
]

#box(title: "Puzzle 7: The Lottery Paradox", style: "example")[
  A fair lottery with $"1,000,000"$ tickets. 
  - Probability of ticket $x$ winning is $0.000001$.
  - It is rational to hold the belief that ticket $x$ will lose.
  - This reasoning applies symmetrically to all tickets.
  - Yet, the agent knows one ticket will win.
  *Result*: The conjunction of highly probable rational beliefs yields a strict logical *inconsistency*.
]

#box(title: "Puzzle 7 Modification: The Infinite Lottery", style: "example")[
  An infinite lottery over arbitrary natural numbers. The probability of any given ticket winning is exactly $0$. The agent is mathematically correct to believe a specific ticket will not win, yet one must win. Any finite subset of beliefs is consistent, but the infinite global set is inconsistent.
]

=== Backward Induction and Social Epistemology 


#box(title: "Puzzle 8: The Centipede Game", style: "example")[
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
    
    #align(center)[#scale(70%, reflow: true)[#figure(
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
    
    #align(center)[#scale(70%, reflow: true)[#figure(
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
  #align(center)[#scale(70%, reflow: true)[#figure(
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

#box(title: "The BI Paradox and Rational Pessimism", style: "intuition")[
  - *Aumann's Argument*: Assuming _Common Knowledge_ (@def-common-knowledge) of Rationality ($"CKR"$), backward induction dictates $A$ chooses $o_3$ at $v_2$, so $B$ chooses $o_2$ at $v_1$, so $A$ chooses $o_1$ at $v_0$. The game terminates immediately at a suboptimal Pareto outcome.
  - *Counterargument*: If $B$ reaches $v_1$, he observes $A$ violating $"CKR"$ (she didn't stop at $v_0$). If $B$ adopts *Rational Pessimism*—assuming $A$ is irrational and will thus choose $o_4$ at $v_2$—he should continue. If $A$ anticipates this belief revision, her initial deviation becomes strictly rational. The epistemic foundation of backward induction contradicts its own counterfactuals.
]

#box(title: "Puzzle 9: Wisdom vs. Madness of the Crowds", style: "example")[
  - *Wisdom of the Crowds*: Distributed group knowledge often empirically exceeds the most expert individual (e.g., aggregating independent estimates).
  - *Madness of the Crowds*: Systems can fail systematically due to cascading social epistemology.
    - *Pluralistic Ignorance*: Group members privately reject a norm but incorrectly assume others accept it (e.g., no one asking questions in a confusing lecture).
    - *Informational Cascades*: Sequential decision-making where rational agents ignore their private signals to follow public actions (e.g., sequentially guessing urn colors based on previous skewed guesses).
    - *The Circular Mill*: Biological equivalent where army ants follow the ant in front, creating an endless, fatal loop.
    - *The Human Mill*: Cold War arms races driven by circular, self-fulfilling falsehoods (e.g., nations mimicking adversary research based entirely on forged intelligence).
]

== (Lecture): #lectures.l1-3.name <lecture1-3>

=== Syntax and Core Definitions
Single-agent epistemic-doxastic logic expands standard propositional logic to formally capture an agent's knowledge and beliefs. 

$ phi ::= p | not phi | phi and phi | K phi | B phi $ 

#def("Single-Agent Epistemic-Doxastic Model")[
  A pointed epistemic-doxastic model is a tuple $S = (S, S_0, norm(.), s_*)$, consisting of:
  - $S$: A set of "possible worlds" defining the agent's _epistemic state_ (epistemically possible states).
  - $S_0$: A non-empty subset $S_0 subset.eq S$, called the _sphere of beliefs_ or _doxastic state_.
  - $norm(.): Phi -> cal(P)(S)$: A valuation map assigning atomic propositions to sets of states.
  - $s_* in S$: The designated "actual world" representing the real state of the world.
] #label("def-single-agent-epistemic-doxastic-model")

#box(title: "Semantics of Knowledge and Belief", style: "intuition")[
  The universal quantifier over the domain of possibilities is interpreted as knowledge or belief.
  - *Knowledge* ($K phi$): Truth in all epistemically possible worlds. 
    $w models K phi quad "iff" quad forall t in S, t models phi$.
  - *Belief* ($B phi$): Truth in all doxastically possible worlds within the sphere of beliefs.
    $w models B phi quad "iff" quad forall t in S_0, t models phi$.
] #label("intuition-semantics-knowledge-belief")

=== Learning and Mistaken Updates
Learning corresponds to world elimination. An update with a sentence $phi$ is the operation of deleting all non-$phi$ possibilities from the model.

#box(title: "The Concealed Coin and Mistaken Updates", style: "example")[
  *Base Scenario:* A coin is on the table; the agent does not know if it is Heads ($H$) or Tails ($T$).
  *Standard Update:* The agent looks and sees $H$. The $T$ world is eliminated, and only the $H$ epistemic possibility survives.
  *Mistaken Update:* Suppose the actual world is $T$, but the agent's sight is bad and she mistakenly believes she saw $H$. If we eliminate $T$, the actual world $s_*$ is no longer in the agent's model, making it impossible to evaluate objective truth.
  *Resolution (Third-Person Models):* We maintain an objective perspective where the real possibility always remains in the global model $S$, even if the agent believes it to be impossible. The sphere of beliefs $S_0$ is restricted to $H$, meaning the agent believes $H$, but their belief is false because $s_* in S slash S_0$.
] #label("example-concealed-coin")

=== Kripke Semantics for Epistemic-Doxastic Logic
Sphere models can be generalized using Kripke semantics to allow for varying strengths of knowledge and belief.

#def("Epistemic-Doxastic Kripke Model")[
  A Kripke model is a tuple $S = (S, {R_i}, norm(.), s_*)$ with accessibility relations $R_i$. For knowledge and belief, this becomes $(S, tilde, ->, norm(.), s_*)$, where $tilde$ is the epistemic relation (for $K$) and $->$ is the doxastic relation (for $B$). 
] #label("def-epistemic-doxastic-kripke-model")

#box(title: "Axioms and Relational Properties", style: "theorem")[
  Validities for Knowledge (Equivalence relation $tilde$, giving an S5 model):
  - *Veracity* ($K phi => phi$): $tilde$ is reflexive.
  - *Positive Introspection* ($K phi => K K phi$): $tilde$ is transitive.
  - *Negative Introspection* ($not K phi => K not K phi$): $tilde$ is Euclidean (and symmetric).

  Validities for Belief (KD45 model properties for $->$):
  - *Consistency* ($not B(phi and not phi)$): $->$ is serial.
  - *Positive Introspection* ($B phi => B B phi$): $->$ is transitive.
  - *Negative Introspection* ($not B phi => B not B phi$): $->$ is Euclidean.

  Interaction Properties:
  - *Knowledge implies Belief* ($K phi => B phi$): If $s -> t$ then $s tilde t$.
  - *Strong Positive Introspection* ($B phi => K B phi$): If $s tilde t$ and $t -> w$ then $s -> w$.
] #label("theorem-axioms-relational-properties")

#box(title: "Equivalence of Models", style: "theorem")[
  Every epistemic-doxastic sphere model $S = (S, S_0, norm(.), s_*)$ is completely equivalent to an epistemic-doxastic Kripke model $S' = (S, tilde, ->, norm(.), s_*)$ that satisfies the same sentences at $s_*$. Furthermore, given a doxastic Kripke model, the doxastic relation $->$ uniquely determines the epistemic relation $tilde$.
] #label("theorem-equivalence-of-models")

#box(title: "Logical Omniscience", style: "attention")[
  Any Kripke modality validates axiom K ($K(phi => psi) => (K phi => K psi)$) and the Necessitation rule (if $phi$ is valid, $K phi$ is valid). Consequently, Kripke semantics models "ideal reasoners" with unlimited inference powers who know/believe all logical entailments, failing to capture bounded rationality.
] #label("attention-logical-omniscience")

=== Social Epistemology and Information Cascades
Group dynamics often deviate from ideal individualized epistemic logic due to the recursive nature of social evidence.

#def("Pluralistic Ignorance")[
  A situation where the group collectively knows or acts upon less information than the individuals possess privately. Often observed in totalitarian regimes where public behavior contradicts private beliefs.
] #label("def-pluralistic-ignorance")

#box(title: "Information Cascades", style: "intuition")[
  An information cascade occurs when agents base their decisions on the observable behavior of prior agents rather than their own private evidence, leading to a breakdown of _epistemic democracy_ (the wisdom of crowds).
] #label("intuition-information-cascades")

#box(title: "The Black and White Urn Problem", style: "example")[
  *Setup:* One urn is in a room. It is either Urn B (2/3 black marbles) or Urn W (2/3 white marbles). Agents enter one by one, draw a marble, replace it, and publicly record their guess of the urn on a blackboard.
  *The Cascade:* 1. Voter 1 draws Black and guesses Urn B.
  2. Voter 2 draws Black and guesses Urn B.
  3. Voter 3 draws White. However, the public evidence (two B votes) combined with their private evidence (one W draw) yields an aggregate evidence of (B, B, W). The rational epistemic choice is still to guess Urn B.
  *Result:* From Voter 3 onwards, everyone will vote Urn B regardless of their private draw. If the first two voters happened to draw the minority color (probability $1/9$), the entire crowd of $n$ voters will lock into the wrong conclusion.
] #label("example-urn-problem")

#box(title: "Biological and Geopolitical Cascades", style: "example")[
  - *Army Ant Circular Mill:* If an army ant loses the pheromone trail, it is biologically programmed to follow the ant directly in front of it. This simple rule works locally but can result in a massive recursive loop (a death spiral up to 400m in diameter) where the ants walk in a circle until they die.
  - *The Men Who Stare at Goats (Cold War):* A French newspaper published a fabricated story about US military research into psychic weapons. Soviet intelligence read this, assumed it was a cover-up, and initiated their own psychic research program. US intelligence discovered the Soviet program and, assuming the Soviets were onto a real threat, started their own actual research program, sparking a 30-year arms race built on an initial cascade of false information.
] #label("example-biological-geopolitical-cascades")

= Week 2

== (Lecture): #lectures.l2-1.name <lecture2-1>

== (Lecture): #lectures.l2-2.name <lecture2-2>

== (Lecture): #lectures.l2-3.name <lecture2-3>

= Week 3

== (Lecture): #lectures.l3-1.name <lecture3-1>

== (Lecture): #lectures.t3-2.name <tutorial3-2>

== (Lecture): #lectures.l3-3.name <lecture3-3>

= Week 4

== (Lecture): #lectures.l4-1.name <lecture4-1>

== (Lecture): #lectures.t4-2.name <tutorial4-2>

== (Lecture): #lectures.l4-3.name <lecture4-3>

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
