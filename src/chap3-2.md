## 3.2 Which method should I use?

For wave function analysis or visualization of active orbitals, GVB and CASSCF methods are sufficient.

For practical use, e.g. to properly compare results with those from experiments, NEVPT2, CASPT2, MC-PDFT or MRCISD are recommended. The GVB and CASSCF methods are only qualitatively correct. Additional general recommendations are provided below:

(1) NEVPT2 is free of the intruder-state problem, thus is preferable to CASPT2.

(2) If you find NEVPT2/CASPT2 is too expensive for your system, consider the MC-PDFT method.

(3) If you find the computation cost of NEVPT2/CASPT2 is acceptable for your system and you want higher accuracy, consider ic-MRCISD in OpenMolcas/Molpro. For very small systems such as two or three atoms, the uncontracted MRCISD in ORCA is a good choice.

