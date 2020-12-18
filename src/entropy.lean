import linear_algebra.eigenspace
import linear_algebra.tensor_product
import rnd_var
import shannon_theory
import state

import to_mathlib_maybe.Hilbert_space

---- QUANTUM ENTROPY

open rnd_var

open_locale tensor_product big_operators

noncomputable theory

variables 
{ℋ : Type} [complex_hilbert_space ℋ]
{ℋ₁ : Type} [complex_hilbert_space ℋ₁]
{ℋ₂ : Type} [complex_hilbert_space ℋ₂]

universe x

variables 
{ι : Type x} -- indexing type
[fintype ι] -- tell Lean that the set of all elements ι is finite.

/-
Logarithm of a linear operator.
-/
def log (ρ : ℋ →ₗ[ℂ] ℋ) : ℋ →ₗ[ℂ] ℋ := sorry

local notation A ` ∘ ` B := linear_map.comp A B

def entropy (ρ : module.End ℂ ℋ) : ℝ := 
( Tr ( ρ ∘ (log ρ) ) ).re

<<<<<<< HEAD
abbreviation H (ρ : module.End ℂ ℋ) : ℝ := entropy ρ
=======
notation `H(`ρ`)` := entropy(ρ)
>>>>>>> 19baf0b59033c09f8d526ba4bfddad52e5bb102a

/--
Quantum entropy is nonnegative
-/
theorem entropy_nonneg  {ρ : module.End ℂ ℋ}
{e : ι → ℝ} [decidable_eq ι] {he : ∀ i, ρ.has_eigenvalue (e i)} [quantum_state ρ] : 
entropy ρ ≥ 0 := 
begin
    have : entropy ρ = - ∑ i, (e i) * real.log(e i), {sorry},
    rw this,
    clear this,
    -- All the eignevalues are nonnegative because the state is positive semidefinite
    have he_nonneg : ∀ i, (e i) ≥ 0, {
        intros,
        apply quantum_state.pos_semidef (e i),
        exact he i,
        assumption,
    },
    -- The eigenvalues sum to 1 because the state has trace 1.
    have he_sum_eq_one : ∑ i, (e i) = 1, {
        apply sum_eigenvalues_eq_one_of_trace_one ρ quantum_state.trace_one,
        apply he,
    },
    -- The remaining term looks like Shannon entropy. 
    -- So we use that Shannon entropy is nonegative to finish.
    sorry,
    -- apply Shannon_entropy_nonneg, simp,
    -- {exact he_nonneg},
    -- {exact he_sum_eq_one},
end