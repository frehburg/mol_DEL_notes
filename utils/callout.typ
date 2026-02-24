#import "@preview/octique:0.1.0": *
#import "capitalize_first_letter.typ": capitalize_first_letter

#let styles = (
  "standard": (
    "color": rgb("#000000"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
  ),
  "intuition": (
    "color": rgb("#add8e6"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    "icon": octique-inline("info", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Intuition"
  ),
  "example": (
    "color": rgb("#613188"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    "icon": octique-inline("list-unordered", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Example",
    "numbered": true // Added numbering flag
  ),
  "theorem": (
    "color": rgb("#7276d4"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    "icon": octique-inline("log", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Theorem",
    "numbered": true // Added numbering flag
  ),
  "proof": (
    "color": rgb("#bfd743"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    "icon": octique-inline("checklist", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Proof"
  ),
  "attention": (
    "color": rgb("#ff7327"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    "icon": octique-inline("alert", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Attention"
  ),
  "remember": (
    "color": rgb("#057f1e"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    "icon": octique-inline("eye", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Remember"
  ),
  "question": (
    "color": rgb("#af1e83"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    "icon": octique-inline("question", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Question"
  ),
  "info": (
    "color": rgb("#1c8fab"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    "icon": octique-inline("info", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%)
  ),
  "note": (
    "color": rgb("#00c3205f"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    "icon": octique-inline("pencil", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Note"
  ),
  "notation": (
    "color": rgb("#770303e8"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    "icon": octique-inline("book", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Notation"
  ),
  // "code": (
  //   "color": rgb("#2cff01e8"),
  //   "neg-color": rgb("#2c2c2c"),
  //   "text-color": rgb("#2cff01e8"),
  //   "icon": octique-inline("terminal", color: rgb("#000000"), width: 1em, height: 1em, baseline: 25%),
  //   "prefix": "Gamer Mode"
  // ),
)

#let callout(title: "", style: "standard", ignore-prefix: false, content) = {
  let style_dict = styles.at(style)
  let fig-kind = style + "-box"
  
  // Hide the default caption below the figure, but keep it for the outline
  show figure.caption: none
  
  figure(
    kind: fig-kind,
    supplement: capitalize_first_letter(style),
    caption: title,
    
  [#block(
    // The outer block creates the border and the rounded corners
    stroke: 1pt + style_dict.color,
    radius: 0.5em,
    clip: true, 
    width: 100%,
    
    stack(
      dir: ttb, 
      
      // Header: Black text on white background
      block(
        width: 100%,
        fill: style_dict.color,
        inset: 5pt,
      )[#align(left)[
        #let title-color = style_dict.at("title-color", default: style_dict.neg-color)
        
        // 1. Prepare the icon
        #let icon-part = if "icon" in style_dict { style_dict.icon + h(0.7em) } else { none }
        
        // 2. Prepare the text
        #let text-part = if "prefix" in style_dict and not ignore-prefix {
          let prefix-text = style_dict.prefix
          
          if style_dict.at("numbered", default: false) {
            prefix-text = prefix-text + [ ] + context counter(figure.where(kind: fig-kind)).display()
          }
          
          if title != "" {
            text(fill: title-color, weight: "bold")[#prefix-text: #title]
          } else {
            text(fill: title-color, weight: "bold")[#prefix-text]
          }
        } else {
          text(fill: title-color, weight: "bold", title)
        }
        
        // 3. Render them side-by-side with no breaks!
        #icon-part#text-part
      ]],
      
      // Content: White text on black background
      block(
        width: 100%,
        fill: style_dict.neg-color,
        inset: 10pt,
        align(left)[
          #let text-color = style_dict.at("text-color", default: black)
          #text(fill: text-color, content)
        ]
      )
    )
  )])
}

#for tmp_style in styles.keys() {
  callout(title: "Sample Title", style: tmp_style, "This is some sample text.")
}

#let style-funcs = (:)

#for s-name in styles.keys() {
  style-funcs.insert(
    s-name, 
    (title, body) => callout(style: s-name, title: title, body)
  )
}

#let intuition = style-funcs.intuition
#let example = style-funcs.example
#let theorem = style-funcs.theorem
#let proof = style-funcs.proof
#let attention = style-funcs.attention
#let remember = style-funcs.remember
#let question = style-funcs.question
#let info = style-funcs.info
#let note = style-funcs.note
#let notation = style-funcs.notation
// #let mountain-dew = style-funcs.notation