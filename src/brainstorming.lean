import linear_algebra.eigenspace
import rnd_var

import to_mathlib_maybe.pTrace
import to_mathlib_maybe.Hilbert_space
import to_mathlib_maybe.pTrace
import state
import .channel
import entropy

#check rnd_var
#check quantum_state
#check quantum_channel
#check entropy

-- import Lemma3
-- import Lemma4

open_locale tensor_product big_operators

variables
{ι : Type} [fintype ι] [decidable_eq ι]
{ℋ : Type} [complex_hilbert_space ℋ]
{ρ : module.End ℂ ℋ} [quantum_state ρ]
{ρ' : module.End ℂ ℋ} [quantum_state ρ']
{σ : module.End ℂ ℋ} [quantum_state σ]
{U : module.End ℂ ℋ} [unitary U]
-- {q : ι → ℝ} [rnd_var q]

def reachable_by_catalysis (ε : ℝ) (ρ : module.End ℂ ℋ) (ρ' : module.End ℂ ℋ) :=
∃ σ : module.End ℂ ℋ, ∃ U : module.End ℂ ℋ,
Tr₁(U ∘ (ρ ⊗ σ) ∘ U†) = σ 
∧
D(Tr₂(U ∘ (ρ ⊗ σ) ∘ U†), ρ') ≤ ε

-- notation ρ `→ε` ρ' := reachable_by_catalysis ε ρ ρ'
notation `H` := entropy

-- Choose catalytic state σ₁⊗σ₂ according to two-step construction
--  1. Define σ₁ using (16). This requires choosing `n` and `U` (in order to define `χ`). `n` can be estimated using (17). `U` is chosen such that the final state on `S` is as close to `ρ'` as possible - but there is no explicit formula. I still don't know how to deal with this.
-- TODO define trace for arbitrary number of subsystems; in particular, this definition requires a function of type
--  `Tr : list ℕ → quantum_state → quantum_state`
-- where the list of integers indicates the subsystems to be traced out
-- TODO define trace making the system partition explicit, otherwise LEAN will not know what we mean by `Tr k` unless the argument is a product state
def σ₁ (ρ) (n) (U) := (1/n) • ∑ k in finset.range n, ρ^⊗(n-k) ⊗ (Tr(list n-k n) (U ∘ ρ ∘ U†)) ⊗ |k⟩⟨k|

--  2. Ancilla system R for the dephasing channel. This is just the ancilla in the Naimark/Stinespring dilation of the channel.
def σ₂ := naimark_ancilla (dephasing_channel ρ')

-- Pick unitaries: we want to compose steps 1, 2, & 3 (see fig. 3) with a dephasing channel
def V := naimark_unitary (dephasing_channel ρ') ∘ cycle_ancilla ∘ cycle_s ∘ (U ⊗ |n⟩⟨n| + (Id d*(n-1)) ⊗ ∑ k in finset.range (n-1), |k⟩⟨k|)

theorem reachable_iff_higher_entropy : (∀ ε>0, reachable_by_catalysis ε ρ ρ') ↔ H(ρ') ≥ H(ρ) := 
begin
  split,
  { -- "The direction i) ⇒ ii) follows directly from sub-additivity, 
    -- unitary invariance and continuity of von Neumann entropy:"
    intro h,
    intro ε,
    let ρσ' := U ∘ (ρ ⊗ σ) ∘ U†,
    let ρ'ε := Tr₂ ρσ',
    calc H(ρ'ε) + H(σ) ≥ H(ρσ')              : by apply entropy_subadditive,
                  ... = H(U ∘ (ρ ⊗ σ) ∘ U†)     : by sorry -- def of ρ'ε and invariance of σ under transformation
                  ... = H(ρ ⊗ σ)              : by apply entropy_unitary_evolution_eq_entropy_self,
                  ... = H(ρ) + H(σ)              : by apply entropy_tmul_eq_add_entropy,
    -- then rw to cancel H(σ) ("by continuity") and done
    sorry
  },
  { 
    /-
    "The proof [of the ii) ⇒ i) direction] proceeds in two parts:
    -/

    let χ := U ∘ ρ^⊗n ∘ U†,

    /-
    First we construct a catalyst σ₁ for the exact transition from ρ 
    to the equal mixture χ_bar := 1/n * ∑ k, (χ k) of states (χ k) = pTr_k_bar χ." 
    -/

    /-
    "Then we use a second catalyst R in state σ₂ to implement the
    dephasing map and obtain 𝒟_ρ'[χ] , which is ε-close to the target ρ'
    The part R of the catalyst thus effectively acts as a source of randomness."
    -/

    let ρ'ε := 𝒟_ρ'[χ],

    /-
    "By Lemma 5 and the fact that the dephasing map is a mixed unitary channel, 
    this second part can be done in such a way that the two parts of the catalyst 
    remain uncorrelated."
    -/

    /-
    "From the results of [35] it follows that σ₂ only needs to have a dimension of 
    the order of √d. Furthermore, note that by perturbing ρ' arbitrarily slightly, 
    we can always ensure that H(ρ) < H(ρ') since we allow for arbitrarily small
    errors and von Neumann entropy is continuous. We thus only need to prove that 
    we can do the transition ρ →ε=0 χ_bar in the case H(ρ') > H(ρ)."
    -/

    /-
    "To show this we make use of a trick that was used in recent work by Shiraishi 
    and Sagawa [33]."
    -/
    
    -- use σ₁ ⊗ σ₂,
    -- use V,
 
    -- have hyp_close : D(ρ', Tr (-S) evolve(V σ₂ ⊗ ρ ⊗ σ₁)) ≤ ε, by sorry -- lemma 4
    -- have hyp_catalysis : Tr S evolve(V σ₂ ⊗ ρ ⊗ σ₁) = σ₂ ⊗ σ₁, by sorry -- lemmas 4 & 5
  },
end