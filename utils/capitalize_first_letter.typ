#let capitalize_first_letter(s) = {
  if s.len() > 0 {
    upper(s.slice(0, 1)) + s.slice(1)
  } else {
    s
  }
}

// Examples of how to use it:
#capitalize_first_letter("hello world") \
#capitalize_first_letter("Already capitalized") \
#capitalize_first_letter("a") \
#capitalize_first_letter("") \
#capitalize_first_letter("123 starts with a number")