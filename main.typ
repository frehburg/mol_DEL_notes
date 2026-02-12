#import "utils/progress_bar.typ": *
#import "@preview/clean-math-paper:0.2.4": *
#import "@preview/curryst:0.5.1": rule, prooftree

#let date = datetime.today().display("[month repr:long] [day], [year]")

// Modify some arguments, which can be overwritten in the template call
#page-args.insert("numbering", "1/1")
#text-args-title.insert("size", 2em)
#text-args-title.insert("fill", black)
#text-args-authors.insert("size", 12pt)

#show: template.with(
  title: "ML Homework Assignment 5",
  authors: (
    (name: "Filip Rehburg", affiliation-id: 1, orcid: "0009-0007-0457-5724"),
  ),
  affiliations: (
    (id: 1, name: "Institute of Logic, Language, and Computation, \nUniversity of Amsterdam"),
  ),
  date: date,
  heading-color: rgb("#000000"),
  link-color: rgb("#008002"),
)

#set list(marker: ([$circle.filled.tiny$], [], []))
#set math.equation(numbering: "(1)")

#let bar(x) = $macron(#x)$ //gr MACRON

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
  "l1-1": ("status": STATUS.NOT_STARTED, "name": "Introduction", "ref": ref(<lecture1>)),
  "l1-2": ("status": STATUS.NOT_STARTED, "name": ""),
  "l1-3": ("status": STATUS.NOT_STARTED, "name": ""),
  "l2-1": ("status": STATUS.NOT_STARTED, "name": ""),
  "l2-2": ("status": STATUS.NOT_STARTED, "name": ""),

  "l3-2": ("status": STATUS.NOT_STARTED, "name": ""),
  "l3-3": ("status": STATUS.NOT_STARTED, "name": ""),
  "l3-1": ("status": STATUS.NOT_STARTED, "name": ""),
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

= Lecture 1-1 <lecture1>