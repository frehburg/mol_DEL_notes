#let splitgrid(columns, column-gutter: 1em, left-col, right-col) = {
  grid(
    columns: columns,
    column-gutter: column-gutter,
    [#left-col],
    [#right-col]
  )
}

#splitgrid(
  (60%,auto)
)[Test left: #lorem(100)]["Test right:" #square([This is a square $a^2$])]