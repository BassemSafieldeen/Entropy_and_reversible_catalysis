import ring_theory.tensor_product

import to_mathlib_maybe.Hilbert_space

---- PARTIAL TRACES

open algebra.tensor_product

open_locale tensor_product

noncomputable theory

variables 
{ℋ₁ : Type} [complex_hilbert_space ℋ₁] 
{ℋ₂ : Type} [complex_hilbert_space ℋ₂]
{ℋ₃ : Type} [complex_hilbert_space ℋ₃]

namespace bipartite

def Tr₁ (ρ : (ℋ₁ →ₗ[ℂ] ℋ₁) ⊗[ℂ] (ℋ₂ →ₗ[ℂ] ℋ₂)) : ℋ₂ →ₗ[ℂ] ℋ₂ := 
sorry

def Tr₂ (ρ : (ℋ₁ →ₗ[ℂ] ℋ₁) ⊗[ℂ] (ℋ₂ →ₗ[ℂ] ℋ₂)) : ℋ₁ →ₗ[ℂ] ℋ₁ := 
sorry

end bipartite

namespace tripartite

def Tr₁ (ρ : (ℋ₁ →ₗ[ℂ] ℋ₁) ⊗[ℂ] (ℋ₂ →ₗ[ℂ] ℋ₂) ⊗[ℂ] (ℋ₃ →ₗ[ℂ] ℋ₃)) : (ℋ₂ →ₗ[ℂ] ℋ₂) ⊗[ℂ] (ℋ₃ →ₗ[ℂ] ℋ₃) := 
sorry

def Tr₂ (ρ : (ℋ₁ →ₗ[ℂ] ℋ₁) ⊗[ℂ] (ℋ₂ →ₗ[ℂ] ℋ₂) ⊗[ℂ] (ℋ₃ →ₗ[ℂ] ℋ₃)) : (ℋ₁ →ₗ[ℂ] ℋ₁) ⊗[ℂ] (ℋ₃ →ₗ[ℂ] ℋ₃) := 
sorry

def Tr₃ (ρ : (ℋ₁ →ₗ[ℂ] ℋ₁) ⊗[ℂ] (ℋ₂ →ₗ[ℂ] ℋ₂) ⊗[ℂ] (ℋ₃ →ₗ[ℂ] ℋ₃)) : (ℋ₁ →ₗ[ℂ] ℋ₁) ⊗[ℂ] (ℋ₂ →ₗ[ℂ] ℋ₂) := 
sorry

def Tr₁₂ (ρ : (ℋ₁ →ₗ[ℂ] ℋ₁) ⊗[ℂ] (ℋ₂ →ₗ[ℂ] ℋ₂) ⊗[ℂ] (ℋ₃ →ₗ[ℂ] ℋ₃)) : ℋ₃ →ₗ[ℂ] ℋ₃ := 
sorry

def Tr₁₃ (ρ : (ℋ₁ →ₗ[ℂ] ℋ₁) ⊗[ℂ] (ℋ₂ →ₗ[ℂ] ℋ₂) ⊗[ℂ] (ℋ₃ →ₗ[ℂ] ℋ₃)) : ℋ₂ →ₗ[ℂ] ℋ₂ := 
sorry

def Tr₂₃ (ρ : (ℋ₁ →ₗ[ℂ] ℋ₁) ⊗[ℂ] (ℋ₂ →ₗ[ℂ] ℋ₂) ⊗[ℂ] (ℋ₃ →ₗ[ℂ] ℋ₃)) : ℋ₁ →ₗ[ℂ] ℋ₁ := 
sorry

end tripartite

variables (ρ : ℋ₁ →ₗ[ℂ] ℋ₁)
(σ : ℋ₂ →ₗ[ℂ] ℋ₂)

local notation ρ ` ⊗ ` σ := ρ ⊗ₜ[ℂ] σ

namespace bipartite

theorem Tr₁_tmul : Tr₁(ρ ⊗ σ) = σ := sorry

theorem Tr₂_tmul : Tr₂(ρ ⊗ σ) = ρ := sorry

end bipartite

variables (τ : ℋ₃ →ₗ[ℂ] ℋ₃)

namespace tripartite

theorem Tr₁_tmul_tmul : Tr₁((ρ ⊗ σ) ⊗ τ) = σ ⊗ τ := sorry

theorem Tr₂_tmul_tmul : Tr₂((ρ ⊗ σ) ⊗ τ) = ρ ⊗ τ := sorry

theorem Tr₃_tmul_tmul : Tr₃((ρ ⊗ σ) ⊗ τ) = ρ ⊗ σ := sorry

theorem Tr₁₂_tmul_tmul : Tr₁₂((ρ ⊗ σ) ⊗ τ) = τ := sorry

theorem Tr₁₃_tmul_tmul : Tr₁₃((ρ ⊗ σ) ⊗ τ) = σ := sorry

theorem Tr₂₃_tmul_tmul : Tr₂₃((ρ ⊗ σ) ⊗ τ) = ρ := sorry

end tripartite

---- USAGE

open bipartite tripartite

example : Tr₂(ρ ⊗ σ) = ρ := 
begin
    apply Tr₂_tmul,
end

example : Tr₂((ρ ⊗ σ) ⊗ τ) = ρ ⊗ τ := 
begin
    apply Tr₂_tmul_tmul,
end