def V := ∑ i, (V i) ⊗ |i⟩⟨i|

def σ := ∑ i, (p i) * |i⟩⟨i|

def C (ρ) = Tr₂ (V ∘ (ρ ⊗ σ) ∘ V†)

-- def C (ρ) : ∑ i, (p i) * (V i) ∘ ρ ∘ (V i)† -- double check this


lemma correlations_dont_propagate : 
Tr₁ ((V ⊗ 1) ρ_SS' ⊗ σ (V ⊗ 1)†) = ρ_S' ⊗ σ := 
begin
    -- nice, the proof is short.
    calc Tr₁ ((V ⊗ 1) ρ_SS' ⊗ σ (V ⊗ 1)†) = ∑ i, (p i) * Tr₁ ((V ⊗ 1) ρ_SS' (V ⊗ 1)†) ⊗ |i⟩⟨i| : by sorry,
... = ∑ i, (p i) * ρ_S' ⊗ |i⟩⟨i| : by sorry,
... = ρ_S' ⊗ σ : by sorry,
end