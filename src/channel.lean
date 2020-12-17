import state

variables 
{ℋ₁ : Type} [complex_hilbert_space ℋ₁]
{ℋ₂ : Type} [complex_hilbert_space ℋ₂]

/--
A quantum channel is a linear map between linear operators 
that satisifies certain axioms.
-/
class quantum_channel (𝒩 : (module.End ℂ ℋ₁) →ₗ[ℂ] (module.End ℂ ℋ₂)) := 
(quantum_channel_ness : 1=1)

variables
{𝒩 : (module.End ℂ ℋ₁) →ₗ[ℂ] (module.End ℂ ℋ₂)} [quantum_channel 𝒩]
{ρ σ : (ℋ₁ →ₗ[ℂ] ℋ₁)} [quantum_state ρ] [quantum_state σ]

example : 𝒩(ρ + σ) = 𝒩(ρ) + 𝒩(σ) := 
begin
    rw linear_map.map_add,
end