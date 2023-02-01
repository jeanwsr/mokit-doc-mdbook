# 3 Quickstart
See examples in $MOKIT_ROOT/examples/. More details to be added.

## 3.1 Which method should I use?
For practical use, e.g. to properly compare results with those from experiments,
NEVPT2, CASPT2, MC-PDFT or MRCISD is recommended. The GVB and CASSCF methods are
often qualitatively correct. For high accuracy results, dynamic correlation is
necessary. Additional general recommendations are provided below:

(1) NEVPT2 is free of the intruder-state problem, thus is preferable to CASPT2.

(2) If you find NEVPT2/CASPT2 is too expensive for your system, consider the MC-
PDFT method.

(3) If you find the computation cost of NEVPT2/CASPT2 is acceptable for your system
and you want higher accuracy, consider ic-MRCISD in OpenMolcas/Molpro. For very
small systems such as two or three atoms, the uncontracted MRCISD in ORCA is a good
choice.

## 3.2 Which basis set should I use?
For testing or debug, you can use any type of basis sets. You can, of course, use a small basis set like def2-SVP to test whether AutoMR works. However, for practical use or to obtain publishable data, please use at least triple-zeta basis set, e.g. cc-pVTZ, def-TZVP, def2-TZVP or def2-TZVPP. Results obtained from combinations like MRCISD/def2SVP, NEVPT2/6-31G(d) are almost useless. If, unfortunately, you have very limited computational resource, e.g. less than 8 CPU cores, then the cc-pVDZ basis set is recommended. Additional general recommendations are provided below:

(1) If your system is large, or has complicated electronic structure and you want to see whether AutoMR works, or you just want to see the workflow of AutoMR, you can use a small basis set like def2SVP to go through the computation. After it normally terminates, you can switch to using a larger basis set.

(2) If your system is large (>600 basis functions), you should consider properly simplify your system or use mixed basis sets for different elements/atoms. For example, replace unimportant methyl group(s) by hydrogen atoms, use cc-pVTZ for important atoms and cc-pVDZ (or even 6-31G(d)) for other atoms, etc. Also/Alternatively you can turn on the RI approximation (see Section 4.4.29) in CASSCF and CASSCF-NEVPT2 computations.

(3) Pople-type basis set like 6-311G(d,p) or 6-31G(d,p) is less recommended, but can be used for unimportant atoms.

(4) If pseudopotential (PP) is desired, better to use cc-pVTZ-PP, def2-TZVP. Be careful with the built-in basis set (with PP) SDD in Gaussian software for elements >= the 4th period. Often there is no d, f polarization functions in the built-in SDD basis set of Gaussian (although the PP part seem pretty good), but the d, f polarization functions are usually important for high-accuracy computations. If you insist on using SDD, you should search in previous papers the data of d, f polarization functions of SDD for your atoms, and add the data to the .gjf file manually.

(5) If your molecule is an anion, e.g. MnO4-, it is strongly recommended to use basis set with diffuse functions, such as aug-cc-pVTZ, ma-def2-TZVP. Similar to (1), if your system is large, you can use basis set with diffuse functions for atoms with significant negative charges, and use no diffuse functions for other atoms. If the atoms involving significant negative charges are not so important in your study, you can just use aug-cc-pVDZ or ma-def2-SVP.

(6) If all-electron relativistic calculations are desired (DKH2 or X2C), do remember to use basis sets like cc-pVTZ-DK, x2c-TZVPall or ANO-RCC series. All-electron relativistic computations using CASSCF/cc-pVTZ or cc-pVTZ-PP with DKH2 is almost non-sense.

(7) Remember that def2-TZVP is used formally in papers, but def2TZVP is used as the name of basis set in Gaussian syntax.

(8) If you want to compute the NMR shielding constants, basis sets like pcSseg-1 or pcSseg-2 are strongly recommended. Large basis sets like pcSseg-3, def2-QZVP or cc-pVQZ would be better but they are very time-consuming.

(9) If you only want to obtain the radical indices printed by AutoMR, and accurate electronic energies are not desired, then basis sets cc-pVDZ/6-31G(d,p)/def2SVP are sufficient. There is no need to use triple-zeta basis set like def2TZVP. If your studied molecule is very small (e.g. <10 atoms), then you can still use any triple-zeta basis set.

(10) If you only want to perform energy decomposition analysis, e.g. GKS-EDA, usually def2TZVP basis set is sufficient. If there is any anion in your studied molecule(s), it is recommended to use diffuse functions only for anion-related atoms. It is not recommended to apply ma-TZVPP for all atoms (which will probably cause basis set linear dependence problems and make SCF in GAMESS converges slowly, even with MOs written in the .inp file). Also, it is recommended to use the implicit solvent model PCM rather than SMD, since PCM is frequently used in original papers of GKS-EDA.

