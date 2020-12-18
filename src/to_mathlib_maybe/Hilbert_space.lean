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