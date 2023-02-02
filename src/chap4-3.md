# 4.3 Keywords of supported methods in `automr`
Currently, the keywords of all supported methods in `automr` are: **GVB**, **CASCI**,
**CASSCF**, **DMRGCI**, **DMRGSCF**, **NEVPT2**, **CASPT2**, **CASPT2K**, **SDSPT2**,
**MRMP2**, **MRCISD**, **MRCISDT**, **MCPDFT**, **DFTCI**, **BCCC2b** and **BCCC3b**.
More multi-configurational and multi-reference methods will be supported in the future.
These terms should be written in the `#p ...` line in the .gjf file.

There must be a '/' symbol between the method and the basis set, e.g. `CASSCF/cc-pVTZ`.
`automr` does not allow the use of a spacing to separate the method and basis set
(which is allowed in Gaussian). When `readrhf`, `readuhf`, or `readno` is used in
`mokit{}`, the basis set after '/' symbol is usually useless, since the geometry
and basis set data will be read from the given .fch(k) file. Note that, however,
the user still needs to provide a basis set name, although it is not used in this
case.

There is also an exception that the basis set after '/' symbol matters. If RI (see Section 4.4.29) approximation is turned on, the auxiliary basis set will be automatically determined (by `automr`) according to the basis set. And if F12 (see Section 4.4.31) is turned on, the F12-CABS will be automatically determined (by `automr`) according to the basis set, too.

## 4.3.1 GVB
Generalized Valence Bond theory.

Note that the original GAMESS source code can only deal with GVB up to 12 pairs. To go beyond that (which is routine type of calculation in `automr` of MOKIT), you need to modify the GAMESS source code, please read Section 4.4.10 carefully.

## 4.3.2 CASSCF
Complete Active Space Self-consistent Field.

Currently excited state computations are not supported. Please read Section A2.3 for comments on excited state computations. Please read related keyword `CASSCF_prog` in Section 4.4.12.

## 4.3.3 CASCI
Complete Active Space Configuration Interaction.

CASCI can be viewed as the 0-th step of the CASSCF step, i.e. CASSCF without orbital optimization. It is always recommended to perform CASSCF rather than CASCI, expect for those who wish to compare the quality of different initial guesses, and/or do not want the CASSCF result. Please read related keyword `CASCI_prog` in Section 4.4.11.

## 4.3.4 DMRGSCF
Here the keyword DMRGSCF actually means the DMRG-CASSCF method. Please also read Section 4.4.14 for related information.

## 4.3.5 DMRGCI
Here the keyword DMRGCI actually means the DMRG-CASCI method. Please also read Section 4.4.13 for related information.

DMRGCI can be viewed as the 0-th step of the DMRGSCF step, i.e. DMRGSCF without orbital optimization. It is always recommended to perform DMRGSCF rather than DMRGCI, expect for those who wish to compare the quality of different initial guesses, and/or do not want the DMRGSCF result.

## 4.3.6 NEVPT2
Second order N-Electron Valence state Perturbation Theory based on the CASSCF reference.

Please read related keyword `NEVPT2_prog` in Section 4.4.16.

## 4.3.7 CASPT2
Second order Perturbation Theory based on CASSCF reference.

Generally speaking, NEVPT2 is more recommended than CASPT2 since there is no need for IP-EA shift, real or imaginary shift in NEVPT2. If you are really a fan of CASPT2, it is recommended to use CASPT2K instead, see Section 4.3.8 CASPT2K. Please read related keyword CASPT2_prog in Section 4.4.15.

## 4.3.8 CASPT2K
Second order Perturbation Theory based on CASSCF reference.

This is a new feature since ORCA 5.0. A revised zeroth order Hamiltonian is applied to alleviate the intruder state problem of CASPT2 method. No IP-EA shift is needed in this method.

Note here you can write this keyword as either CASPT2K or CASPT2-K in .gjf file,
but you'd better use the method name CASPT2-K in official writing or publishing.
The keyword `CASPT2_prog` will automatically be set as ORCA, since this method is
only supported in ORCA currently.

## 4.3.9 CASPT3
Third order Perturbation Theory based on CASSCF reference.

Only Molpro program can be called to perform CASPT3, and it is default.

## 4.3.10 SDSPT2
Static-dynamic-static multi-state multi-reference second-order perturbation theory (SDS-MS-MRPT2, or SDSPT2 for short).

There are several restrictions when you use this method:

(1) only the single (electronic) state version can be used in automr, since only the ground state is calculated.

(2) SDSPT2 based on the CASCI reference is not supported currently. CASSCF-SDSPT2 is supported.

(3) background point charges are not supported.

This version of SDSPT2 is performed by the Xi'an CI module of BDF program. So you are assumed to have successfully installed BDF. You should cite this paper DOI: 10.1080/00268976.2017.1308029 if you use this method.

