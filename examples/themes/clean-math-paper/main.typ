#import "@preview/clean-math-paper:0.2.4": *
#import "@preview/curryst:0.5.1": rule, prooftree

#let date = datetime.today().display("[month repr:long] [day], [year]")

// Modify some arguments, which can be overwritten in the template call
#page-args.insert("numbering", "1/1")
#text-args-title.insert("size", 2em)
#text-args-title.insert("fill", black)
#text-args-authors.insert("size", 12pt)

#show: template.with(
  title: "ML Homework Assignment 5",
  authors: (
    (name: "Filip Rehburg"),
    (name: "Hugo Rennings"),
  ),
  date: date,
  heading-color: rgb("#000000"),
  link-color: rgb("#008002"),
)

#set heading(numbering: none)

#let two_mod = $chevron.l 2 chevron.r$ 
#let bisim = $underline(arrow.r.l)$
#let squish(i) = {h(i)}

#let mod_eqv = stack(dir: ltr,
  $prec$,
  squish(-3pt),
  $arrow.long.r.squiggly$,
  squish(-4pt),
  $succ$
)
#let bar(x) = $macron(#x)$ //gr MACRON
#let modals = $parallel #squish(-5pt) -$
#let iff = $arrow.l.r.double$
#let implies = $arrow.r.double$
#let limplies = $arrow.l.double$
#let k5 = $bold("K5")$
#let kmu = $bold("KMU")$
#let gl = $bold("GL")$
#let glstar = $bold("GL"^*)$
#let s4 = $bold("S4")$
#let s4g = $bold("S4.Grz")$
#let s42 = $bold("S4.2")$

#let box = $square$

#set list(marker: ([$circle.filled.tiny$], [], []))
#set math.equation(numbering: "(1)")


= Exercise 1

*By question 1 in Tutorial 10:* A normal modal logic $Lambda$ has the finite model property iff it is sound and complete with respect to $"FinFr"(Lambda)$.

// *By Definition 3.22 from the Modal Logic Book:* A normal modal logic $Lambda$ has the finite model property with respect to some class of models $upright(M)$ if $upright(M) modals Lambda$ and every formula not in $Lambda$ is refuted in a finite model $MM$ in $upright(M)$. [...]

== (a) Show that $s42$ has the FMP

Recall that #s42 is the logic defined by the transitivity and directness axioms:

$ s42 &= bold(K) + (4) + (.2) \

 s42 &= bold(K) + (diamond diamond p arrow diamond p) + (diamond square p arrow square diamond p) $

By definition $"FinFr"(kmu) modals kmu$.

Assume there is some formula $phi$ s.t. $tack.not_s42 phi$. To show the contraposition of completeness w.r.t. $"FinFr"(s42)$, we will show $exists FF in "FinFr"(s42) : FF cancel(modals) phi$.

// To show that #s42 has the FMP, we let $phi$ some formula such that $tack.not_s42 phi$, and show that it is refuted in a finite model of $s42$.

Because #s42 is complete, there must be  a frame $FF$ which refutes $phi$ in $"Fr"(s42)$: $FF cancel(modals) phi$. Thus, there must be some valuation $V$ and point $r in FF$, we write $MM = (FF,V)$, s.t. $MM,r cancel(modals) phi$. To show that there is a finite model, we will first take a generated submodel, and then apply a filtration. For this we choose the Lemmon filtration.

#let mst = $MM^"t"$
#let rst = $R^"st"$

Let $MM'$ be the the generated submodel of $MM$ with $r$ as its root node (where as mentioned above $r$ is a point such that $MM,r models not phi$). It is clear that $MM',r models not phi$, and also that $MM'$ is still transitive.

Let $Sigma = "Sub"({phi})$. Let #mst be the model resulting from applying the Lemmon filtration to $MM'$. It is clear that $mst,[r] models not phi$ (filtration theorem), and $mst$ is finite.

