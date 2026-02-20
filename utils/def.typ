#let def(concept, content) = {
  let auto-tag = label("def-" + lower(concept.replace(" ", "-")))
  
  [
    // The show rule is now locked inside the function's scope
    #show figure.where(kind: "definition"): it => block(
      fill: rgb("#f4f6f8"),
      inset: 12pt,
      radius: 4pt,
      width: 100%,
      stroke: rgb("#d0d7de")
    )[#align(left + top)[
        *#it.supplement #it.counter.display(it.numbering)* (#emph(it.caption.body)):
        #v(-0.5em) 
        #it.body
      ]
    ]
    
    // The figure and label remain exactly the same
    #figure(
      content,
      kind: "definition", 
      supplement: "Def", 
      caption: concept,
    )#auto-tag
  ]
}