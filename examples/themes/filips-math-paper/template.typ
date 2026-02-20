#let paper(
  title: "",
  subtitle: none,
  journal: "", // Course or Journal name
  date: datetime.today(),
  authors: (), // Array of dictionaries: (name, email, affiliations)
  institutions: (), // Array of dictionaries: (name, address)
  font: "Linux Libertine",
  size: 11pt,
  body
) = {
  // 1. Setup Page Properties
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2.5cm),
    
    // HEADER: Logic to show different header on page 2+
    header: context {
      if here().page() > 1 {
        set text(size: 9pt, style: "italic", fill: gray)
        grid(
          columns: (1fr, 1fr),
          align(left, journal),
          align(right, title)
        )
        line(length: 100%, stroke: 0.5pt + gray)
      }
    },

    // FOOTER: First author (left), Page number (right) on EVERY page
    footer: context {
      set text(size: 9pt, fill: gray)
      let first_author_name = if authors.len() > 0 { authors.at(0).name } else { "" }
      
      grid(
        columns: (1fr, 1fr),
        align(left, first_author_name),
        align(right, counter(page).display("1"))
      )
    }
  )

  // 2. Set Default Font Styles
  set text(font: font, size: size)
  set par(justify: true)

  // 3. Generate the First Page "Header" (Title Block)
  v(1em)
  align(center)[
    // Journal / Course Name
    #text(size: 1.2em, weight: "bold", fill: gray.darken(30%), smallcaps(journal))
    #v(0em)

    // Title
    #text(size: 2em, weight: "bold", title)

    // Subtitle
    #if (subtitle != none) {
      v(-.75em)
      text(size: 1.2em, style: "italic", subtitle)
    }

    #v(1em)

    // Authors
    #let count = authors.len()
    #let i = 0
    #for author in authors {
      let affs = author.affiliations.map(str).join(",")
      text(weight: "semibold", author.name)
      super(affs)
      
      // Formatting for commas and "and"
      if i < count - 2 { ", " } 
      else if i == count - 2 { " and " }
      
      i += 1
    }
    
    #v(0.8em)
    
    // Emails (Optional: displayed small below authors)
    #text(size: 0.8em, fill: gray)[
      #authors.map(a => a.email).join(" | ")
    ]

    #v(1em)

    // Institution List
    #text(size: 0.9em)[
      #for (i, inst) in institutions.enumerate() {
        super(str(i + 1)) 
        h(2pt) 
        emph(inst.name) + [, ] + inst.address
        if i < institutions.len() - 1 { linebreak() }
      }
    ]
    
    #v(0.5em)
    #text(size: 0.9em)[#date.display("[month repr:long] [day], [year]")]
  ]
  
  line(length: 100%, stroke: 0.5pt + gray)
  v(2em)

  // 4. Render the Main Content
  body
}