To show: $mst in "FinFr"(s42)$. Since $mst$ is finite, what rests is to show that the axioms of the logic are valid in #mst. 

$(4)$ Since we know that the Lemmon filtration preserves transitivity, clearly the $(4)$ axiom's validity is preserved in #mst.

$(.2)$ We let $[w]$ some point in $MM^t$, assume that $[w] models diamond box p$. We show that $[w] models box diamond p$.

We know that there exists a point $[v]$ such that $[w] R^t [v]$, and $[v] models box p$. Now take some successor $[a]$ of $[w]$. We show that $[a] models diamond p$.

We examine points $v,a$ in $MM'$ such that $v in [v],a in [a]$. By the fact that $MM'$ is a rooted and transitive model, we know that $r R' v$ and $r R' a$.

By applying the Sahlqvist algorithm, we get the standard translation of the axiom as:

$ forall x forall s (x R s arrow forall a (x R a arrow exists c (a R c arrow s R c))) $

We know that $MM'$ has this frame property, and since we have $r R' v$ and $r R' a$, we know there exists some point $c$ such that $v R' c$ and $a R' c$. By the nature of filtrations, we can infer that $[v]R^t [c]$, and $[a] R^t [c]$.

By $[v] R^t [c]$, and $[v] models box p$, we have that $[c] models p$. Since also $[a] models [c]$, we have $[a] models diamond p$ as desired.

This shows that if a point $[w]$ in $mst$ satisfies $diamond box p$, then it satisfies $box diamond p$. We conclude that all the axioms of #s42 hold on the finite frame $mst$, and so $mst in "FinFr"(s42)$.

This proves completeness of #s42 with respect to $"FinFr"(s42)$.

We conclude that $s42$ is sound and complete with respect to $"FinFr"(s42)$ and thus has the FMP.
// and thus we show that the filtered model also has this frame property.

// Let $[w],[v],[a]$ three points in $MM^t$ such that $[w]R^t [v]$ and $[w]R^t [a]$. We should show the existence of some point $[c]$ such that $[v]R^t [c]$ and $[a]R^t [c]$. We examine representatives $v$ and $a$ of respectively $[v]$ and $[a]$. Since we know that $MM'$ is a rooted model, we have that $r R v$ and $r T a$ (where we write $r$ for the root of $MM'$). Since we know that 

// Take some $[w] in mst$ s.t. $mst,[w] modals diamond square p$. T.S.: $mst,[w] modals square diamond p$. 

// Thus, there is some $[v] in mst$ s.t. $[w] rst [v]$ and $#mst, [v] modals square p$. 

// The standard translation of the $(.2)$ axiom according to the Sahlqvist algorithm is:

// $ forall x forall s (x R s arrow forall a (x R a arrow exists c (a R c arrow s R c))) $


== (b) Show that $kmu$ has the FMP

$ kmu = bold(K) + (diamond square p arrow diamond p) $

By definition $"FinFr"(kmu) modals kmu$.

// As before, we take some formula $phi$ such that $tack.not_kmu phi$, and show that there is a finite $kmu$ model that falsifies $phi$.

Assume there is some formula $phi$ s.t. $tack.not_kmu phi$. To show the contraposition of completeness w.r.t. $"FinFr"(kmu)$, we will show $exists FF in "FinFr"(kmu) : FF cancel(modals) phi$.

Because #kmu is complete, there must be a frame $FF$ which refutes $phi$ in $"Fr"(kmu)$: $FF cancel(modals) phi$. Thus, there must be some valuation $V$ and point $x in FF$, we write $MM = (FF,V)$, s.t. $MM,x cancel(modals) phi$. To show that there is a finite frame, we will apply filtration to the discussed model. For this we choose the smallest filtration $RR^"s"$.

Define $Sigma = "Sub"({phi})$. Let $MM^s$ be the model resulting from applying the smallest filtration to $MM$. Note that by the filtration theorem, we still have $MM^t,[x] models not phi$.