## 3.3 Do I need to specify the active space?
The `automr` program can automatically determine the active space, thus you need not specify that. If you do not want the automatically determined one, you can manually specify it, such as CASSCF(m,n) or NEVPT2(m,n), with m, n being the number of active electrons and active orbitals, respectively. Currently only m=n is supported (this is very reasonable, see DOI: 10.1021/acs.jctc.0c00123). While for GVB, you may specify GVB(n), where n is the number of pairs. Manually specifying is only recommended for experienced users.

Note that usually there is no need to write DMRGCI or DMRGSCF, the users can just write CASCI or CASSCF. Once AutoMR detects the size of active space is larger than (15,15), it will switch from CASCI/CASSCF to DMRGCI/DMRGSCF automatically. Similarly, the NEVPT2/CASPT2/MC-PDFT will be automatically switched into DMRG-NEVPT2/DMRG-CASPT2/DMRG-PDFT when the active space is larger than (15,15). The only exception is that the users just want to perform a DMRG calculation with active space smaller than (15,15), then the DMRGCI or DMRGSCF must be specified.

Usually the automatically determined active space is reasonable. The algorithm in
MOKIT is designed to automatically find the minimum active space for a given molecule.
However, when you are studying a potential energy curve/surface, the automatically
determined active space may be not the same size for each geometry. For example,
for N~2~ molecule at *d*(N-N) = 1.15 Å, the CAS(4,4) may be automatically determined
by AutoMR, but for for *d*(N-N) = 4.0 Å, the active space turns into CAS(6,6). Thus,
if you want to keep the size to be CAS(6,6), you need to specify CASSCF(6,6), NEVPT2(6,6),
MRCISD(6,6), etc.

## 3.4 Are my computation results reasonable?
(1) You should make sure that your CASSCF initial orbitals and final(i.e. converged)
orbitals contain proper active orbitals. Here are two examples: (i) Assuming you are
studying the bond breaking of a C-C bond, you use CAS(2,2) at least. And you should
make sure that your CASSCF initial orbitals and final orbitals contain the bonding
and anti-bonding orbitals this C-C bond. Note that the RHF orbitals or MP2 natural
orbitals are usually poor to be used as the initial guess when studying bond breaking
or transition-metal-containing molecules. (ii) Assuming you are studying the \\( \pi \\)
-> \\( \pi \\)* excited energies, then your active space is expected to contain
desired \\( \pi \\) and \\( \pi \\)* orbitals.

(2) If you perform the CASSCF (or CASSCF-based methods like NEVPT2, CASPT2, etc), there would be a file with suffix `*CASSCF_NO.fch` generated, in which the CASSCF natural orbitals and corresponding occupation numbers are held. You can use GaussView or Multiwfn to open this file and visualize whether these active orbitals are reasonable, if you know your molecule fairly well.

If you perform CASCI (or CASCI-based jobs), the CASCI NOs are held in a `*CASCI_NO.fch` file. If you only perform GVB computation, the GVB NOs are held in the `*gvb2_s.fch` file.

(3) If you are comparing relative energies of two target molecules (e.g. two local minima of the same molecule), be sure that you are using the same size of active space for two molecules. For example, it is incorrect(or unfair) to compare two NEVPT2 energies if one is based on CAS(4,4) and the other one is based on CAS(8,8). If, unfortunately, you encounter such special case, you have two options: (i) explicitly specify the active space in the former calculation, i.e. NEVPT2(8,8) in the input file; (ii) if you find there are 4 orbitals not so active in the latter calculation (meaning occupation numbers close to 0 or 2), you can specify NEVPT2(4,4) in the input file.

(4) If you are calculating the bond dissociation energy, you should check whether the sum or combination of active space from two fragments equals to the active space of the original molecule. You are supposed to analyze main components of the active space. For example, assuming the original molecule has a CAS(6,6) active space, and assuming it contains 2 singly occupied orbitals from fragment 1, two bonding orbitals and two anti-bonding orbitals constructed by two fragments. Then quintuplet CAS(4,4) should be used for fragment 1 and triplet CAS(2,2) for fragment 2.

(5) For the rigid/unrelaxed scanning of a chemical bond, you are always recommended
to scan the bond from long distance to short distance, rather than from short to
long. And you are recommended to write the keyword `scan` in the Gaussian keyword
`#p` line. This will perform the rigid/unrelaxed scan automatically. It is not re-
commended to calculate each scanned geometry manually.

