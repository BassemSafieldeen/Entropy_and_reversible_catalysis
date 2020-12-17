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

/--
A unitary is a linear map U : H → H such that U†  = U⁻¹
-/
class unitary (U : module.End ℂ ℋ) :=
(unitarity : 1=1)

-- I want to declare unitaries without the wordy `U : module.End ℂ H [unitary ρ]` but I'm not sure this is the right type definition
abbreviation Unit (ℋ : Type) [complex_hilbert_space ℋ] := ∀ U : module.End ℂ ℋ, unitary U

-- TODO it's not clear to me that module.End ℂ H has inverses, so how could we define unitarity then?
-- it should have inverses because it's called `endomorphism`, but since it's defined with more generality than linear maps (it's defined over any semimodule) then anything goes
-- an example of a semimodule is (ℕ, multiset) and it's clear that no morphism is invertible there except the identity