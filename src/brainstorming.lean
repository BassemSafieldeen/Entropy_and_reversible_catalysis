-- import Lemma3
-- import Lemma4

-- There is a system S. The system is described by a quantum state ρ.

-- When does there exist a unitary that acts on the system S and another "catalytic" system C such that the state of S changes from ρ to ρ'?

-- The paper says: iff entropy(ρ') ≥ entropy(ρ).

-- The goal is formalize the proof of this.

---- Strategy: Start by stating the theorem, then develop the API needed to remove all errors.

import linear_algebra.eigenspace
import to_mathlib_maybe.Hilbert_space
import to_mathlib_maybe.pTrace
-- import Shannon_theory.src.rnd_var
import state
import .channel
import entropy

open_locale tensor_product big_operators

variables
{ι : Type} [fintype ι]
{ℋ : Type} [complex_hilbert_space ℋ]
{ρ : module.End ℂ ℋ} [quantum_state ρ]
{ρ' : module.End ℂ ℋ} [quantum_state ρ']
{σ : module.End ℂ ℋ} [quantum_state σ]
{U : module.End ℂ ℋ} [unitary U]
-- {q : ι → ℝ} [rnd_var q]

def trace_distance (ρ : module.End ℂ ℋ) (σ : module.End ℂ ℋ) : ℝ := sorry -- 1/2 * ∑ e ∈ spectrum (ρ-σ), abs e

-- TODO partial trace is undefined for entangled states
def reachable_by_catalysis (ε : ℝ) (ρ : module.End ℂ ℋ) (ρ' : module.End ℂ ℋ) :=
∃ σ : module.End ℂ ℋ, ∃ U : module.End ℂ ℋ,
Tr₁ (evolve U (ρ ⊗ σ)) = σ ∧
trace_distance (Tr₂ (evolve U (ρ ⊗ σ))) ≤ ε

-- notation ρ `→ε` ρ' := reachable_by_catalysis ε ρ ρ'
notation `H` := entropy

-- Utils
-- Identity linear map
def Id (d : ℕ) := λ x : ℋ, x -- TODO make dimension explicit in definition
-- d×d matrix with 1 at (i j) and 0 otherwise
def E (i j d : ℕ) : module.End ℂ ℋ := sorry
-- cyclic shift operators
def shift (k n : ℕ) := ∑ i ∈ finset.range n, (E i (i+k)%n n)
-- shift by 1 on S1, ..., Sn
def cycle_s (d n : ℕ) := (Id d) ⊗ (shift 1 n) ⊗ (Id n)
-- shift by one on A
def cycle_ancilla (d n : ℕ) := (Id d)^⊗n ⊗ (shift 1 n)
-- Dephasing channel sending χ to its diagonal in the eigenbasis of ρ'
def dephasing_channel (ρ') := λ ρ, ∑ v ∈ eigenvectors ρ', inner v (ρ v)
-- Unitary and ancilla on Naimark's dilated system corresponding to an arbitrary quantum channel
def naimark_unitary (C : module.End ℂ ℋ →[ℂ] module.End ℂ ℋ) [quantum_channel C] : module.End ℂ ℋ := sorry
def naimark_ancilla (C : module.End ℂ ℋ →[ℂ] module.End ℂ ℋ) [quantum_channel C] : module.End ℂ ℋ := sorry

-- Choose catalytic state σ₁⊗σ₂ according to two-step construction
--  1. Define σ₁ using (16). This requires choosing `n` and `U` (in order to define `χ`). `n` can be estimated using (17). `U` is chosen such that the final state on `S` is as close to `ρ'` as possible - but there is no explicit formula. I still don't know how to deal with this.
-- TODO define trace for arbitrary number of subsystems; in particular, this definition requires a function of type
--  `Tr : list ℕ → quantum_state → quantum_state`
-- where the list of integers indicates the subsystems to be traced out
-- TODO define trace making the system partition explicit, otherwise LEAN will not know what we mean by `Tr k` unless the argument is a product state
def σ₁ (ρ) (n) (U) := (1/n) • ∑ k in finset.range n, ρ^⊗(n-k) ⊗ (Tr (list n-k n) (evolve (U ρ))) ⊗ |k⟩⟨k|

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
    calc H(ρ'ε) + H(σ) ≥ H(ρ'ε ⊗ σ)              : by sorry -- subadd
                  ... = H(evolve U (ρ ⊗ σ))     : by sorry -- def of ρ'ε and invariance of σ under transformation
                  ... = H(ρ ⊗ σ)              : by sorry -- unitary invariance
                  ... = H(ρ) + H(σ)              : by sorry, -- bipartite entropy
    -- then rw to cancel H(σ) ("by continuity") and done
    sorry
  },
  { -- "The converse direction ii) ⇒ i) requires several Lemmas:"
    use σ₁ ⊗ σ₂,
    use V,
    -- TODO again we need a suitable definition of trace that we don't have
    -- `Tr (-S) ρ` means "trace out everything except subsystem S"
    have hyp_close : D(ρ', Tr (-S) evolve(V σ₂ ⊗ ρ ⊗ σ₁)) ≤ ε, by sorry -- lemma 4
    have hyp_catalysis : Tr S evolve(V σ₂ ⊗ ρ ⊗ σ₁) = σ₂ ⊗ σ₁, by sorry -- lemmas 4 & 5
  },
end