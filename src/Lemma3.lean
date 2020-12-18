import algebra.big_operators
import to_mathlib_maybe.Hilbert_space
import to_mathlib_maybe.pTrace
import entropy
import state
import .channel
import rnd_var

open_locale big_operators

variables
{ι : Type} [fintype ι] [decidable_eq ι]
{ℋ : Type} [complex_hilbert_space ℋ]
{ρ ρ' : ℋ →ₗ[ℂ] ℋ} [quantum_state ρ] [quantum_state ρ']
{hρ : H(ρ) < H(ρ')}

notation `D(`ρ`,`σ`)` := 1/2 * ∑ e ∈ spectrum (ρ-σ), abs e
notation ρ`^⊗`n := gpow ρ n

def majorizes (ρ : ℋ →ₗ[ℂ] ℋ) (ρ' : ℋ →ₗ[ℂ] ℋ) :=
∃ (q : ι → ℝ) (V : ι → module.End ℂ ℋ), ∀ i, unitary (V i) → ρ' = ∑ i, (q i) • (evolve (V i) ρ)

notation ρ `≽` ρ' := majorizes ρ ρ'

lemma typicality_and_majorization : 
∀ ε > 0, ∃ n, ∃ τ : module.End ℋ [quantum_state τ], -- not sure we can put this constraint here
ρ^⊗n ≽ τ
∧
D(ρ^⊗n, τ) ≤ ε :=
begin
  sorry
end