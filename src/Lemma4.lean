notation `H(`ρ`)` := entropy(ρ)
notation `D(`ρ`,`σ`)` := 1/2 * ∥ρ - σ∥₁
notation ρ`^⊗`n := tpow ρ n

variables {ℋ : Type} [complex_hilbert_space ℋ]
{ρ ρ' : (ℋ →ₗ[ℂ] ℋ) →ₗ[ℂ] (ℋ →ₗ[ℂ] ℋ)} [quantum_state ρ]
{hρ : H(ρ) < H(ρ')}

def dephasing_channel_in_eigenbasis (ρ : quantum_state) : quantum_channel := sorry

notation `𝒟` := dephasing_channel_in_eigenbasis ρ

lemma basic_lemma : 
∀ ε > 0, ∃ (n : ℕ), ∃ [unitary U], ∀ k ≤ n,
D(ρ', 𝒟(pTr_{1,..,n}\{k} (U * ρ^⊗n * U†))) ≤ ε := 
begin
  sorry
end