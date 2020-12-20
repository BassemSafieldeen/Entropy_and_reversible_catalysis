import linear_algebra.eigenspace
import linear_algebra.tensor_product
import rnd_var
import shannon_theory
import state

import to_mathlib_maybe.Hilbert_space
import to_mathlib_maybe.pTrace

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

notation `H(`ρ`)` := entropy(ρ)

variables {ρ : module.End ℂ ℋ} [quantum_state ρ]

/-
The range of e is the set of eigenvalues of ρ.
-/
variables {e : ι → ℝ} [decidable_eq ι] [∀ r : ℝ, (∃ i, e i = r) ↔ (ρ.has_eigenvalue r)]
include e -- there is an error without this, I don't know why.

/--
Quantum entropy is nonnegative
-/
theorem entropy_nonneg : entropy ρ ≥ 0 := 
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

variables {U : module.End ℂ ℋ} [unitary U]

local notation U`†`:100 := dagger_of_unitary U

/--
Entropy is invariant under unitaries:
-/
lemma entropy_unitary_evolution_eq_entropy_self : 
H(U ∘ ρ ∘ U†) = H(ρ) := sorry

variables 
{ρ₁ : module.End ℂ ℋ₁} [quantum_state ρ₁]
{ρ₂ : module.End ℂ ℋ₂} [quantum_state ρ₂]

/--
Entropy of tensor product of states is equal to the sum of the entropies:
-/
lemma entropy_tmul_eq_add_entropy : 
H(ρ₁ ⊗ ρ₂) = H(ρ₁) + H(ρ₂) := sorry

variables
{ρ₁₂ : (module.End ℂ (ℋ₁ ⊗[ℂ] ℋ₂))} [quantum_state ρ₁₂]

open bipartite
/--
Entropy is subadditive:
-/
lemma entropy_subadditive : 
H(ρ₁₂) ≤ H(Tr₂(ρ₁₂)) + H(Tr₁(ρ₁₂)) := sorry