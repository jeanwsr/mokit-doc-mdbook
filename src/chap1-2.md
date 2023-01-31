# 1.2 How to Cite
If you use any module or utility of MOKIT in your work, you should cite MOKIT in
the main body of your paper. Three examples are shown below:

**E1.** The HF/DFT calculations are performed using Gaussian 16<sup>[1]</sup>
software package, and the MC-PDFT calculation is performed by OpenMolcas<sup>[2]</sup>.
The utility fch2inporb in MOKIT<sup>[3]</sup> is used to transfer molecular orbitals
from Gaussian to OpenMolcas.

**E2.** The GKS-EDA computations are performed by the XEDA<sup>[1]</sup> module
interfaced with the GAMESS<sup>[2]</sup> program. For better SCF convergence and
accelerating the EDA computation, converged molecular orbitals of each monomer
and the complex are taken and converted from Gaussian<sup>[3]</sup> DFT calculations.
This procedure is automatically conducted by the MOKIT<sup>[4]</sup> package.

**E3.** The GVB, CASSCF and CASPT2-K computations are performed using the GAMESS<sup>[1]</sup>,
PySCF<sup>[2]</sup> and ORCA<sup>[3]</sup> packages, respectively. All the multi-
configurational computations are performed in a black-box way with the help of
MOKIT<sup>[4]</sup>.

Currently we have not published the paper of MOKIT program. As for the content of
the reference, you should cite like  
[4] Jingxiang Zou, MOKIT program, https://gitlab.com/jxzou/mokit (accessed Jan 28, 2023).

where the "Jan 28" should be modified as the version you used. The version number
can be found by running `automr --version`, or simply `automr -v`. Note that citing
MOKIT only in the supporting information of a paper is insufficient, since such
citation can hardly be gathered by search engine or database.

If any of the keyword ist=0,1,3 (see Section 4.4.4) in program AutoMR is used,
citing the following two papers would be appreciated  
[2] J. Chem. Theory Comput. 2019, 15, 141-153. DOI: 10.1021/acs.jctc.8b00854  
[3] J. Phys. Chem. A 2020. DOI: 10.1021/acs.jpca.0c05216.

Besides, you need to CITE all quantum chemistry software packages called in your
AutoMR job(s). For example, the file `examples/automr/00-h2o_cc-pVDZ_1.5.gjf` is
a CASSCF job. 3 software packages will be called:  
(1) Gaussian will be called to perform RHF/UHF;  
(2) GAMESS will be called to perform GVB;  
(3) PySCF will be called to perform CASSCF.

Therefore, in this case you should also cite corresponding references of Gaussian,
GAMESS and PySCF, as well as possible references of electronic-structure methods
and basis sets. In the future version of MOKIT, there will be a Citation.txt file
generated after your computations terminated. You can simply copy citation infor-
mation in that plain text file.

You can use MOKIT to perform computations for other people. But remember to remind
he/she that MOKIT should be properly cited.

