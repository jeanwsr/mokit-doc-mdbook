## 3.3 Which basis set should I use?

For testing or debug, you can use any type of basis sets. You can, of course, use a small basis set like `def2-SVP` to test whether `automr` works. However, for practical use or to obtain publishable data, please use at least triple-zeta basis set, e.g. `cc-pVTZ`, `def-TZVP`(.ie. `TZVP` in Gaussian), `def2-TZVP` or `def2-TZVPP`. Results obtained from combinations like `MRCISD/def2SVP`, `NEVPT2/6-31G(d)` are almost useless. If, unfortunately, you have very limited computational resource, e.g. less than 8 CPU cores, then the `cc-pVDZ` basis set is recommended. Additional general recommendations are provided below:

(1) If your system is large, or has complicated electronic structure and you want to see whether `automr` works, or you just want to see the workflow of `automr`, you can use a small basis set like `def2SVP` to go through the computation. After it normally terminates, you can switch to using a larger basis set.

(2) If your system is large (>600 basis functions), you should consider properly simplify your system or use mixed basis sets for different elements/atoms. For example, replace unimportant methyl group(s) by hydrogen atoms, use `cc-pVTZ` for important atoms and `cc-pVDZ` (or even `6-31G(d)`) for other atoms, etc. Also/Alternatively you can turn on the RI approximation (see Section 4.4.29) in CASSCF and CASSCF-NEVPT2 computations.

(3) Pople-type basis set like `6-311G(d,p)` or `6-31G(d,p)` is less recommended, but can be used for unimportant atoms.

(4) If pseudopotential (PP) is desired, better to use `cc-pVTZ-PP`, `def2-TZVP`. Be careful with the built-in basis set (with PP) SDD in Gaussian software for elements >= the 4th period. Often there is no d, f polarization functions in the built-in SDD basis set of Gaussian (although the PP part seem pretty good), but the d, f polarization functions are usually important for high-accuracy computations. If you insist on using SDD, you should search in previous papers the data of d, f polarization functions of SDD for your atoms, and add the data to the .gjf file manually.

(5) If your molecule is an anion, e.g. MnO4-, it is strongly recommended to use basis set with diffuse functions, such as `aug-cc-pVTZ`, `ma-def2-TZVP`. Similar to (1), if your system is large, you can use basis set with diffuse functions for atoms with significant negative charges, and use no diffuse functions for other atoms. If the atoms involving significant negative charges are not so important in your study, you can just use `aug-cc-pVDZ` or `ma-def2-SVP`.

(6) If all-electron relativistic calculations are desired (DKH2 or X2C), do remember to use basis sets like `cc-pVTZ-DK`, `x2c-TZVPall` or `ANO-RCC` series. All-electron relativistic computations using `CASSCF/cc-pVTZ` or `cc-pVTZ-PP` with DKH2 is almost non-sense.

(7) Remember that the two basis sets `def-TZVP` and `def2-TZVP` are used formally in papers, but `TZVP` and `def2TZVP` are used as the names of basis set in Gaussian syntax.

(8) If you want to compute the NMR shielding constants, basis sets like `pcSseg-1` or `pcSseg-2` are strongly recommended. Large basis sets like `pcSseg-3`, `def2-QZVP` or `cc-pVQZ` would be better but they are very time-consuming.

(9) If you only want to obtain the radical indices printed by `automr`, and accurate electronic energies are not desired, then basis sets such as `cc-pVDZ` is sufficient. There is no need to use triple-zeta basis set like `def2TZVP`. If your studied molecule is very small (e.g. <10 atoms), then you can still use any triple-zeta basis set.

(10) If you only want to perform energy decomposition analysis, e.g. GKS-EDA, usually `def2TZVP` basis set is sufficient. If there is any anion in your studied molecule(s), it is recommended to use diffuse functions only for anion-related atoms. It is not recommended to apply ma-TZVPP for all atoms (which will probably cause basis set linear dependence problems and make SCF in GAMESS converges slowly, even with MOs written in the .inp file). Also, it is recommended to use the implicit solvent model PCM rather than SMD, since PCM is frequently used in original papers of GKS-EDA.

(11) Some special basis sets can be used in the .gjf file of MOKIT, although these basis sets are not included in the Gaussian program. This is because MOKIT put these basis data in `$MOKIT_ROOT/mokit/basis/` and can import them when necessary. For example, the following syntax will immediately cause errors in Gaussian, but are supported in MOKIT

Example 1. DKH2 scalar relativistic Hamiltonian with the ANO-RCC-VDZP basis set
```
#p CASSCF/ANO-RCC-VDZP

mokit{DKH2,CASSCF_prog=ORCA}
```

Example 2. CASSCF NMR calculation with the pcSseg-1 basis set
```
#p CASSCF/pcSseg-1

mokit{NMR}
```

