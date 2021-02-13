### Goal: Translate the paper to Lean code

There is a system S. The system is described by a quantum state ρ.

When does there exist a unitary that acts on the system S and another "catalytic" system C such that the state of S changes from ρ to ρ'?

The paper says: iff entropy(ρ') ≥ entropy(ρ).

The goal is to formalize the proof of this.

Strategy: Start by stating the theorem, then develop the API needed to remove all errors.

### Lean code can teach us about nature!

"While an isolated system that undergoes (micro-)reversible dynamics has constant entropy, the result shows that if a system plus its environment undergo reversible dynamics in such a way that the (statistical) state of the environment remains unchanged at the end of the process, then the system's entropy is non-decreasing. 

Moreover, any state with higher entropy may be reached by a suitable environment and reversible dynamics."