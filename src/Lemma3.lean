notation `H(`ρ`)` := entropy(ρ)
notation `D(`ρ`,`σ`)` := 1/2 * ∥ρ - σ∥₁
notation ρ`^⊗`n := tpow ρ n

variables {ℋ : Type} [complex_hilbert_space ℋ]
{ρ ρ' : (ℋ →ₗ[ℂ] ℋ) →ₗ[ℂ] (ℋ →ₗ[ℂ] ℋ)} [quantum_state ρ]
{hρ : H(ρ) < H(ρ')}

lemma typicality_and_majorization : 
∀ ε > 0, ∃ n, ∃ [quantum_state τ], 
ρ^⊗n ≽ τ
∧
D(ρ^⊗n, τ) ≤ ε :=
begin
  sorry
end