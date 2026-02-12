// --- Slitherlink Gadget Implementation ---
#let slithergadget(items, rows: 6, cols: 6, path: ()) = {
  // Configuration
  let cell-size = 2.5em 
  let dot-radius = 0.35em
  let unused_dot-radius = 0.1em
  let edge-stroke = 0.15em + black
  let path-stroke = 0.3em + red // New stroke for the highlighted path
  
  // Calculate offsets for data structure
  let num-cells = rows * cols
  let stride = 2 * cols + 1
  let dots-per-row = cols + 1

  // Helper to place content centered in a cell
  let place-cell(col, row, body) = {
    place(
      top + left,
      dx: col * cell-size,
      dy: row * cell-size,
      box(
        width: cell-size, 
        height: cell-size, 
        align(center + horizon, body)
      )
    )
  }

  // The gadget container
  box(
    width: cols * cell-size, 
    height: rows * cell-size, 
    inset: dot-radius, // Prevent clipping of outer dots
    {
      // 1. Draw Numbers inside cells
      for j in range(rows) {
        for i in range(cols) {
          let idx = cols * j + i
          if idx < items.len() {
            let val = items.at(idx)
            if val != "" and val != " " {
              place-cell(i, j, val)
            }
          }
        }
      }

      // 2. Draw Horizontal Edges
      for j in range(rows + 1) { 
        for i in range(cols) { 
          let idx = num-cells + stride * j + i
          if idx < items.len() and items.at(idx) == "-" {
            place(
              top + left,
              dx: i * cell-size,
              dy: j * cell-size,
              line(start: (0em, 0em), end: (cell-size, 0em), stroke: edge-stroke)
            )
          }
        }
      }

      // 3. Draw Vertical Edges
      for j in range(rows) { 
        for i in range(cols + 1) { 
          let idx = num-cells + stride * j + cols + i
          if idx < items.len() and items.at(idx) == "|" {
            place(
              top + left,
              dx: i * cell-size,
              dy: j * cell-size,
              line(start: (0em, 0em), end: (0em, cell-size), stroke: edge-stroke)
            )
          }
        }
      }

      // 4. Draw Red Path (New Feature)
      if path.len() > 1 {
        for i in range(path.len() - 1) {
          let u = path.at(i)
          let v = path.at(i + 1)

          // Calculate grid (x, y) coordinates for nodes u and v
          let ux = calc.rem(u, dots-per-row)
          let uy = int(u / dots-per-row)
          let vx = calc.rem(v, dots-per-row)
          let vy = int(v / dots-per-row)

          place(
            top + left,
            dx: ux * cell-size,
            dy: uy * cell-size,
            line(
              start: (0em, 0em),
              end: ((vx - ux) * cell-size, (vy - uy) * cell-size),
              stroke: path-stroke
            )
          )
        }
      }

// 5. Draw Grid Points (Dots)

    for j in range(rows + 1) {
      for i in range(cols + 1) {
    
        // Determine whether this dot is used
        let used = false
    
        // Check horizontal edges
        if i > 0 {
          let idx = num-cells + stride * j + (i - 1)
          if idx < items.len() and items.at(idx) == "-" {
            used = true
          }
        }
    
        if not used and i < cols {
          let idx = num-cells + stride * j + i
          if idx < items.len() and items.at(idx) == "-" {
            used = true
          }
        }
    
        // Check vertical edges
        if not used and j > 0 {
          let idx = num-cells + stride * (j - 1) + cols + i
          if idx < items.len() and items.at(idx) == "|" {
            used = true
          }
        }
    
        if not used and j < rows {
          let idx = num-cells + stride * j + cols + i
          if idx < items.len() and items.at(idx) == "|" {
            used = true
          }
        }
    
        // Check the highlighted path
        if not used and path.len() > 0 {
          let node = j * dots-per-row + i
          if path.contains(node) {
            used = true
          }
        }
    
        let r = if used { dot-radius } else { unused_dot-radius }
    
        place(
          top + left,
          dx: i * cell-size,
          dy: j * cell-size,
          move(
            dx: -r,
            dy: -r,
            circle(radius: r, fill: black)
          )
        )
      }
    }
  }

  )
  v(1em)
}

// --- Document Body ---

= Slitherlink template

== 3x3 Example with a Red Path

In a 3x3 grid, the nodes are numbered 0 to 15, row by row. 
Here we draw a path that loops through the middle: `(5, 6, 10, 9, 5)`.

#align(center, slithergadget(rows: 3, cols: 3, path: (5, 6, 10, 9, 5), (
  // Numbers (9 items)
  "3", " ", "3",
  " ", "0", " ",
  "3", " ", "3",
  
  // Edges
  // Format: 3 Horiz, then 4 Vert
  
  "-", " ", "-",       // Row 0 Top Horiz
  "|", " ", " ", " ",  // Row 0 Vert
  
  " ", " ", " ",       // Row 1 Horiz
  "|", " ", " ", "|",  // Row 1 Vert
  
  " ", "-", " ",       // Row 2 Horiz
  " ", " ", " ", " ",  // Row 2 Vert
  
  "-", " ", "-",       // Row 3 Bottom Horiz
)))

// --- Document Body ---

= Slitherlink template

This document contains a template for typesetting Slitherlink instances and solutions.

== Standard 6x6 Example (Default)

#align(center, slithergadget((
  // Numbers (0-35)
  "1", "2", "3", "4", "5", "6",
  "7", "8", "9", "10", "11", "12",
  "13", "14", "15", "16", "17", "18",
  "19", "20", "21", "22", "23", "24",
  "25", "26", "27", "28", "29", "30",
  "31", "32", "33", "34", "35", "36",
  // Edges
  "-", "-", "-", "-", "-", "-",
  "|", "|", "|", "|", "|", "|", "|",
  "-", "-", "-", "-", "-", "-",
  "|", "|", "|", "|", "|", "|", "|",
  "-", "-", "-", "-", "-", "-",
  "|", "|", "|", "|", "|", "|", "|",
  "-", "-", "-", "-", "-", "-",
  "|", "|", "|", "|", "|", "|", "|",
  "-", "-", "-", "-", "-", "-",
  "|", "|", "|", "|", "|", "|", "|",
  "-", "-", "-", "-", "-", "-",
  "|", "|", "|", "|", "|", "|", "|",
  "-", "-", "-", "-", "-", "-",
)))

#pagebreak()

== Smaller 3x3 Example (Custom size)

Here we use `rows: 3` and `cols: 3`.

#align(center, slithergadget(rows: 3, cols: 3, (
  // Numbers (9 items)
  "3", " ", "3",
  " ", "0", " ",
  "3", " ", "3",
  
  // Edges
  // Format: 3 Horiz, then 4 Vert
  
  "-", " ", "-",       // Row 0 Top Horiz
  "|", " ", " ", " ",  // Row 0 Vert
  
  " ", " ", " ",       // Row 1 Horiz
  "|", " ", " ", "|",  // Row 1 Vert
  
  " ", "-", " ",       // Row 2 Horiz
  " ", " ", " ", " ",  // Row 2 Vert
  
  "-", " ", "-",       // Row 3 Bottom Horiz
)))