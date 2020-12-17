-- import Lemma3
-- import Lemma4

-- There is a system S. The system is described by a quantum state ρ.

-- When does there exist a unitary that acts on the system S and another "catalytic" system C such that the state of S changes from ρ to ρ'?

-- The paper says: iff entropy(ρ') ≥ entropy(ρ).

-- The goal is formalize the proof of this.

---- Strategy: Start by stating the theorem, then develop the API needed to remove all errors.

import linear_algebra.eigenspace
import to_mathlib_maybe.Hilbert_space
-- import Shannon_theory.src.rnd_var
import state

open_locale tensor_product big_operators

variables
{ι : Type} [fintype ι]
{ℋ : Type} [complex_hilbert_space ℋ]
{ρ : module.End ℂ ℋ} [quantum_state ρ]
{ρ' : module.End ℂ ℋ} [quantum_state ρ']
{U : module.End ℂ ℋ} [unitary U]
{q : ι → ℝ} [rnd_var q]

notation U`†` := U -- sorry -- conjugate transpose U

class unitary (ρ : module.End ℂ ℋ) :=
(unitary_ness : U† = inverse U)

def evolve (U) (ρ) := U ∘ ρ ∘ U†

def reachable_by_catalysis (ε : ℝ) (ρ) (ρ') := ∃ σ, ∃ U, Tr₁ (evolve U (ρ ⊗ σ)) = σ ∧ trace_distance (Tr₂ (evolve U (ρ ⊗ σ)) ρ') ≤ ε

notation ρ `→ε` ρ' := reachable_by_catalysis ε ρ ρ'

theorem reachable_iff_higher_entropy : (∀ ε>0, ρ →ε ρ') ↔ H(ρ') ≥ H(ρ) := 
begin
  split,
  { -- "The direction i) ⇒ ii) follows directly from sub-additivity, 
    -- unitary invariance and continuity of von Neumann entropy:"
    intro H,
    intro ε,
    calc H(ρ'ε) + H(σ) ≥ H(ρ'ε ⊗ σ)              : by sorry -- subadd
                  ... = H(U * (ρ ⊗ σ) * U†)     : by sorry, -- def of ρ'ε and invariance of σ under transformation
                  ... = H(ρ ⊗ σ)              : by sorry, -- unitary invariance
                  ... = H(ρ) + H(σ)              : by sorry, -- bipartite entropy
    -- then rw to cancel H(σ) ("by continuity") and done
    sorry
  },
  { -- "The converse direction ii) ⇒ i) requires several Lemmas:"
    
  },
end

-- Lemma 3
-- TODO I feel like we should define the type `unitary ℋ` for U(dim ℋ) so that we don't need to write down the constraint every time
-- After looking in the mathlib docs, this seems to not have been defined yet, but maybe we can model it around this:
--  https://leanprover-community.github.io/mathlib_docs/linear_algebra/special_linear_group.html#matrix.special_linear_group
def majorizes (ρ) (ρ') := ∃ (q : ι → ℝ) (V : ι → module.End ℂ ℋ), ∀ i, unitary (V i) → ρ' = ∑ i, (q i) * (evolve (V i) ρ)
notation ρ `≽` ρ' := majorizes ρ ρ'

