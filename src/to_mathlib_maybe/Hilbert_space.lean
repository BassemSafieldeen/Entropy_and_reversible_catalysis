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