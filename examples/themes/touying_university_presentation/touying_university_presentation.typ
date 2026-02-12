#import "@preview/touying:0.6.1": *
#import themes.university: *

#import "@preview/numbly:0.1.0": numbly

#show: university-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Research Proposal: Extensions to Rule-Guided GNN Rule-Mining on KGs],
    subtitle: "Rule Expressivity and Uncertainty Handling",
    author: "Filip Rehburg",
    date: datetime.today(),
    institution: [ILLC, UvA],
    logo: [],
  ),
  config-page(
    foreground: place(bottom + right, dx: -2%, dy: -6%)[
      #image("res/combined-logos.png", width: 13%)
    ]
  ),
)
#set text(size:25pt)

#let vb(name) = $bold(upright(name))$

#set heading(numbering: numbly("{1}.", default: "1.1"))
#let unnumbered-slide(title, body) = {
  set heading(numbering: none)
  [
    == #title
    #body
  ]
}


#title-slide()

#unnumbered-slide("Contents")[
  #text(size: 1.5em)[
    1. Introduction to Rule-Mining
    2. Recent Paper Discussion
    3. Proposed Extensions
  ]
]

= Introduction to Rule-Mining
== Rule-Mining
- Summarizing extensional knowledge (ABox) intensionally (TBox)
$ "parent"("Alice","Bob") and "parent"("Bob","Carl") and "grandparent"("Alice","Carl") \ "parent"("Hans","Iris") and "parent"("Iris","Jane") and "grandparent"("Hans","Jane") $
  $arrow.double$ New rule: $"grandparent"(x,z) arrow.l "parent"(x,y) and "parent"(y,z)$
- Historically: Symbolic approaches
  - e.g., AMIE #cite(<galarraga2013>)

- Knowledge Graphs: Graph Neural Networks (GNNs)
  - e.g., Relational GCN #cite(<schlichtkrull2018>)
\
- *Neuro-Symbolic (NeSy) AI*: combining the strengths and weaknesses of NNs and Logic
  - NN for mining rules
  - Logical inference using rules to increase knowledge
- Strengths:
  - Explainability vs. Black box
  - Correctness vs. Hallucinations
  - Fixed vs. variable memory and inference time
  - Data efficiency vs. huge datasets


== Bibliography

#set text(size: 0.7em)
#bibliography("refs.bib")