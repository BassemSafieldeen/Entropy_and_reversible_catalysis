import linear_algebra.eigenspace

import to_mathlib_maybe.Hilbert_space
import to_mathlib_maybe.pTrace

import to_qShannon_theory_maybe.state
import to_qShannon_theory_maybe.entropy

open_locale tensor_product big_operators

notation `Trₑ ` ρ := bipartite.Tr₂ ρ

variables
{ℋₛ : Type} [complex_hilbert_space ℋₛ]
{ℋₑ : Type} [complex_hilbert_space ℋₑ]
{ℋₛₑ : Type} [complex_hilbert_space ℋₛₑ]
-- talk about relation between ℋₛₑ and the other two
-- to make progress with the error below (no guarantees).

/-
The people said: Hey, suppose you have two quantum states.
-/

variables 
(ρₛ : module.End ℂ ℋₛ) [quantum_state ρₛ]
(ρₛ': module.End ℂ ℋₛ) [quantum_state ρₛ']

/-
Can we find a condition on the states
-/ 

def some_condition (ρₛ) (ρₛ') := sorry

/-
such that the theorem below is provable?
-/

example : 
some_condition ρₛ ρₛ'
↔
∃ (U : module.End ℂ ℋₛₑ) [unitary U], 
∃ (σₑ : module.End ℂ ℋₑ) [quantum_state σₑ],
U ∘ (ρₛ ⊗ σₑ) ∘ U† = ρₛ' ⊗ σₑ := 
begin
  sorry
end

/-
The paper says: I can prove something close.
-/

def condition := H(ρₛ) ≤ H(ρₛ') 

example : 
condition ρₛ ρₛ'
↔
∀ ε > 0,
∃ (U : module.End ℂ ℋₛₑ) [unitary U], 
∃ (σₑ : module.End ℂ ℋₑ) [quantum_state σₑ],
Trₛ (U ∘ (ρₛ ⊗ σₑ) ∘ U†) = σₑ 
∧
D(Trₑ (U ∘ (ρₛ ⊗ σₑ) ∘ U†), ρₛ') ≤ ε := 
begin
  sorry
end