To show: $MM^s in "Fr"(kmu)$. We show all axioms of #kmu are preserved in filtered frame.

$(diamond square p arrow diamond p)$ Take some world $[w] in MM^s$. Suppose $MM^s,[w] modals diamond square p$. Thus there must be some $[v] in MM^s$ s.t. $[w] R^s [v]$ and $MM^s, [v] modals square p$. 

The standard translation of $diamond square p arrow diamond p$ is:
$ forall x forall s(x R s arrow exists a( x R a and s R a)) $

Thus there must be representatives $w,v in MM$ s.t. $w R v$. Since the unfiltered model satisfies the frame condition, there is $a in MM$ s.t. $w R a$ and $v R a$. By the definition of the smallest filtration, there is the $Sigma$-equivalence class $[a] in MM^s$ s.t. $[w] R^s [a]$ and $[v] R^s [a]$. Since $MM^s,[v] modals square p$, we get $MM^s, [a] modals p$ and thus $MM^s, [w] modals diamond p$. Since $w$ was chosen arbitrarily, we can generalize $MM^s modals diamond square p arrow diamond p$.

Since $(diamond square p arrow diamond p)$ holds in $MM^s$, we conclude $FF^s in "Fr"(kmu)$, since $FF^s$ is finite $FF^s in "FinFr"(kmu)$.

This proves that $s42$ is complete with respect to $"FinFr"(kmu)$.

Since we have that $s42$ is sound and complete wrt $"FinFr"(kmu)$, we conclude that it has the FMP.

#align(right,$square$)


== (c) Deduce that they are decidable
Axiomatizations:
- $Sigma_s42 = {(4), (.2)}$, $s42 = bold(K Sigma_s42)$
- $Sigma_kmu = {(diamond square p arrow diamond p)}$, $kmu = bold(K Sigma_kmu)$

It is clear that $Sigma_s42$ and $Sigma_kmu$ are both finite, thus, by definition 6.10 in the modal logic book, both #s42 and #kmu are finitely axiomatizable.

By Harrop's theorem (Thm. 4.12 in the study notes) since both #kmu and #s42 have the FMP and are finitely axiomatizable, they are decidable.

= Exercise 2

== (a) Show that $frak(g) models box(p arrow.l.r box p) arrow box p$.

Let $w in W$ and $V$ some admissible valuation. We show that $frak(g),V,w models square(p arrow.l.r square p) arrow square p$. We assume $frak(g),V,w models square(p arrow.l.r square p)$ and distinguish two cases:


- Case 1: $w in NN$.

By definition of $R$ we know that $w R v$ for any $v in NN$ such that $v<w$. If $w=0$ then it is clear that $frak(g),V,w models square p$ as desired, so we continue with the case $w eq.not 0$. Let $w'<w$. We use induction to show that $g,V,w' models p$.

Base: $w'=0$. In this case we have $w' models square p$, and by $w R w'$ and $w models square(p arrow.l.r square p)$ we have that $w' models p$.

IH: assume $frak(g),V,k models p$ for $k<n-1$.

Induction step $w'=k+1$. Take some successor $w''$ of $w'$. By definition of $R$ we have $w''<w'$. By the inductive hypothesis we know that $w''models p$. It follows that $w' models square p$, and again by $w R w'$ and $w models square (p arrow.l.r square p)$ we have that $w' models p$.

