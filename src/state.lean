import linear_algebra.eigenspace

import to_mathlib_maybe.Hilbert_space

open_locale tensor_product big_operators

variables {ℋ : Type} [complex_hilbert_space ℋ]

/--
A quantum state is a linear map from a Hilbert space to itself -- 
a.k.a., a linear operator, a.k.a, a module endomorphism -- with trace one and 
only non-negative eigenvalues.
-/
class quantum_state (ρ : module.End ℂ ℋ) :=
(trace_one : Tr ρ = 1)
-- current definition says all real eigenvalues of ρ are positive, but positive semidefiniteness is stronger: all eigenvalues are real AND positive
-- (pos_semidef : ∀ e : ℂ, ρ.has_eigenvalue e → (e ∈ ℝ) ∧ (e > 0))
(pos_semidef : ∀ e : ℝ, ρ.has_eigenvalue e → e ≥ 0)

-- I want to declare quamtum states without the wordy `ρ : module.End ℂ H [quantum_state ρ]` but I'm not sure this is the right type definition
abbreviation State (ℋ : Type) [complex_hilbert_space ℋ] := ∀ ρ : module.End ℂ ℋ, quantum_state ρ

universe x

variables 
{ι : Type x} -- indexing type
[fintype ι] -- tell Lean that the set of all elements ι is finite.

/--
If a linear operator has trace one then its eigenvalues sum to 1.
-/
lemma sum_eigenvalues_eq_one_of_trace_one (ρ : module.End ℂ ℋ) 
{e : ι → ℝ} {he : ∀ i, ρ.has_eigenvalue (e i)}: 
(Tr ρ = 1) → (∑ i, e i = 1) := 
begin
    sorry
end