import analysis.normed_space.inner_product

/--
Hilbert space
-/
class complex_hilbert_space (V : Type) extends inner_product_space ℂ V :=
(hilbert_ness: 1=1)

variables {ℋ : Type} [complex_hilbert_space ℋ]

/--
The Trace of a linear map on a complex Hilbert space.
-/
noncomputable def Tr := linear_map.trace ℂ ℋ

/--
Adjoint of a linear map
-/
def is_adjoint_pair (A A' : module.End ℂ ℋ) := ∀ x y, inner x (A y) = inner (A' x) y -- assumes A is bounded

/--
Conjugate of a linear map
-/
def is_conjugate_pair (A A' : module.End ℂ ℋ) := ∀ x y, inner x (A y) = complex.conj (inner x (A y))

/--
Conjugate adjoint of a linear map
-/
def is_dagger_pair (A A' : module.End ℂ ℋ) := ∀ x y, inner x (A y) = complex.conj (inner (A' x) y)

notation U`†` := sorry -- conjugate transpose of U

/--
A unitary is a linear map U : H → H such that U†  = U⁻¹
-/
class unitary (U : module.End ℂ ℋ) :=
(unitarity : U ∘ U† = λ x : ℋ, x)

/--
Unitary maps over a Hilbert space ℋ form a group
-/
def unitary_group (ℋ) [complex_hilbert_space ℋ] := { U : module.End ℂ ℋ // U ∘ U† = λ x : ℋ, x }
(unitarity : 1=1)

/--
dagger_of_unitary is a function that takes a module endomorphism that satisfies 
the unitarity axioms and returns another module endomorphism.
-/
def dagger_of_unitary (U : module.End ℂ ℋ) [unitary U] : module.End ℂ ℋ := sorry

-- notation U`†` := U -- sorry -- conjugate transpose U
notation U`†`:100 := dagger_of_unitary U -- 100 tells Lean that † should be applied with high priority, e.g. before the composition operator ∘.

-- I want to declare unitaries without the wordy `U : module.End ℂ H [unitary ρ]` but I'm not sure this is the right type definition
abbreviation Unit (ℋ : Type) [complex_hilbert_space ℋ] := ∀ U : module.End ℂ ℋ, unitary U

-- TODO it's not clear to me that module.End ℂ H has inverses, so how could we define unitarity then?
-- it should have inverses because it's called `endomorphism`, but since it's defined with more generality than linear maps (it's defined over any semimodule) then anything goes
-- an example of a semimodule is (ℕ, multiset) and it's clear that no morphism is invertible there except the identity

variables {U : module.End ℂ ℋ} [unitary U]

lemma dag_comp_self_eq_one : U† ∘ U = (1 : module.End ℂ ℋ) := sorry
