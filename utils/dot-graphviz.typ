#import "@preview/diagraph:0.3.6": *
#let raw-g = ```dot
      digraph Z {
        node [shape=square, style=rounded];
        splines="line";

        // Group the v nodes on the top row
        {
            rank = same;
            H;T;
        }
        N [label = "H", shape=doublecircle]
        N -> N [arrowhead=lvee, tailport=e, label="c"];
        N -> H [arrowhead=vee, tailport=s, label="a,b"]; N -> T [arrowhead=vee, tailport=s, label="a,b"];
        H -> H [arrowhead=rvee, tailport=w, label="a,b,c"]; T -> T [arrowhead=lvee, tailport=e, label="a,b,c"]; H -> T [dir=both, arrowhead=vee, arrowtail=vee, minlen=2, label="a,b,c"];
      }
      ```

  
#let graph-figure(raw-graph, caption: "", label_: "") = {
  v(-.6em)
  align(center)[
    #scale(65%, reflow: true)[
      #if (caption != "" and caption != none) {
        figure(
          raw-render(
            raw-graph
          ),
          caption: caption,
          kind: "Graph",
          supplement: "Graph"
        )
      } else {
        figure(
          raw-render(
            raw-graph
          ),
          kind: "Graph",
          supplement: "Graph"
        )
      } #if (label_ != "" and label_ != none) {label(label_)}
    ]
  ]
}

#graph-figure(raw-g, label_: "test")

@test
