import to_mathlib_maybe.Hilbert_space
import to_qShannon_theory_maybe.state

variables
{ℋ : Type} [complex_hilbert_space ℋ]
{ℋ₁ : Type} [complex_hilbert_space ℋ₁]
{ℋ₂ : Type} [complex_hilbert_space ℋ₂]
{U : module.End ℂ ℋ} [unitary U]
{ρ : module.End ℂ ℋ} [quantum_state ρ]

/--
A quantum channel is a linear map between linear operators 
that satisifies certain axioms.
-/
class quantum_channel (𝒩 : (module.End ℂ ℋ₁) →ₗ[ℂ] (module.End ℂ ℋ₂)) := 
(quantum_channel_ness : 1=1)

variables
{𝒩 : (module.End ℂ ℋ₁) →ₗ[ℂ] (module.End ℂ ℋ₂)} [quantum_channel 𝒩]
{σ σ' : (ℋ₁ →ₗ[ℂ] ℋ₁)} [quantum_state σ] [quantum_state σ']

example : 𝒩(σ + σ') = 𝒩(σ) + 𝒩(σ') := 
begin
    rw linear_map.map_add,
end

-- d×d matrix with 1 at (i j) and 0 otherwise
def E (i j d : ℕ) : module.End ℂ ℋ := sorry
-- cyclic shift operators
def shift (k n : ℕ) := ∑ i ∈ finset.range n, (E i (i+k)%n n)
-- shift by 1 on S1, ..., Sn
def cycle_s (d n : ℕ) := (Id d) ⊗ (shift 1 n) ⊗ (Id n)
-- shift by one on A
def cycle_ancilla (d n : ℕ) := 1^⊗n ⊗ (shift 1 n)
-- Dephasing channel sending χ to its diagonal in the eigenbasis of ρ'
def dephasing_channel (ρ') := λ ρ, ∑ v ∈ eigenvectors ρ', inner v (ρ v)
-- Unitary and ancilla on Naimark's dilated system corresponding to an arbitrary quantum channel
def naimark_unitary (C : module.End ℂ ℋ →ₗ[ℂ] module.End ℂ ℋ) [quantum_channel C] : module.End ℂ ℋ := sorry
def naimark_ancilla (C : module.End ℂ ℋ →ₗ[ℂ] module.End ℂ ℋ) [quantum_channel C] : module.End ℂ ℋ := sorry