We conclude that every successor of $w$ (every $w'<w$) satisfies $p$, and thus $w models square p$ as desired.

- Case 2: $w = omega+n$ for some $n in NN$.

We first note that $w R v$ for any $v in NN$. It is easy to see that the induction constructed above can be extended to induction on $NN$, since in this case $w models square (p arrow.l.r square p)$ implies $p arrow.l.r square p$ holds at any $v in NN$. We thus focus our attention to successors of $w$ of the form $omega+m$.

We know that every $V(p)$ is either finite or cofinite, and since we have shown that $w models square(p arrow.r.l square p)$ implies that $v models p$ for any $v in NN$, we know that in this case $V(p)$ is cofinite. This allows us to conclude the existence of some $n in NN$ with $n > m$ such that $u >= omega + n arrow.r.double u models p$. We now show by induction on $ell$ that also $omega + n - ell models p$ for $1<=ell<=n-m$.

Base: $ell = 1$

We assume that $omega + n models p$, and since $n>m$ we know that $omega + n models p arrow.l.r square p$, and thus $omega+n models square p$. By definition of $R$ we have that $(omega+n) R (omega+n-1)=(omega+n-ell)$. It follows that $omega+n-ell models p$.

IH: $omega+n-k models p$ for $k < n-m-1$ 

Induction step: $ell = k+1$

We know by the induction hypothesis that $omega + n - k models p$. Since we have that $k<k+1<n-m$ we know that $omega+m < omega+n-(k+1) < omega +n -k$ we know that both $(omega + m) R (omega+n-k)$ and $(omega+m) R (omega+n-(k+1))$. We can thus conclude that $omega+m-k models square p$. By definition of $R$ we know that $(omega + n-k) R (omega + n - (k+1))$. It follows that $omega + n - (k+1) models p$.

We have thus shown that $omega + t models p$ for $t>=m$. In particular, since we have $omega+m models p$, and by definition of $R$ we have $(omega+m) R (omega + m)$, we see that $omega + m models square p$ as desired.

We conclude that $frak(g) models box(p arrow.l.r box p)arrow box p$

== (b) Show that $"GL"^*$ is Kripke incomplete

To show that $glstar$ is incomplete (with respect to the class of frames $"Fr"(glstar)="Fr"(gl)$) is suffices to find a formula which is valid on this class of frames, but which is not a theorem of $glstar$. We propose the formula $phi := box(box p arrow p)arrow box p$. Since this formula is an axiom of $gl$, we know that it is valid on $"Fr"(gl)="Fr"(glstar)$.

Suppose that $phi in glstar$. We showed in part (a) that $frak(g) models box(box p arrow.l.r p)arrow box p$. This shows that $glstar$ is sound with respect to $frak(g)$ (page 193 of the modal logic book says that axiom validity is enough for soundness). Since we assumed that $phi in glstar$, it follows that $frak(g)models phi$. We now show that this is not the case.

Let $V$ be a valuation with $V(p)= W minus {omega}$. Let $MM=(W,R,V)$, we show that $MM,omega cancel(models) box(box p arrow p) arrow box p$. We show that $MM,omega models box(box p arrow p)$. Take some successor $v$ of $omega$. If $v eq.not omega$ then $v models p$, so $v models box p arrow p$. If $v = omega$, then we have $v cancel(models) box p$, so $v models box p arrow p$. It thus holds that $MM, omega models box(box p arrow p)$. However since $omega R omega$, we do not have $omega models box p$. It follows that $omega cancel(models) box(box p arrow p) arrow box p$. This formula is thus not valid on $MM$.

This is a contradiction, and thus it follows that $phi cancel(in) glstar$. Since we have found a formula which is valid on $"Fr"(glstar)$, but which is not a theorem of $glstar$, we have shown that $glstar$ is kripke incomplete as desired.

// For question b: we want to find a formula which is valid on those frames but not provable in $"GL"^*$. We let that formula be $square(square p arrow p)arrow square p$. Assume that it was provable in $G L star$. We showed in tutorial 8 that if $L=K + Sigma$ then $"Fr"(L)="Fr"(Sigma)$. In this case we have the class of frames $frak g$ which are clearly a subset of $"Fr"Sigma$ (Where sigma is the formula they have us with the bi-implication). it follows that every frame in $frak(g)$ is a frame of the logic $G L star$. Now it would be the case that the formula of $G L$ (i.e. without biimplication) should also be valid on every frame in $frak(g)$.

// This isn't the case: take the valueation where every point p holds except for at $omega$. Then the formula doesn't hold at omega.