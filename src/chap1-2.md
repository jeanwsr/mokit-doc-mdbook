# 1.2 How to Cite
If you use any module or utility of MOKIT in your work, you should cite MOKIT in the main body of your paper. Three examples are shown below:

**E1.** The HF/DFT calculations are performed using Gaussian 16<sup>[1]</sup> software package, and the MC-PDFT calculation is performed by OpenMolcas<sup>[2]</sup>. The utility fch2inporb in MOKIT<sup>[3]</sup> is used to transfer molecular orbitals from Gaussian to OpenMolcas.

**E2.** The GKS-EDA computations are performed by the XEDA<sup>[1]</sup> module interfaced with the GAMESS<sup>[2]</sup> program. For better SCF convergence and accelerating the EDA computation, converged molecular orbitals of each monomer and the complex are taken and converted from Gaussian<sup>[3]</sup> DFT calculations. This procedure is automatically conducted by the MOKIT<sup>[4]</sup> package.

**E3.** The GVB, CASSCF and CASPT2-K computations are performed using the GAMESS<sup>[1]</sup>, PySCF<sup>[2]</sup> and ORCA<sup>[3]</sup> packages, respectively. All the multi-configurational computations are performed in a black-box way with the help of MOKIT<sup>[4]</sup>.

Currently we have not published the paper of MOKIT program. As for the content of the reference, you should cite like
```
[4] Jingxiang Zou, MOKIT program, https://gitlab.com/jxzou/mokit (accessed Apr 13, 2024).
```

where the "Apr 13" should be modified as the version you used. The version number can be found by running `automr --version`, or simply `automr -v`. Note that citing MOKIT only in the supporting information of a paper is insufficient, since such citation can hardly be gathered by search engine or database. Citation files of MOKIT can be found in the `$MOKIT_ROOT/doc/` directory, you can import them into EndNote. See [published papers](https://jeanwsr.gitlab.io/mokit-doc-mdbook/citing.html) which cite MOKIT.

If any of the keyword `ist=0,1,3` (see [Section 4.4.4](https://jeanwsr.gitlab.io/mokit-doc-mdbook/chap4-4.html#444-ist)) in program `automr` is used, citing the following two papers would be appreciated

[2] J. Chem. Theory Comput. 2019, 15, 141–153. DOI: [10.1021/acs.jctc.8b00854](https://pubs.acs.org/doi/10.1021/acs.jctc.8b00854)  
[3] J. Phys. Chem. A 2020, 124, 8321–8329. DOI: [10.1021/acs.jpca.0c05216](https://pubs.acs.org/doi/10.1021/acs.jpca.0c05216).

Besides, you need to CITE all quantum chemistry software packages called in your `automr` job(s). For example, the file `examples/automr/00-h2o_cc-pVDZ_1.5.gjf` is a CASSCF job. 3 software packages will be called:

(1) Gaussian will be called to perform RHF/UHF;  
(2) GAMESS will be called to perform GVB;  
(3) PySCF will be called to perform CASSCF.

Therefore, in this case you should also cite corresponding references of [Gaussian](http://gaussian.com/citation), [GAMESS](https://www.msg.chem.iastate.edu/gamess/citation.html) and [PySCF](https://pyscf.org/about.html#how-to-cite), as well as possible references of electronic-structure methods and basis sets.

You can use MOKIT to perform computations for other people. But remember to remind him/her that MOKIT should be properly cited.

