# 1.1 Introduction to MOKIT
The full name of MOKIT is Molecular Orbital KIT. MOKIT offers various utilities
and modules to transfer MOs among various quantum chemistry software packages.
Besides, the `automr` program in MOKIT can set up and run common multi-reference
calculations in a block-box way.

With MOKIT, one can perform multi-reference calculations in a quite simple way,
and utilize the best modules of each program, e.g.

  UHF(UNO) -> CASSCF -> CASPT2  
  Gaussian&emsp;&emsp;PySCF&emsp;&emsp;OpenMolcas  
or  
  UHF(UNO) -> GVB    -> CASSCF -> NEVPT2  
  Gaussian&emsp;&emsp;GAMESS&emsp;PySCF&emsp;&emsp;PySCF  
or  
  RHF      -> GVB    -> CASSCF -> ic-MRCISD+Q  
  Gaussian GAMESS&emsp;PySCF&emsp;OpenMolcas  

Negligible energy loss (usually < 1e<sup>-6</sup> a.u., for the same wave function
method in two programs) are ensured during transferring MOs, since the basis order
of angular momentum up to H(i.e. *l*=5) is explicitly considered.

Note that although MOKIT aims to make the multi-reference calculations block-box,
the users are still required to have practical experiences of quantum chemistry
computations (e.g. familiar with routine DFT calculations in Gaussian). You are
encouraged to learn how to use Gaussian first if you are a fresh hand. See Appendix
A2 for more information.

