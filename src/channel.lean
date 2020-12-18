import to_mathlib_maybe.Hilbert_space
import state

variables
{ℋ : Type} [complex_hilbert_space ℋ]
{ℋ₁ : Type} [complex_hilbert_space ℋ₁]
{ℋ₂ : Type} [complex_hilbert_space ℋ₂]
{U : module.End ℂ ℋ} [unitary U]
{ρ : module.End ℂ ℋ} [quantum_state ρ]

/--
Unitary evolution of a quantum state
-/
def evolve (U : module.End ℂ ℋ) (ρ : module.End ℂ ℋ) : module.End ℂ ℋ := U ∘ ρ ∘ U†

/--
A quantum channel is a linear map between linear operators 
that satisifies certain axioms.
-/
class quantum_channel (𝒩 : (module.End ℂ ℋ₁) →ₗ[ℂ] (module.End ℂ ℋ₂)) := 
(quantum_channel_ness : 1=1)

variables
{𝒩 : (module.End ℂ ℋ₁) →ₗ[ℂ] (module.End ℂ ℋ₂)} [quantum_channel 𝒩]
{σ σ' : (ℋ₁ →ₗ[ℂ] ℋ₁)} [quantum_state ρ] [quantum_state σ]

example : 𝒩(σ + σ') = 𝒩(σ) + 𝒩(σ') := 
begin
    rw linear_map.map_add,
end