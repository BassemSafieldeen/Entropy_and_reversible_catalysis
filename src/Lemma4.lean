import to_mathlib_maybe.Hilbert_space
import entropy
import state

notation `D(`ρ`,`σ`)` := 1/2 * ∥ρ - σ∥₁
notation ρ`^⊗`n := tpow ρ n

variables {ℋ : Type} [complex_hilbert_space ℋ]
{ρ ρ' : module.End ℂ ℋ} [quantum_state ρ]
[H(ρ) ≤ H(ρ')]

def dephasing_channel_in_eigenbasis (ρ : quantum_state) : quantum_channel := sorry

notation `𝒟` := dephasing_channel_in_eigenbasis ρ

lemma basic_lemma : 
∀ ε > 0, ∃ (n : ℕ), ∃ (U : module.End ℂ ℋ) [unitary U], ∀ k ≤ n,
D(ρ', 𝒟(pTr_{1,..,n}\{k} (U * ρ^⊗n * U†))) ≤ ε := 
begin
  sorry
end