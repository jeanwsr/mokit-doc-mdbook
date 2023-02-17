# 5.3 Examples of the utility `frag_guess_wfn`

## 5.3.1 Construct initial guess wave function from fragments
To be added.

## 5.3.2 Morokuma-EDA
The input file of H<sub>2</sub>O-NH<sub>3</sub> complex is shown below

```
%mem=16GB
%nprocshared=16
#p RHF/cc-pVDZ guess(fragment=2)

{morokuma}

0 1 0 1 0 1
N(fragment=1)    -1.67861672   -0.49374924   -0.00513612
H(fragment=1)    -1.39223602   -1.00824506    0.80312136
H(fragment=1)    -1.24821305    0.40883590    0.00449440
H(fragment=1)    -1.40093406   -0.98667606   -0.82970600
O(fragment=2)     0.68224018    0.74345713    0.00303850
H(fragment=2)     1.37946396    0.10226230   -0.15300059
H(fragment=2)     0.95548613    1.60139824   -0.32993853

```

This is clearly just a Gaussian .gjf file, and it looks very similar to two other
types of calculations: 1) fragment guess calculation in Section 5.3.1; 2) BSSE
calculation. The order of fragments is the same as that required in GAMESS. That
is to say, you must define atoms in the order of monomer 1, monomer 2, monomer 3,
etc. To conveniently add '(fragment=*N*)' in each row, you may need some advanced
text editor like Sublime Text 3, UltraEdit, VSCode, etc.

In Title Card line, `{morokuma}` must be written to tell the utility `frag_guess_wfn`
you want the input file of Morokuma-EDA. Currently Morokuma-EDA in GAMESS has several
restrictions:

(1) Only the RHF method can be used. ROHF, UHF or any DFT methods cannot be used.
Both the total system and every fragment should be treated with RHF. This means
broken bonds cannot be dealt with.

(2) Spherical harmonic functions cannot be used. The utility `frag_guess_wfn` will
automatically switch to Cartesian fucntions (i.e. 6D 10F) when calling Gaussian
to perform SCF computations.

Assuming the filename is nh3_h2o.gjf, you simply need to run
```
frag_guess_wfn nh3_h2o.gjf >nh3_h2o.out 2>&1
```

Since the molecule is small, you can obtain a file named `nh3_h2o.inp` in seconds.
MOs of two fragments will be written into this file. You can submit the file `nh3_h2o.inp`
to GAMESS for Morokuma-EDA computations. All SCF of fragments will converge in 1-2
cycles. The initial guess of orbitals of the total system (i.e. supermolecule) is
not written in .inp file, but constructed from fragments within GAMESS, and it is
supposed to be converged soon.

Simply replacing the `{morokuma}` by `{gks}` means you want the input file of GKS-
EDA. UHF and UDFT methods can be applied in GKS-EDA. Thus it is powerful, especially
when dealing with biradical system, where the symmetry broken UDFT calculations
are necessary. See the following section for more examples.

## 5.3.3 LMO-EDA
More details to be added.

