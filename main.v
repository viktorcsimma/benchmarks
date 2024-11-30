Require Coq.extraction.Extraction.
Extraction Language OCaml.
Set Extraction Output Directory ".".

Definition the (A : Set)(x : A) := x.

Definition Eq {A : Set}(x y : A) := forall (P : A -> Set), P x -> P y.
Definition refl {A : Set}{x:A} : Eq x x := fun P px => px.

(* -- Naturals *)
(* -------------------------------------------------------------------------------- *)

Definition CNat : Set -> Set := fun N => (N -> N) -> N -> N.

Definition cNatToNat : CNat nat -> nat := fun n => n S 0.

Definition add {A : Set} : CNat A -> CNat A -> CNat A := fun a b s z => a s (b s z).
Definition mul {A : Set} : CNat A -> CNat A -> CNat A := fun a b s z => a (b s) z.
Definition suc {A : Set} : CNat A -> CNat A := fun a s z => s (a s z).
Definition n2 {A : Set} : CNat A := fun s z => s (s z).
Definition n3 {A : Set} : CNat A := fun s z => s (s (s z)).
Definition n4 {A : Set} : CNat A := fun s z => s (s (s (s z))).
Definition n5 {A : Set} : CNat A := fun s z => s (s (s (s (s z)))).
Definition n10 {A : Set} : CNat A := mul n2 n5.
Definition n10b {A : Set} : CNat A := mul n5 n2.
Definition n15 {A : Set} : CNat A := add n10  n5.
Definition n15b {A : Set} : CNat A := add n10b n5.
Definition n18 {A : Set} : CNat A := add n15  n3.
Definition n18b {A : Set} : CNat A := add n15b n3.
Definition n19 {A : Set} : CNat A := add n15  n4.
Definition n19b {A : Set} : CNat A := add n15b n4.
Definition n20 {A : Set} : CNat A := mul n2 n10.
Definition n20b {A : Set} : CNat A := mul n2 n10b.
Definition n21 {A : Set} : CNat A := suc n20.
Definition n21b {A : Set} : CNat A := suc n20b.
Definition n22 {A : Set} : CNat A := suc n21.
Definition n22b {A : Set} : CNat A := suc n21b.
Definition n23 {A : Set} : CNat A := suc n22.
Definition n23b {A : Set} : CNat A := suc n22b.
Definition n100 {A : Set} : CNat A := mul n10   n10.
Definition n100b {A : Set} : CNat A := mul n10b  n10b.
Definition n10k {A : Set} : CNat A := mul n100  n100.
Definition n10kb {A : Set} : CNat A := mul n100b n100b.
Definition n100k {A : Set} : CNat A := mul n10k  n10.
Definition n100kb {A : Set} : CNat A := mul n10kb n10b.
Definition n1M {A : Set} : CNat A := mul n10k  n100.
Definition n1Mb {A : Set} : CNat A := mul n10kb n100b.
Definition n5M {A : Set} : CNat A := mul n1M   n5.
Definition n5Mb {A : Set} : CNat A := mul n1Mb  n5.
Definition n10M {A : Set} : CNat A := mul n5M   n2.
Definition n10Mb {A : Set} : CNat A := mul n5Mb  n2.

(* I add these myself for runtime tests *)
Definition n100M {A : Set} : CNat A := mul n10M n10.
Definition n500M {A : Set} : CNat A := mul n5M n100.
Definition n1G   {A : Set} : CNat A := mul n10M n100.

(* -- Trees *)
(* -------------------------------------------------------------------------------- *)

Definition CBool (B : Set) := B -> B -> B.
Definition ctrue {B : Set} : CBool B := fun t f => t.
Definition cand {B : Set}  : CBool B -> CBool B -> CBool B := fun a b t f => a (b t f) f.

Definition cBoolToBool : CBool bool -> bool := fun cb => cb true false.

Definition Tree : Set -> Set := fun T => (T -> T -> T) -> T -> T.
Definition leaf {A : Set} : Tree A := fun n l => l.
Definition node {A : Set} (t1 t2 : Tree A) : Tree A := fun n l => n (t1 n l) (t2 n l).
Definition fullTree {A : Set} (n : CNat (Tree A)) : Tree A := n (fun t => node t t) leaf.

Definition fullTree2 {A : Set} (n : CNat (Tree A)) : Tree A := n (fun t => node t (node t leaf)) leaf.

(* full tree with given trees at bottom level *)
Definition fullTreeWithLeaf {A : Set} : Tree A -> CNat (Tree A) -> Tree A
 := fun bottom n => n (fun t => node t t) bottom.

Definition forceTree {A : Set} : Tree (CBool A) -> CBool A := fun t => t cand ctrue.

Definition t15 {A : Set} : Tree A  := fullTree n15.
Definition t15b {A : Set} : Tree A := fullTree n15b.
Definition t18 {A : Set} : Tree A  := fullTree n18.
Definition t18b {A : Set} : Tree A := fullTree n18b.
Definition t19 {A : Set} : Tree A  := fullTree n19.
Definition t19b {A : Set} : Tree A := fullTree n19b.
Definition t20 {A : Set} : Tree A  := fullTree n20.
Definition t20b {A : Set} : Tree A := fullTree n20b.
Definition t21 {A : Set} : Tree A  := fullTree n21.
Definition t21b {A : Set} : Tree A := fullTree n21b.
Definition t22 {A : Set} : Tree A  := fullTree n22.
Definition t22b {A : Set} : Tree A := fullTree n22b.
Definition t23 {A : Set} : Tree A  := fullTree n23.
Definition t23b {A : Set} : Tree A := fullTree n23b.

