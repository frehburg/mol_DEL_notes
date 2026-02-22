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
)

#let box(title: "", style: "standard", ignore-prefix: false, content) = {
  let style_dict = styles.at(style)
  let fig-kind = style + "-box"
  
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
        inset: 10pt,
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

// Test loop showing the new numbering behavior
#for tmp_style in styles.keys() {
  box(title: "Sample Title", style: tmp_style, "This is some sample text.")
}

// Second test to show the counter incrementing
#box(title: "Another Example", style: "example", "This example should be numbered 2.")