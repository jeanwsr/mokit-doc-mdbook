# Appendix


Here we provide a brief outline of all frequently asked questions, limitations and suggestions. 

You can also use the &#128269; tool in the left upper corner of this page to search the whole manual for your questions. 

If any of those cannot solve your problem, please consider [Bug report](#a3-bug-report).


| Error messages | | |
| --- | --- | --- |
| [command not found!](#q1-command-not-found) / [cannot open ...](#q1-command-not-found) | [OpenMolcas: Error in keyword](#q5-error-in-keyword-when-calling-openmolcas) | [executable paths of Gaussian, etc.](#q6-executable-paths-of-gaussian-etc) |
| [GAMESS: ERROR DIMENSIONS EXCEEDED](#q7-error-dimensions-exceeded) | [GAMESS: semget errno=ENOSPC](#q8-gamess-semget-errnoenospc) | [GAMESS: floating point error (SIGFPE)](#q9-gamess-floating-point-error-sigfpe) |
| [PySCF: has no attribute mo_occ](#q10-pyscf-has-no-attribute-moocc) | [PySCF: No such file block.spin_adapted](#q11-pyscf-no-such-file-blockspinadapted) | [OpenMolcas: Error detected in HDF5](#q12-openmolcas-error-detected-in-hdf5) |
| [Syntax error: Bad fd number](#q14-syntax-error-bad-fd-number) | [Warning for OMP_STACKSIZE](#q15-warning-for-ompstacksize) | [GKS-EDA: Warning for redial grid](#q16-gks-eda-warning-for-redial-grid) | 
| [Psi4: h5py Error](#q17-psi4-h5py-error) | [PySCF: No module named h5py](#q18-pyscf-no-module-named-h5py) | [GKS-EDA: SCF fail](#q20-gks-eda-scf-fail) |

Note: not all the error messages shows on screen, they may be found in program log files (usually MOKIT will print a message on screen to suggest you checking those files).

| Other questions | | |
| --- | --- | --- |
| [pre-compiled version?](#q2-pre-compiled-version)  | [why orb2fch requires a fch?](#q3-why-orb2fch-requires-a-fch) | [support more programs?](#q4-support-more-programs) |
| [is density in fch correct?](#q13-is-density-in-fch-correct) | [automr takes more time than manual computation?](#q19-automr-takes-more-time) | [my computation so slow!](#q21-my-computation-so-slow) |

</br>

| Limitations and Suggestions | | |
| --- | --- | --- |
| [Basic knowledge of multi-reference methods](#a21-basic-knowledge-of-multi-reference-methods) | [Symmetry](#a22-symmetry) | [Excited State Calculations](#a23-validity-of-mos-obtained-by-automr-for-excited-state-calculations) |
| [Possible Multiple Solutions of UHF](#a24-possible-multiple-solutions-of-uhf) | [Implicit Solvent Model](#a25-implicit-solvent-model) |


## A1 Frequently Asked Questions (FAQ)

### Q1: command not found
Find errors like `xxx: command not found`. What is the solution?

A1: This is simply because you haven't installed the corresponding software, or you didn't write environment variables correctly. Four examples are shown below:

Example 1 (during compilation): error `ifort: command not found` means there is no ifort compiler on your computer, 
see [Section 2.3.1 Prerequisite](./chap2-3.md#231-prerequisite) for details.

Example 2 (during compilation): error `-bash: f2py: command not found` means there is no f2py on your computer, 
see [Section 2.3.1 Prerequisite](./chap2-3.md#231-prerequisite) for details.

Example 3 (during execution): assuming you've compiled MOKIT successfully, but got the `-bash: automr: command not found`
error. Then you should check the MOKIT paths in your ~/.bashrc. 
See [Section 2.3.3 Environment variables](./chap2-3.md#233-environment-variables) for details.

Example 4: errors like `/usr/bin/ld: cannot find -lmkl_rt`, `ld: cannot find -lmkl_intel_lp64` (during compilation) or `error while loading shared libraries: libxxx.so: cannor open ...` (during execution)
have two possible reasons: (1) there is no MKL installed on your computer; (2) there
is MKL on your node but you did not correctly (or you forgot to) write environment
variables of MKL. See [Section 2.3.1 Prerequisite](./chap2-3.md#231-prerequisite) and [Section 2.3.3 Environment variables](./chap2-3.md#233-environment-variables) for details.


### Q2: pre-compiled version
Is there any Windows/Mac OS pre-compiled or pre-built version of MOKIT?

A2: The author offers more than 20 utilities of Windows* OS pre-built executables, which are released as a .zip file. See instructions for download and setting environment variables in [Section 2.1](./chap2-1.md).

The `automr` module is not included in pre-compiled executables, since multi-reference calculations are usually performed on high-performance computers/platforms, which usually contain Unix/Linux systems. However, if you really need all modules or utilities under Windows, you can compile the source code on your laptop/computer/node by yourself.

For Linux/MacOS pre-built version, see [Section 2.2](./chap2-2.md)


### Q3: why orb2fch requires a fch
Why the utilities `dat2fch`, `py2fch`, `mkl2fch`, `orb2fch`, `xml2fch`, `bdf2fch`
and `bdf2mkl` cannot generate a .fch file from scratch, but require the user to
provide one?

A3: Strictly speaking, to correctly transfer MOs between different programs requires 'int=nobasistransform nosymm' (and also possibly '5D 7F' or '6D 10F') keywords in Gaussian, and equivalent keywords in other quantum chemistry programs. This rule also applies to other programs/software which claim they can transfer MOs or support file transformation.

However, the utility/subroutine (which transfers MOs) cannot detect whether the users have truly specified 'int=nobasistransform nosymm' (and also possibly '5D 7F' or '6D 10F') keywords, or equivalent keywords in other programs. Then transferring MOs in such case is very dangerous, i.e. correctness cannot be assured. For example, using the built-in basis sets in other programs instead of basis sets generated by MOKIT is dangerous, since the built-in basis sets in other programs are generally not exactly identical to those generated by MOKIT.

Therefore, the author jxzou has to require the users to provide a .fch file, to remind the users that proper keywords must be used in Gaussian. And the most recommended approach is to use utilities in MOKIT (e.g. fch2inp, bas_fch2py, etc) to generate input files of other quantum chemistry programs. The users use these generated input files to perform their desired computations. After jobs finished, use dat2fch and py2fch to transfer MOs back to the .fch file. Such an approach is already applied in `automr`.

In the future version of MOKIT, the utility xml2fch will not require the user to provide a .fch file.


### Q4: support more programs
Can MOKIT support more types of files? Transferring MOs between other programs like
NWChem or BAGEL is possible?

A4: The MOKIT developers wish to make the MOKIT recognize all kinds of MO files of
quantum chemistry programs, but they are not likely to be familiar with all programs.
Therefore, if you are very familiar with any program (other than supported ones in
MOKIT), and you happens to need a transferring of MOs, please contact MOKIT developers
and tell the information in the MO file of that program. With the help from experienced
users, the development will be much easier and quicker.


### Q5: OpenMolcas: Error in keyword
Why there is a keyword error in OpenMolcas output when using DKH2 Hamiltonian? Two possible errors are given: (1) ERROR: RELATIVISTIC is not a keyword!, Error in keyword. (2) ERROR: R02O is not a keyword!, Error in keyword.

A5: This is due to a recent update of OpenMolcas. If version <= 18.09, the keyword
for DKH2 is simply `R02O`; but for version >=20.10, this keyword become `RELAtivistic = R02O`.
For version >18.09 and <20.10, the author jxzou has no manual and thus it is not
tested (but you can test if you like).

If you encounter any of the two errors, you have two choices: (1) update your OpenMolcas
to a newer version, e.g. >=20.10; (2) modify the source code of MOKIT and re-compile
it. If you choose (2), you will need to modify the words `RELAtivistic = R02O` to
`R02O` in file `src/automr.f90`, and run `make automr` in Shell to re-compile the
program automr.


### Q6: executable paths of Gaussian, etc.
How does `automr` read the executable paths of Gaussian, OpenMolcas, PySCF, ORCA, and GAMESS?

A6: For Gaussian, the paths of executable files are read from the environment variables
`$GAUSS_EXEDIR`. For PySCF and OpenMolcas, the `python` and `pymolcas` executable
are used directly, assuming the user had installed the corresponding programs correctly.
For ORCA, the absolute path is automatically obtained from echo `which orca`. For
GAMESS, the user must define the `$GMS` environment variable in his/her `~/.bashrc` file,
such that the automr program can find corresponding paths.


### Q7: GAMESS: ERROR DIMENSIONS EXCEEDED
What are the possible reasons and solutions of the following errors
```
(1) '***** ERROR **** DIMENSIONS EXCEEDED *****'
(2) 'PAIR=   xx MAX=   12'
(3) 'DDI Error: Could not initialize xx shared memory segments.'
(4) 'DDI was compiled to support 32 shared memory segments.'
(5) 'The GAMESS executable gamess.01.x or else the DDIKICK executable ddikick.x
could not be found in directory ...'
```
in GAMESS .gms file (where xx is an integer >12)?

A7: Please read Section 4.4.10 carefully.


### Q8: GAMESS: semget errno=ENOSPC 
Errors like `semget errno=ENOSPC -- check system limit for sysv semaphores`
found in the .gms file. Why? How to solve the problem?

A8: Please search the error on this page FAQ of GAMESS.


### Q9: GAMESS: floating point error (SIGFPE)
I found the error `DDI Process 0: trapped a floating point error (SIGFPE).`
How to solve it?

A9: See this page https://github.com/gms-bbg/gamess-issues/issues/40.


### Q10: PySCF: has no attribute mo_occ
I found the following error
```
AttributeError: 'CASSCF' object has no attribute 'mo_occ'
```
in PySCF output (e.g. .out file). Why? How to solve the problem?

A10: This is because you were using PySCF version < 1.7.4, which has no mo_occ attribute in CASSCF object. Please update to PySCF >=1.7.4.


### Q11: PySCF: No such file block.spin_adapted
I found the following error
```
FileNotFoundError: [Errno 2] No such file or directory: '/path/to/Block/block.spin_adapted'
```
in PySCF output (e.g. .out file). Why? How to solve the problem?

A11: This is because you forgot to modify pyscf/dmrgscf/settings.py. You should copy file settings.py.example and rename it as settings.py. Then set the correct path (within the file) for the DMRG solver.


### Q12: OpenMolcas: Error detected in HDF5
I found the following error
```
HDF5-DIAG: Error detected in HDF5 (1.12.0) thread 0:
#000: H5D.c line 435 in H5Dget_type(): invalid dataset identifier
major: Invalid arguments to routine
minor: Inappropriate type
```
occurs many times in OpenMolcas output, Why? How to solve the problem?

A12: This does not affect the computations. It is just a tiny bug of old versions of OpenMolcas if the QCMaquis support is compiled but not used. You can find this problem here. It is recommended to update your OpenMolcas to the latest version.


### Q13: is density in fch correct?
Is 'Total SCF Density' in `*_NO.fch` file correct? Can it be used to perform wave function analysis?

A13: Yes. The CASCI/CASSCF total densities are correct in generate `*_NO.fch` files. Besides, the GVB density is in `*_s.fch` file, and the UHF density are both in `*_uhf.fch` and `*_uno.fch` files. Other types of `*.fch` files (`*_asrot.fch`, etc) do not have well-defined density. Density and natural orbitals are not calculated for post-CASSCF methods (NEVPT2, CASPT2, MRCISD, etc).


### Q14: Syntax error: Bad fd number
I found the error `sh: 1: Syntax error: Bad fd number` on the terminal/screen.
Why? How to solve the problem?

A14: This often occurs on Ubuntu* OS, where the default sh is `/bin/dash`, not `/usr/bin/bash`.
Please read Section 2.2.4 for details and examples.


### Q15: Warning for OMP_STACKSIZE
I found the following warnings on terminal/screen, or output of `automr`:
```
OMP: Warning #181: OMP_STACKSIZE: ignored because KMP_STACKSIZE has been defined
```
Why? How to make it disappear?

A15: This is simply because both OMP_STACKSIZE and KMP_STACKSIZE environment variables are set. You can comment/delete one of them. Usually you can find these two environment variables in your ~/.bashrc file, or in file bdf-pkg/sbin/run.sh (if you use the BDF program).


### Q16: GKS-EDA: Warning for redial grid
When using the utility `frag_guess_wfn` to generate GKS-EDA input files, there
is a warning (see below) in the GAMESS output file (e.g. xxx.gms file). And SCF
does not converge. How to deal with that?

```
          **************************************************
          *                                                *
          * WARNING: QUESTIONABLE SELECTION OF RADIAL GRID *
          *                                                *
          **************************************************

 THIS RUN HAS REQUESTED NRAD=  99 IN $DFT OR $TDDFT
 ATOM=   63 HAS LARGE EXPONENT=        565073.253000000026077
 RECOMMEND NRAD ABOVE  50 FOR ZETA'S ABOVE 1E+4
 RECOMMEND NRAD ABOVE  75 FOR ZETA'S ABOVE 1E+5
 RECOMMEND NRAD ABOVE 125 FOR ZETA'S ABOVE 1E+6
```

A16: As you can see in the screenshot above, GAMESS thinks your radial grid is
insufficient for this molecule and recommends the minimum requirement. So, all
you need to do is: modify the radial grid in the .inp file to the recommended value.
For example, in this example, you should modify NRAD0=99 and NRAD=99 in the .inp
file to (at least) NRAD0=126 and NRAD=126,respectively.


### Q17: Psi4: h5py Error
I found the following error in output of running automr
```
File "h5py/h5.pyx", line 183, in h5py.h5.H5PYConfig.default_file_mode.__set__
ValueError: Using default_file_mode other than 'r' is no longer supported. Pass the mode to h5py.File() instead.
```
How to solve the problem?

A17: Please check whether your current python is the PSI4 python by running `which python`
in Shell. If yes, and if you do not have to use PSI4 currently, you are recommended
to comment/deactivate PSI4's environment variables and use your previous Python
(e.g. Anaconda Python 3).


### Q18: PySCF: No module named h5py
I found the following error in output of running automr
```
  File "/home/jxzou/software/pyscf-2.0.1/pyscf/lib/misc.py", line 31, in <module>
    import h5py
ModuleNotFoundError: No module named 'h5py'
```
How to solve the problem?

A18: If you are using python and f2py from PSI4 package, rather than python from
Anaconda Python 3, you may encounter this PySCF error. One possible solution is
to comment PSI4 variables and write this variable `export PSI4=...` (see Section 2.2.3).
Then exit the terminal and re-login, and you now you are using your previous python,
e.g. Anaconda Python 3. Next you should run make distclean and make all to re-compile
MOKIT.


### Q19: automr takes more time than manual computation?
Is it possible that `automr` takes more (computational) time than that by manually doing multi-reference computations (by chemical intuition, manual inspection, etc) ?

A19: Yes, possible. Note that for some small and well-studied molecules, manually doing multi-reference computations (by chemical intuition, manual inspection, etc) may take less (computational) time than `automr`. But for general molecules, especially with dozens/hundreds of possible active orbitals, manual inspection is tedious and sometimes chemical intuition is unreliable. `automr` aims at tackling general and complicated cases.

Besides, to better compare the cost (of time) between the human and automatic approach, the cost of time of human operations must be taken into consideration, since the time of manual inspection and permuting orbitals (when >10 orbitals) is not negligible.

### Q20: GKS-EDA: SCF fail
Why does the GKS-EDA jobs fail even if I used the utility frag_guess_wfn to generate GAMESS .inp file?

A20: Try to modify 'DIIS=.F. SOSCF=.T.' to 'DIIS=.T. SOSCF=.F.' in the .inp file, and re-submit the job (remember to remove temporary files before re-submitting).

### Q21: my computation so slow!
Why does my computation proceed slowly? It took a long time in HF and GVB calculations. Is there any acceleration techniques/tricks?

A21: Firstly, please read Section 3.1 and 3.2 for suggestions on choosing appropriate methods and basis sets. Secondly, assuming your method and basis set is already reasonable, there is no trick to be used currently. The HF step is performed by Gaussian and it does not support RI or density fitting techniques. In the future version of MOKIT, users can specify PSI4 as the HF_prog, where RI is supported. The author jxzou will write a RI-GVB program in a year, then the GVB computation can be greatly accelerated.

## A2 Limitations and Suggestions
### A2.1 Basic knowledge of multi-reference methods
Although MOKIT is a useful tool for black-box multi-reference computations, the
users are assumed to know basic knowledge of multi-reference methods. If he/she
does not even know the meaning of CAS(m,n), then the results of MOKIT are meaningless
to he/she, and even wrong explanations may be made from the results. Therefore,
if you know little about the multi-reference methods, I recommend you the following
materials:

(1) the ORCA [CASSCF-tutorial](https://orcaforum.kofo.mpg.de/app.php/dlext/?cat=4),
which is a quickstart guide (but also detailed) for CASSCF computations. To download
this .pdf file, you may need to (register and) login to the forum.  
(2) to be added.

If, unfortunately, you are forced by your supervisor/advisor to learn how to perform
multireference calculations, but meanwhile you are a totally newbie and you don't
even know how to perform routine DFT calculations, it is recommended that you change
a task/project as soon as possible (ASAP). Or more radically, you are encouraged to
switch to a new supervisor ASAP, since he/she does not know how to teach/train a
student properly. This is not your fault, but your supervisor's.

### A2.2 Symmetry
Unfortunately, molecular point group symmetry cannot be taken into consideration in any module of MOKIT. This is due to: (1) use of symmetry may change the orientation of the target molecule, and the MO coefficients will be changed accordingly; (2) localized orbitals are used in almost all modules of `automr`, this usually contradicts with symmetry.

### A2.3 Validity of MOs obtained by `automr` for excited state calculations
When you use `automr` to perform a ground state CASSCF calculation, the obtained CASSCF MOs (whether pseudo-canonical MOs or NOs) is supposed to be excellent for the ground state electronic structure of the target molecule. And you can use this set of MOs (held in a .fch file) to further conduct excited state calculations like state-averaged CASSCF (SA-CASSCF). And moreover, NEVPT2, CASPT2 or MRCISD, if you wish.

However, the resulting excitation energies and excited state MOs (e.g. state-averaged NOs) are not necessarily excellent. Here 'not necessarily excellent' means for some molecules you may get good results while may be unsatisfactory for some other molecules. The reason is simple: the current algorithms in `automr` focus on the multi-reference characters in the ground state of the molecule. Thus `automr` 'finds' excellent active orbitals of the ground state. But the active orbitals of excited states are not necessarily the same as those of the ground state. And the orbital optimization in SA-CASSCF does not guarantee leading to good MOs for excited states. This problem actually exists in almost all methods/programs which feature black-box or automatic multi-reference calculations.

There is a solution (although not perfect or elegant) to this problem: (visually) inspect the doubly occupied orbitals, pick up important orbitals (usually the lone-pair orbitals) and add them into the active space. For example, if you obtain a CAS(6e,6o) active space from MOKIT, and assuming you find 4 lone pair orbitals among doubly occupied orbitals, then you can combine them (by interchanging or permuting orbitals) to be a CAS(14e,10o) active space. Because `6+2*4=14` active electrons, and 6+4=10 active orbitals. You can do a SA-CASSCF(14e,10o) computation next. This usually converges in several cycles. Finally you can perform a NEVPT2/CASPT2/MRCISD computation based on SA-CASSCF(14e,10o) orbitals to get more accurate excitation energies.

### A2.4 Possible multiple solutions of UHF
There may exist multiple UHF solutions when a covalent bond cleavages homolytically, or in a transition-metal-containing molecule. In these special cases, if you use ist=0, the UHF calculated by `automr` may be not the lowest UHF solution (but it is stable). You may need to perform several UHF computations (by yourself) using various initial guesses. After you identify the lowest UHF solution, you can use keywords ist=1 and `readuhf` to read in the desired UHF .fch file.

Alternatively, you can simply write the fragment guess information into the .gjf file, exactly as the syntax of Gaussian. See an example in file examples/automr/05-N2_cc-pVTZ_4.0.gjf.

Peter Pulay et al suggests that for cases involving multiple UHF solutions, one should use the averaged density (of all possible solutions) to generate UNOs. This approach is not supported in MOKIT currently.

### A2.5 Implicit Solvent Model
Currently implicit solvent effect cannot be taken into consideration. But you can use the converged CASSCF wave function `*_NO.fch` file as an initial guess to your further calculations which takes implicit solvent effect into consideration.

## A3 Bug Report
If you find any bug frequently occurs, please go to [MOKIT GitLab](https://gitlab.com/jxzou/mokit)
to download the latest version of MOKIT and check whether the bug still exists.
If it still exists, you can  
(1) contact the author jxzou via E-mail njumath[at]sina.cn, with your input file
(.gjf, .fch) and output files attached;  
(2) open an [issue](https://gitlab.com/jxzou/mokit/-/issues) on the GitLab page
of MOKIT;  
(3) (if you can communicate in Chinese) you can join the Tencent QQ group (Group
ID: 470745084).

## A4 Acknowledgement
Thanks to all MOKIT developers and users for constructive suggestions, bugs report and contributions.

