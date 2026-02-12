#import "@preview/diagraph:0.3.6": *

#raw-render(
  ```dot
  digraph Z {
    rankdir=LR;
    node [shape=circle];
    w_0;
    w_1 [xlabel="p"];
    w_0 -> w_1;

    v_0;
    v_1 [xlabel="p"];
    v_2 [xlabel="p"];
    v_0 -> v_1;
    v_0 -> v_2;

    {rank = min; w_0; v_0;}
    {rank = max; w_1; v_1; v_2;}

    w_0 -> v_0 [style="dashed", color="purple"]
    w_1 -> v_1 [style="dashed", color="purple"]
    w_1 -> v_2 [style="dashed", color="purple"]
  }
  ```
)