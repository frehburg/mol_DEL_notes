#import "utils/progress_bar.typ": *
#import "@preview/clean-math-paper:0.2.4": *
#import "examples/themes/filips-math-paper/template.typ": paper
#import "@preview/curryst:0.5.1": rule, prooftree
#import "utils/box.typ": box
#import "utils/def.typ": def

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
  pagebreak(weak: true)
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
  "l1-1": ("status": STATUS.NOT_STARTED, "name": "Introduction: Motivation, Main Themes, Epistemic Puzzles", "ref": ref(<lecture1-1>)),
  "l1-2": ("status": STATUS.NOT_STARTED, "name": "Main Themes and Puzzles Continued", "ref": ref(<lecture1-2>)),
  "l1-3": ("status": STATUS.NOT_STARTED, "name": "Single-Agent Epistemic-Doxastic Logics: Kripke Models", "ref": ref(<lecture1-3>)),
  "l2-1": ("status": STATUS.NOT_STARTED, "name": "Multi-agent Models and Public Announcement Logic (PAL)", "ref": ref(<lecture2-1>)),
  "l2-2": ("status": STATUS.NOT_STARTED, "name": "PAL Continued", "ref": ref(<lecture2-2>)),
  "l2-3": ("status": STATUS.NOT_STARTED, "name": "Does this one even exist??", "ref": ref(<lecture2-3>)),
  "l3-1": ("status": STATUS.NOT_STARTED, "name": "\"Learnability\" and \"Knowability\"", "ref": ref(<lecture3-1>)),
  "t3-2": ("status": STATUS.NOT_STARTED, "name": "Tutorial 1", "ref": ref(<tutorial3-2>)),
  "l3-3": ("status": STATUS.NOT_STARTED, "name": "The problem of belief revision", "ref": ref(<lecture3-3>)),
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


#let progress_status = 1//lectures.values().sum()
#let max_progress_status = lectures.len()*STATUS.DONE

#progress-bar(
  width: 93%,
  height: 15pt, 
  current: progress_status + 0.1,
  min: 0,
  max: max_progress_status, 
  fill: gradient.linear(red, orange),
  radius: 2pt
)
#pagebreak()

= Week 1

== (Lecture): #lectures.l1-1.name <lecture1-1>
#box(title: "Multi-Agent Systems", style: "example")[
  + *Computation*: a network of communicating computers (e.g., the internet)
  + *Games*: players in a game (e.g., chess or poker)
  + *AI*: a team of robots exploring their environment and interacting with each other
  + *Cryptographic Communication*: agents ("principals") using a cryptographic protocol to communicate in private
  + *Economics*: transactions in a market
  + *Society*: social activities
  + *Politics*: diplomacy, war
  + *Science*: a community of scientists, engaged in creating theories about nature, making observations and performing experiments to test their theories
]

#def("Properties of Multi-Agent Systems")[
  - afjakldsakjfdsakjfdas;k
]


== (Lecture): #lectures.l1-2.name <lecture1-2>

== (Lecture): #lectures.l1-3.name <lecture1-3>

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
