#import "@preview/diagraph:0.3.6": raw-render

#let tape(
  count: 5, 
  w: 30pt, 
  h: 30pt, 
  thickness: 1pt, 
  contents: (),
  selected-box: none
) = {
  let selector-stroke = .3em + blue.darken(10%)
  let selector_rect = rect(width: w*0.5, height: h*1.4, stroke: selector-stroke)
  let selector_circ = circle(radius: w * 0.3, stroke: selector-stroke)
  let selector = selector_rect
  stack(
    dir: ltr, 
    spacing: 0pt, 
    ..range(count).map(i => {
      let body = if i < contents.len() { contents.at(i) } else { [] }
      
      let is-first-box = (i == 0)
      let is-last-box = (i == count - 1)
      
      let has-dots = (body == "..." or body == $...$)
      
      let box-stroke = if has-dots and (is-first-box or is-last-box) {
        (
          top: thickness, 
          bottom: thickness, 
          left: if is-first-box { none } else { thickness }, 
          right: if is-last-box { none } else { thickness }
        )
      } else {
        thickness
      }
      
      let current-box = rect(
        width: w,
        height: h,
        stroke: box-stroke,
        align(center + horizon, body)
      )

      if i == selected-box {
        box(width: w, height: h, {
          place(center + horizon, selector)
          place(center + bottom, dy: h*0.8, text(size: 2.5em)[$bold(arrow.t)$])
          current-box
        })
      } else {
        current-box
      }
    })
  )
}

#let tapes(
  count: 1,
  box-count: 5,
  w: 30pt, 
  h: 30pt, 
  thickness: 1pt, 
  contents: (),     // Array of arrays
  selected-box: (), // Array of integers
  spacing: 40pt     // Spacing between the tapes
) = {
  stack(
    dir: ttb,       // Stack tapes top-to-bottom
    spacing: spacing,
    ..range(count).map(i => {
      // Safely fetch contents for the current tape, defaulting to empty array
      let tape-contents = if i < contents.len() { contents.at(i) } else { () }
      
      // Safely fetch selected box for the current tape, defaulting to none
      let tape-selected = if i < selected-box.len() { selected-box.at(i) } else { none }

      tape(
        count: box-count,
        w: w,
        h: h,
        thickness: thickness,
        contents: tape-contents,
        selected-box: tape-selected
      )
    })
  )
}

// --- EXAMPLE USAGE ---

#tapes(
  count: 3, 
  box-count: 7,
  contents: (
    ("...", "a", "b", "c", "d", "e", "..."), 
    ("...", "1", "0", "1", "1", "0", "..."),
    ("...", $$, $$, $$, $$, $$, "...")
  ),
  selected-box: (2, 3, 1) 
)

#let transition_function = ( 
  ("<current_state>", "<read_symbol>", "<next_state>", "<write_symbol>", "<direction>"),
  ($q_0$, $0$, $q_1$, $1$, $R$,),
  ($q_0$, $1$, $q_0$, $1$, $R$,),
  ($q_1$, $\_$, $q_"accept"$, $\_$, $L$,)
) // <current_state> <read_symbol> <next_state> <write_symbol> <direction>

#let draw-tm(transitions, start-state, accept-states) = {
  // Setup the basic graph direction and the invisible start arrow
  let dot-lines = (
    "digraph TM {",
    "  rankdir=LR;",
    "  start [shape=none, label=\"\"];"
  )

  // Add accept states (standard convention is a double circle)
  if accept-states.len() > 0 {
    dot-lines += ("  node [shape=doublecircle]; " + accept-states.join(" ") + ";",)
  }
  
  // Revert to single circles for regular states and point the start arrow
  dot-lines += (
    "  node [shape=circle];",
    "  start -> " + start-state + ";"
  )

  // Map your transition list into Graphviz edge strings
  let edges = transitions.map(t => {
    let (curr, read, next, write, dir) = t
    // Formats the edge label as: read → write, dir
    "  " + curr + " -> " + next + " [label=\"" + read + " → " + write + ", " + dir + "\"];"
  })

  // Combine everything into one large string
  let final-code = (dot-lines + edges + ("}",)).join("\n")
  
  // Wrap in a raw block and render via diagraph
  raw-render(raw(final-code, lang: "dot"))
}

// 2. Define your list of transitions (Using Strings)
#let tm_transitions = (
  ("q_0", "0", "q_1", "1", "R"),
  ("q_0", "1", "q_0", "1", "R"),
  ("q_1", "_", "q_a", "_", "L")
)

// 3. Render the Turing Machine
#block(
  [
    $M_("Turing"):$
    #draw-tm(tm_transitions, "q_0", ("q_a",))
  ]
)