## 4.3.11 MRMP2
Second order Multi-reference Perturbation Theory based on CASSCF reference.

After CASSCF converged, `automr` will call the GAMESS program to perform MRMP2 calculation. No other program is supported. Also, DMRG-MRMP2 is not supported and `automr` will abort in that case.

## 4.3.12 OVBMP2
Orthogonal valence bond Møller-Plesset 2 based on CASSCF reference.

After CASSCF converged, `automr` will call the Gaussian program to perform OVB-MP2 calculation. No other program is supported. Also, DMRG-OVB-MP2 is not supported and `automr` will abort in that case.

Note that OVBMP2 is a keyword in `automr` but OVB-MP2 is the method name. Do not mix them up. Some literature might call this method as 'CASSCF MP2' but that is actually misleading (those authors were fooled by keywords "CASSCF MP2" in Gaussian input file).

## 4.3.13 MRCISD
Multi-reference Configuration Interaction Singles and Doubles, based on the CASCI/CASSCF reference.

Please read related keyword `MRCISD_prog` in Section 4.4.17.

## 4.3.14 MRCISDT
Multi-reference Configuration Interaction Singles, Doubles and Triples, based on the CASCI/CASSCF reference.

The related keyword `MRCISDT_prog` can only be equal to one of OpenMolcas(default), Dalton, PSI4 and GAMESS. No Davidson correction will be provided, and only uncontracted MRCISDT is supported.

## 4.3.15 MCPDFT
Multi-configurational Pair Density Functional Theory, based on CASSCF reference.

Note that MCPDFT is a keyword in `automr` but MC-PDFT is the method name. Do not mix them up.

Note that if the active space is larger than (15,15), the MC-PDFT will be automatically switched to DMRG-PDFT. In this special case you need to install the QCMaquis package (interfaced with OpenMolcas) for DMRG computations. DMRG-PDFT is not supported in GAMESS currently.

Please read related keyword `MCPDFT_prog` in Section 4.4.19. Also note that in GAMESS, the MC-PDFT is only supported for version >= 2019(R2).

## 4.3.16 DFTCI
The DFT/MRCI method by Stefan Grimme, Mirko Waletzke, and Martin Kleinschmidt et. al.

Note that the name of this method is DFT/MRCI, but you should write the keyword DFTCI in the input file of `automr`, in order to perform DFT/MRCI computations.

Currently, to perform DFT/MRCI computations, you should have ORCA and DFT/MRCI program installed on your node/machine.

Note: full implementation of this keyword has not been finished yet.

## 4.3.17 MRCC
Multi-reference Coupled Cluster theory, based on the CASCI/CASSCF reference.

Currently only the FIC-MRCC method in ORCA(>=5.0.0) is supported.

## 4.3.18 BCCC2b
Block-correlated coupled cluster theory based on the GVB reference.

This is in fact a multi-reference coupled cluster theory based on GVB wave function,
where 2b means only the two-block excitation operators \\( {\hat{T_2}} \\) are considered
in the cluster expansion. Moreover, this method is a spin-pure coupled-cluster method.

Currently only spin singlet is supported. This program is developed by jxzou during
his Ph.D. in Prof. [Shuhua Li](https://itcc.nju.edu.cn/shuhua)'s research group.
Currently this program has not been released yet, but will probably be released
after its corresponding paper published.

Currently only correlations between two pairs are taken into consideration (i.e.
occ->pair, occ->vir, pair->vir not considered so far). So BCCC2b is just a *rough*
theory. Note that the intra-pair excitation operator \\( \hat{{T_1}} \\) plays
little role, so the BCCC2b (i.e. only \\( \hat{{T_2}} \\) ) is extremely close to
BCCC2 (i.e. \\( \hat{{T_1}} + \hat{{T_2}} \\) ). For GVB(2), the BCCC2 is equivalent
to CASCI(4,4) using GVB orbitals, and thus BCCC2b is extremely close to CASCI(4,4).
For GVB(*n*), *n*>2, the GVB(*n*)-BCCC is an approximation method to CASCI(2*n*,2*n*)
using GVB orbitals.

This program scales as *O*(*n*<sup>4</sup>), where *n* is the number of GVB pairs.
But the integral transformation needed for the BCCC2b scales as *O*(*n*<sup>5</sup>),
so the overall scaling might behave as *O*(*n*<sup>5</sup>) for large number of
pairs.

## 4.3.19 BCCC3b
Block-correlated coupled cluster theory based on the GVB reference, where 3b means
\\( \hat{{T_2}} + \hat{{T_3}} \\).

This means two-pair and three-pair correlations are considered based on the GVB
reference. Also, this method is spin-pure. Currently only spin singlet is supported.

For practical computations with desired accuracy, you should use BCCC3b rather than
BCCC2b. This program scales as *O*(*n*<sup>5</sup>), where *n* is the number of
GVB pairs. As stated in 4.3.18 BCCC2b, this program has not been released yet.

