#import "@preview/lovelace:0.3.0": *

#let bar(x) = $macron(#x)$ //gr MACRON
#let cpr = $c^prime$
#let schema = $upright(S)$
#let CC = $"FO"[schema]$
#let leq_iso = $tilde.equiv_"iso"$
#let iso = leq_iso
#let iso_not = $tilde.equiv.not_"iso"$
#let ex1_delta = 0.05
#let ex1_epsilon = 0.1
#let fit_ex_full = smallcaps[Fitting-Existence]
#let fit_ex = smallcaps[fe]
#let fit_const_full = smallcaps[Fitting-Construction]
#let fit_const = smallcaps[fc]
#let emp_risk_min_full = smallcaps[Empirical-Risk-Minimization]
#let emp_risk_min = smallcaps[erm]
#let GI = $italic(bold("GI"))$
#let GIcomp = $italic(bold("GI-complete"))$
#let P = $italic(bold("P"))$
#let enum_a = $a_1,...,a_k$
#let enum_y = $y_1,...,y_k$

Since @cool $in$ #GI and solves the ... problem, it is in #GI
  
    #figure(
    kind: "algorithm",
    supplement: [Algorithm],
  
    emph(pseudocode-list(booktabs: true, numbered-title: [Fitting algorithm for #CC], hooks: .5em)[
       *Input:* Set of labeled examples for #CC: $E subset.eq cal(X)_#CC times {+,-}$
       
       *Output:* A concept $phi in C_#CC$ if fitting concepts for $E$ exist, else #smallcaps["None Exists"]
        + $phi arrow.l bot$
        + *foreach* $(A,+) in E$
          + $phi arrow.l phi or phi_A$; where $phi_A$ is the canonical example for $A$ constructed as in (a)
          + *foreach* $(B,-) in E$ \/\/ test if $phi$ fits the negative examples
            + *if* $A iso B$
              + *return* #smallcaps["None Exists"]
        + *return* #smallcaps[True]
        
    ]
  )) <cool>