(* -- Nat conversion *)
(* -------------------------------------------------------------------------------- *)


(* Definition convnat1M  {A : Set} : Eq (n1M  (A:=A))   n1Mb  := refl. *)
(* Definition convnat5M  {A : Set} : Eq (n5M  (A:=A))   n5Mb  := refl. *)
(* Definition convnat10M {A : Set} : Eq (n10M (A:=A))  n10Mb  := refl. *)

(* -- Full tree conversion *)
(* -------------------------------------------------------------------------------- *)

(* Definition convt15 {A : Set}  : Eq (t15 (A:=A)) t15b  := refl. *)
(* Definition convt18 {A : Set}  : Eq (t18 (A:=A)) t18b  := refl. *)
(* Definition convt19 {A : Set}  : Eq (t19 (A:=A)) t19b  := refl. *)
(* Definition convt20 {A : Set}  : Eq (t20 (A:=A)) t20b  := refl. *)
(* Definition convt21 {A : Set}  : Eq (t21 (A:=A)) t21b  := refl. *)
(* Definition convt22 {A : Set}  : Eq (t22 (A:=A)) t22b  := refl. *)
(* Definition convt23 {A : Set}  : Eq (t23 (A:=A)) t23b  := refl. *)

(* -- Full tree forcing *)
(* -------------------------------------------------------------------------------- *)

(*
Here, the lines starting with "Goal"
are about normalising a tree;
which is impossible in Agda
because there is no way to only force the normal forms
without doing printing or conversion checking.
So, we are only actually interested in the cBoolToBool ones.
(The cognate for those are evaluating in --interactive mode in Agda.)
*)

(* Eval vm_compute in cBoolToBool (forceTree (t15 (A:=CBool bool))). *)
(* Eval vm_compute in cBoolToBool (forceTree (t18 (A:=CBool bool))). *)
(* Eval vm_compute in cBoolToBool (forceTree (t19 (A:=CBool bool))). *)
(* Eval vm_compute in cBoolToBool (forceTree (t20 (A:=CBool bool))). *)
(* Eval vm_compute in cBoolToBool (forceTree (t21 (A:=CBool bool))). *)
(* Eval vm_compute in cBoolToBool (forceTree (t22 (A:=CBool bool))). *)
(* Eval vm_compute in cBoolToBool (forceTree (t23 (A:=CBool bool))). *)
(* Goal True. let x := eval vm_compute in (t15 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval vm_compute in (t18 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval vm_compute in (t19 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval vm_compute in (t20 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval vm_compute in (t21 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval vm_compute in (t22 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval vm_compute in (t23 (A:=CBool bool)) in idtac. Abort. *)
(* Eval compute in cBoolToBool (forceTree (t15 (A:=CBool bool))). *)
(* Eval compute in cBoolToBool (forceTree (t18 (A:=CBool bool))). *)
(* Eval compute in cBoolToBool (forceTree (t19 (A:=CBool bool))). *)
(* Eval compute in cBoolToBool (forceTree (t20 (A:=CBool bool))). *)
(* Eval compute in cBoolToBool (forceTree (t21 (A:=CBool bool))). *)
(* Eval compute in cBoolToBool (forceTree (t22 (A:=CBool bool))). *)
(* Eval compute in cBoolToBool (forceTree (t23 (A:=CBool bool))). *)
(* Goal True. let x := eval compute in (t15 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval compute in (t18 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval compute in (t19 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval compute in (t20 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval compute in (t21 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval compute in (t22 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval compute in (t23 (A:=CBool bool)) in idtac. Abort. *)
(* Eval lazy in cBoolToBool (forceTree (t15 (A:=CBool bool))). *)
(* Eval lazy in cBoolToBool (forceTree (t18 (A:=CBool bool))). *)
(* Eval lazy in cBoolToBool (forceTree (t19 (A:=CBool bool))). *)
(* Eval lazy in cBoolToBool (forceTree (t20 (A:=CBool bool))). *)
(* Eval lazy in cBoolToBool (forceTree (t21 (A:=CBool bool))). *)
(* Eval lazy in cBoolToBool (forceTree (t22 (A:=CBool bool))). *)
(* Eval lazy in cBoolToBool (forceTree (t23 (A:=CBool bool))). *)
(* Goal True. let x := eval lazy in (t15 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval lazy in (t18 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval lazy in (t19 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval lazy in (t20 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval lazy in (t21 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval lazy in (t22 (A:=CBool bool)) in idtac. Abort. *)
(* Goal True. let x := eval lazy in (t23 (A:=CBool bool)) in idtac. Abort. *)

(* -- Compiled nat evaluation *)
(* -------------------------------------------------------------------------------- *)

(*
Definition natToPrint : nat := cNatToNat n1G.


Extract Inductive nat => "int"
  [ "0" "(fun x -> x + 1)" ]
  "(fun zero succ n -> if n=0 then zero () else succ (n-1))".

Extraction "main.ml" natToPrint.
*)

(* For this to work, you have to append "let () -> print_int natToPrint" at the end of the OCaml code *)
(* and run "ocamlc main.ml" for compilation. *)

(* -- Compiled full tree evaluation *)
(* -------------------------------------------------------------------------------- *)

(*
Definition boolToPrint : bool := cBoolToBool (forceTree t23).

Extract Inductive bool => "bool" [ "true" "false" ].
Extraction "main.ml" boolToPrint.
*)