## 5.3.4 GKS-EDA
To perform GKS-EDA calculations, you need the GAMESS program and xeda-patch script.
After you download the required packages, use the xeda-patch script to modify the
GAMESS source code. And then compile GAMESS in a usual way. Here is a tutorial
written in Chinese [《GKS-EDA计算简介》](https://mp.weixin.qq.com/s/6nuJpYJdNbUJndrYM13Fog).

Here I offer two examples to illustrate how to use the utility `frag_wfn_guess`
to generate the input file of GKS-EDA. The first example:
[Ti(H<sub>2</sub>O)<sub>6</sub>]<sup>3+</sup> cation, whose input file is shown
below

```
%mem=32GB
%nprocshared=16
#p UPBE1PBE/gen guess(fragment=2)

{gks}

3 2 3 2 0 1
Ti(fragment=1)       0.00000000       0.00000000       0.00000000
 H(fragment=2)       0.00000000       2.68428109      -0.78751709
 H(fragment=2)       2.68128062       0.78751744       0.00000000
 H(fragment=2)       0.00000000      -2.68428109       0.78751709
 H(fragment=2)       0.78751709       0.00000000      -2.68228109
 H(fragment=2)      -2.68128062       0.78751744       0.00000000
 H(fragment=2)      -0.78751709       0.00000000       2.68228109
 O(fragment=2)       0.00000000       2.10100000       0.00000000
 H(fragment=2)       0.00000000       2.68428109       0.78751709
 O(fragment=2)       0.00000000       0.00000000       2.09900000
 H(fragment=2)       0.78751709       0.00000000       2.68228109
 O(fragment=2)       0.00000000       0.00000000      -2.09900000
 H(fragment=2)      -0.78751709       0.00000000      -2.68228109
 O(fragment=2)       2.09800000       0.00000000       0.00000000
 H(fragment=2)       2.68128062      -0.78751744       0.00000000
 O(fragment=2)      -2.09800000       0.00000000       0.00000000
 H(fragment=2)      -2.68128062      -0.78751744       0.00000000
 O(fragment=2)       0.00000000      -2.10100000       0.00000000
 H(fragment=2)       0.00000000      -2.68428109      -0.78751709

Ti 0
def2TZVP
****
H O 0
def2SVP
****


```

Mixed basis set, user-defined basis set or ECP/PP are all supported. DO REMEMBER
to type at least 2 blank lines after the basis set data. The only exception of basis
set is that definition for each atom tag is unsupported. For example, the following
definition
```
1 0
def2TZVP
****
2 0
def2SVP
****
```

is currently NOT supported for utility `frag_guess_wfn`. Assuming the filename is
Ti.gjf, you simply need to run
```
frag_guess_wfn Ti.gjf &
```

in Bash Shell. Electronic energies of fragments will be directly printed onto the
screen. You can run instead
```
frag_guess_wfn Ti.gjf >Ti.out 2>&1 &
```

if you do not like things printed on screen. This example may take about 20 min
to generate the desired .inp file. Five SCF jobs will be performed in succession:

(1) monomer 1 in its own basis;  
(2) monomer 2 in its own basis;  
(3) monomer 1 in all basis;  
(4) monomer 2 in all basis;  
(5) supermolecule in all basis.

`frag_guess_wfn` will automatically construct the initial guess for job (5) using
MOs from job (1) and (2). This will save some time. After all 5 jobs normally terminated,
the utility `fch2inp` will be automatically called to transfer 5 sets of MOs from
Gaussian .fch files into one GAMESS .inp file. Proper keywords (including DFT name
in DFTTYP, solvent name and radii of solute atoms in $PCM, etc) have been written
in the generated .inp file. You can, of course, open this file and modify keywords
according to your needs (e.g. dispersion correction).

For HF methods, all 5 SCF jobs during GKS-EDA will converge in 1-2 cycles. While
for UDFT, they may take about 10 cycles since the DFT integral grids (and functional
implementation details possibly) in GAMESS are not identical to those in Gaussian.
Note that when using DFT methods, grid settings `$DFT NRAD=99 NLEB=590 $END` will
be automatically added into the .inp file, to mimic the `int=ultrafine` in Gaussian.
If implicit solvent model is also applied, each SCF will take more cycles, since
implementation details in GAMESS have differences with those in Gaussian (but the
energy usually steadily decreases).

You can write an alias into your `~/.bashrc` for convenience of running XEDA, for
example,
```
alias xeda='/home/jxzou/software/xeda/rungms'
```

Once the calculation of frag_guess_wfn is done (and you've modified keywords according
to your needs), you can simply run
```
xeda Ti.inp 00 16 >Ti.gms 2>&1 &
```

to perform the GKS-EDA calculation, where the 16 is the number of CPU cores for
parallel computation.

Then we come to the second example: the ethane molecule. Assuming we want to see
the interaction of two \\( \cdot \\)CH3 radicals, such fragmentation will involve
breaking a covalent bond, which leads to an alpha unpaired electron in one \\( \cdot \\)CH3
radical and a beta unpaired electron in another radical. In this case we need to
specify negative spin in the input file, which represents the beta spin:
```
%mem=4GB
%nprocshared=4
#p UHF/cc-pVTZ guess(fragment=2)

{gks}

0 1 0 2 0 -2
C(fragment=1)   -3.42837266    0.18776078    0.00000000
H(fragment=1)   -3.07171823   -0.82104923    0.00000000
H(fragment=1)   -3.07169982    0.69215897   -0.87365150
H(fragment=1)   -4.49837266    0.18777396    0.00000000
C(fragment=2)   -2.91503044    0.91371705    1.25740497
H(fragment=2)   -1.84503225    0.91200998    1.25838332
H(fragment=2)   -3.27008700    1.92309006    1.25642758
H(fragment=2)   -3.27329940    0.41044905    2.13105517

```

It is equivalent to interchange 2/-2. The coupling of an alpha unpaired electron
with a beta unpaired electron leads to the total spin singlet.

The GKS-EDA supports up to 20 fragments. For convenience only examples containing
two fragments are shown above.

## 5.3.5 SAPT
The utility `frag_guess_wfn` is also able to generate the input file of SAPT computation
in PSI4. Currently only SAPT0 (and sSAPT0) is supported. More advanced methods like
SAPT2+ and SAPT2+(3)\\( \delta \\)MP2 will be supported in the near future. Similarly,
`frag_guess_wfn` will first call the Gaussian to perform HF/DFT computations and
then generate the input file of SAPT job for PSI4. Be aware that SAPT cannot deal
with strong interactions come from two fragments by breaking covalent bonds (in
that case you should use the GKS-EDA method).

Here is a SAPT example:
```
%mem=16GB
%nprocshared=8
#p HF/jun-cc-pVDZ guess(fragment=2)

{sapt,bronze}

0 1 0 1 0 1
O(fragment=1)                 -1.90937854    1.06610853   -0.05598828
H(fragment=1)                 -2.23867796    0.17728177    0.09615925
H(fragment=1)                 -0.94953286    1.05932020   -0.04017097
N(fragment=2)                 -2.02042680   -1.64298230    0.34416157
H(fragment=2)                 -2.28323594   -1.98171649   -0.55927105
H(fragment=2)                 -2.67940800   -1.96304329    1.02482651
H(fragment=2)                 -1.10944265   -1.98408759    0.57601295

```

Using `frag_guess_wfn` to generate the sSAPT0 input file:
```
frag_guess_wfn h2o_nh3.gjf >h2o_nh3.log 2>&1
```

Submit the generated h2o_nh3.inp to PSI4:
```
psi4 h2o_nh3.inp h2o_nh3.out -n 16
```

Both of SAPT0 and sSAPT0 results can be found in output. The SAPT paper (JCP 140, 094106 (2014))
recommends three levels of theory to be used:

(1) *bronze*: sSAPT0/jun-cc-pVDZ;  
(2) *silver*: SAPT2+/aug-cc-pVDZ;  
(3) *gold*: SAPT2+(3)\\( \delta\\)MP2/aug-cc-pVTZ.

So far the open shell calculations have not been implemented for *silver* and *gold*
level in PSI4 (it is OK for sSAPT0). Currently only the *bronze* level is supported
in `frag_guess_wfn`. `{sapt}` or `{sapt,bronze}` in the Title Card line will be
recognized as the *bronze* level. You are always recommended to use jun-cc-pVDZ
unless there is some element which is out of the range of jun-cc-pVDZ.

## 5.3.6 Tricks for accelerations
For some simple fragments (water molecules, organic ligands, etc), if you are sure
that they have closed-shell wave function, you can append a character `r` after
the Cartesian coordinates of any atom of the fragment. Again, taking the
[Ti(H<sub>2</sub>O)<sub>6</sub>]<sup>3+</sup> cation as the example,

```
%chk=Ti.chk
%mem=32GB
%nprocshared=16
#p UPBE1PBE/gen guess(fragment=2)

{gks}

3 2 3 2 0 1
Ti(fragment=1)    0.00000000    0.00000000    0.00000000
 H(fragment=2)    0.00000000    2.68428109   -0.78751709 r
 H(fragment=2)    2.68128062    0.78751744    0.00000000
... (not shown)
```

This will force the use of R(O)HF calculation for this fragment, thus saving
computation time. After R(O)HF computation of this fragment is done, beta MOs
will be directly copied from alpha MOs, so the net result is that it appears to
perform a UHF computation, but with only R(O)HF cost.

If the `r` is not written, UHF and wave function stability test will be performed
for this fragment. In this special case we know that UHF is unnecessary for this
fragment.

This trick accelerates computations only when UHF/UDFT is required for the supermolecule
so that we can force some fragment(s) to use closed-shell methods. If restricted
HF or DFT methods are required for the supermolecule, this trick will not reduce
computational time.

