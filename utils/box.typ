#import "@preview/octique:0.1.0": *

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
    "prefix": "Intuition:"
  ),
  "example": (
    "color": rgb("#613188"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    "icon": octique-inline("list-unordered", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Example:"
  ),
  "theorem": (
    "color": rgb("#7276d4"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    // "title-color": rgb("#000000"),
    "icon": octique-inline("log", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Theorem:"
  ),
  "proof": (
    "color": rgb("#bfd743"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    // "title-color": rgb("#000000"),
    "icon": octique-inline("checklist", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Proof:"
  ),
  "attention": (
    "color": rgb("#ff7327"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    // "title-color": rgb("#000000"),
    "icon": octique-inline("alert", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Attention:"
  ),
  "remember": (
    "color": rgb("#057f1e"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    // "title-color": rgb("#000000"),
    "icon": octique-inline("eye", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Remember:"
  ),
  "question": (
    "color": rgb("#af1e83"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    // "title-color": rgb("#000000"),
    "icon": octique-inline("question", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%),
    "prefix": "Question:"
  ),
  "info": (
    "color": rgb("#1c8fab"),
    "neg-color": rgb("#FFFFFF"),
    "text-color": rgb("#000000"),
    // "title-color": rgb("#000000"),
    "icon": octique-inline("info", color: rgb("#ffffff"), width: 1em, height: 1em, baseline: 25%)
  ),
)

#let box(title: "", style: "standard", ignore-prefix: false, content) = {
  let style_dict = styles.at(style)
  block(
    // The outer block creates the border and the rounded corners
    stroke: 1pt + style_dict.color,
    radius: 0.5em,
    clip: true, // Crucial: clips the inner square blocks to the rounded corners
    width: 100%,
    
    stack(
      dir: ttb, // Stacks the header and content top-to-bottom without gaps
      
      // Header: Black text on white background
      block(
        width: 100%,
        fill: style_dict.color,
        inset: 10pt,
      )[
        #if style_dict.keys().contains("icon"){
            style_dict.icon
            h(0.7em)
        }
        #let title-color = ""
        #if style_dict.keys().contains("title-color") {
            title-color = style_dict.title-color
          } else {
            title-color = style_dict.neg-color
          }
        #if style_dict.keys().contains("prefix") and not ignore-prefix {
          text(fill: title-color, weight: "bold")[#style_dict.prefix #title]
        } else {
          text(fill: style_dict.neg-color, weight: "bold", title)
        }
      ],
      
      // Content: White text on black background
      block(
        width: 100%,
        fill: style_dict.neg-color,
        inset: 10pt,
        text(fill: black, content)
      )
    )
  )
}


#for tmp_style in styles.keys() {
  box(title: "title", style:tmp_style, "text")
}