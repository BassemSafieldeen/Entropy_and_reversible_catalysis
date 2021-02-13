import linear_algebra.eigenspace

import to_mathlib_maybe.Hilbert_space

open_locale tensor_product big_operators

variables {ℋ : Type} [complex_hilbert_space ℋ]

/--
A quantum state is a linear map from a Hilbert space to itself -- 
a.k.a., a linear operator, a.k.a, a module endomorphism -- with trace one and 
only non-negative eigenvalues.

Definition 4.1.3 here (https://arxiv.org/pdf/1106.1445.pdf).
-/
class quantum_state (ρ : module.End ℂ ℋ) :=
(trace_one : Tr ρ = 1)
(pos_semidef : ∀ e, ρ.has_eigenvalue e → (e.im = 0) ∧ (e.re ≥ 0))
-- Alternatively, we could define this more abstractly
-- (hermitian : ∀ x y : ℋ, inner x (ρ y) = inner (ρ x) y)
-- (pos_semidef : ∀ x : ℋ, inner x (ρ x) ≥ 0)

/--
The list of eigenvalues of a quantum state.
-/
def spectrum (ρ : module.End ℂ ℋ) [quantum_state ρ] : list ℝ := sorry

/--
Trace distance
-/
def trace_distance (ρ : module.End ℂ ℋ) (σ : module.End ℂ ℋ) : ℝ :=  1/2 * ∑ e ∈ spectrum (ρ-σ), abs e

notation `D(`ρ`,`σ`)` := trace_distance ρ σ

universe x

variables 
{ι : Type x} -- indexing type
[fintype ι] -- tell Lean that the set of all elements ι is finite.
(ρ : module.End ℂ ℋ)
{e : ι → ℂ} [∀ i, ρ.has_eigenvalue (e i)]

/--
If a linear operator has trace one then its eigenvalues sum to 1.
-/
lemma sum_eigenvalues_eq_one_of_trace_one : 
Tr ρ = 1 → ∑ i, e i = 1 := 
begin
    sorry
end