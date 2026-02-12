#let progress-bar(
  width: 100%, 
  height: 12pt, 
  current: 0, 
  min: 0,
  max: 100, 
  fill: blue.darken(10%), 
  background: gray.lighten(50%),
  radius: 4pt,
  show_progress_numerically: false
) = {
  // Calculate the percentage, ensuring we don't divide by zero or exceed 100%
  let ratio = if max > 0 { calc.min((current - min) / max, 1.0) } else { 0 }
  
  block(
    width: width,
    height: height,
    fill: background,
    radius: radius,
    clip: true, // Ensures the inner bar doesn't bleed past the rounded corners
    {
      if ratio > 0 {
        rect(
          width: ratio * 100%,
          height: 100%,
          fill: fill,
          radius: radius,
        )
      }
    }
  )
  if show_progress_numerically {
    align(center)[#current / #max (#calc.round(calc.round(ratio, digits: 3) * 100, digits: 1)%)]
  }
}

// --- Usage Examples ---

#progress-bar(current: 75, max: 100)

#v(1em)

#progress-bar(
  width: 50%, 
  height: 15pt, 
  current: 3,
  min: 2,
  max: 10, 
  fill: gradient.linear(red, orange),
  radius: 2pt
)