import rnd_var

import to_mathlib_maybe.Hilbert_space
import to_mathlib_maybe.pTrace
import state

variables
{ι : Type} [fintype ι] [decidable_eq ι]
{ℋ : Type} [complex_hilbert_space ℋ]
{ρ : module.End ℂ ℋ} [quantum_state ρ]
{n m d : ℕ} -- dim S, S' and R
{V : ι → unitary_group ℋ}
{p : ι → ℝ} [rnd_var p]

open_locale tensor_product big_operators

def E (i j : ι) : module.End ℂ ℋ := sorry -- d×d matrix with 1 at (i j) and 0 otherwise
notation `|`i`⟩⟨`j`|` := E i j

def V' := ∑ i : ι, (V i) ⊗ |i⟩⟨i|

def σ := ∑ i : ι, (p i) • |i⟩⟨i|

def C (ρ) := Tr₂(V' ∘ ρ ⊗ σ ∘ V†)
-- def C (ρ) : ∑ i, (p i) * (V i) ∘ ρ ∘ (V i)† -- double check this

-- TODO partial trace is undefined for entangled states

/--
"The final Lemma that we require provides a way to us to
get rid of unwanted coherences (arising from Lemma 4) in the
final state without correlating the catalyst internally (which
would spoil the catalyst"
-/
lemma correlations_dont_propagate : 
Tr₁ ((V ⊗ 1) ∘ ρ ⊗ σ ∘ (V ⊗ 1)†) = Tr₁(ρ) ⊗ σ := 
begin
    -- nice, the proof is short.
    calc _
         ... = ∑ i, (p i) * Tr₁ ((V ⊗ 1) ∘ ρ_SS' ∘ (V ⊗ 1)†) ⊗ |i⟩⟨i| : by sorry
         ... = ∑ i, (p i) * ρ_S' ⊗ |i⟩⟨i| : by sorry
         ... = _ : by sorry,
end