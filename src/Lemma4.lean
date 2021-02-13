import to_mathlib_maybe.Hilbert_space
import entropy
import state

import Lemma3

notation `D(`ρ`,`σ`)` := 1/2 * ∥ρ - σ∥₁
notation ρ`^⊗`n := tpow ρ n

variables {ℋ : Type} [complex_hilbert_space ℋ]
{ρ ρ' : module.End ℂ ℋ} [quantum_state ρ]
[H(ρ) ≤ H(ρ')]

def dephasing_channel_in_eigenbasis (ρ : module.End ℂ ℋ) [quantum_state ρ] : quantum_channel := sorry

notation `𝒟 ` ρ := dephasing_channel_in_eigenbasis ρ

/--
"The next Lemma will be essential to construct a candidate
catalyst by making use of Lemma 3. It is based on the Schur-Horn 
theorem, which states that for any d×d Hermitian matrix its vector 
of eigenvalues λ majorizes the vector of diagonal elements in every 
orthonormal basis. Conversely, every vector that is majorized by λ 
may be obtained as the diagonal elements in a suitable orthonormal 
basis."
-/
lemma basic_lemma : 
∀ ε > 0, ∃ (n : ℕ), ∃ (U : module.End ℂ ℋ) [unitary U], ∀ k ≤ n,
D(ρ', 𝒟(pTr_{1,..,n}\{k} (U * ρ^⊗n * U†))) ≤ ε := 
begin
  sorry
end