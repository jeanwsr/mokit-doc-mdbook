# Dependency on QC Programs

## Minimal requirements

Dependencies on quantum chemistry packages are different for each executable or module. Here the minimum requirements for binary executables `automr`, `frag_guess_wfn` and other various are listed:
1. `automr`: Gaussian, GAMESS, PySCF
2. `frag_guess_wfn`: Gaussian
3. Most of the utilities do not depend on quantum chemistry packages except that the modules `py2gau`, `py2orca`, `py2molpro`, etc, work with PySCF installed.

### Setup Gaussian and PySCF

Usually there are no special requirements on setup. Read [Section 2.3.6](./chap2-3.md#236-notes-on-quantum-chemistry-packages) and [FAQs](./chap_appdx.md#a1-frequently-asked-questions-faq) if you have trouble calling them with MOKIT.

### Modify and Setup GAMESS

Note that the original GAMESS code can only deal with GVB <=12 pairs. But nowadays we can do hundreds of pairs. It is required by MOKIT to modify GAMESS to go beyond 12 pairs. See instructions in [Section 4.4.10](./chap4-4.md#4410-gvb_prog).

## Setups for calling other QC programs

See [Section 2.3.3](./chap2-3.md#233-environment-variables) and [Section 2.3.6](./chap2-3.md#236-notes-on-quantum-chemistry-packages).


