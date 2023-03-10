# 5.1 Examples of `automr`

## 5.1.1 Single point calculation of the ground state
The input file of `automr` is just the Gaussian .gjf file. For example, the ground state CASSCF calculation of a stretched molecule is shown as follows (h2o.gjf)
```
%mem=8GB
%nprocshared=4
#p CASSCF/cc-pVDZ

mokit{}

0 1
O      -0.23497692    0.90193619   -0.068688
H       1.26502308    0.90193619   -0.068688
H      -0.73568721    2.31589843   -0.068688

```

Submit the job
```
automr h2o.gjf >h2o.out 2>&1 &
```
After the calculation is accomplished, you can find in the output file that an active space CAS(4,4) is automatically determined. And the CASSCF natural orbitals (NOs) can be found in `h2o_uhf_gvb4_CASSCF_NO.fch`. The calculation will also print RHF, UHF, GVB and CASCI electronic energies since they are supposed to be intermediate steps in a CASSCF job.

The GVB NOs can be found in `h2o_uhf_uno_asrot2gvb4_s.fch`, in which the GVB active space contains 4 pairs of orbitals (O 2s lone pair, O 2p lone pair, and two O-H bonding orbitals as well as two O-H anti-bonding orbitals). The two pairs of O-H orbitals are of significant multireference characters, so they are automatically chosen as the active space for the further CASSCF(4,4) calculation. That is to say, by default the important GVB orbitals are used as the initial guess orbitals of CASCI/CASSCF calculations. The threshold for determining important GVB orbitals is *n*<sub>i</sub> >= 0.02, where *n*<sub>i</sub> is the occupation number of the 2nd natural orbital in a GVB pair.

If you want to use other methods instead of CASSCF, just replace the method name as GVB, CASCI, CASPT2, NEVPT2, MRMP2, MRCISD, MCPDFT, etc. To see all methods supported by `automr`, run `automr -h`.

If you want to use another quantum chemistry program for the CASSCF calculation (say Molpro), you need to write `mokit{CASSCF_prog=Molpro}`. Similarly, you can add 'GVB_prog=QChem' to call Q-Chem to perform the GVB calculation if you wish (By default, GVB_prog=GAMESS). For all programs supported, just run `automr -h`.

## 5.1.2 Single point calculation of an excited state
Currently only the automatic calculation of the State-Specific CASSCF (SS-CASSCF) is supported. For example, optimize the orbitals of the CASSCF S<sub>1</sub> state of a water molecule
```
%mem=8GB
%nprocshared=4
#p CASSCF/cc-pVDZ

mokit{root=1}

0 1
O      -0.23497692    0.90193619   -0.068688
H       1.26502308    0.90193619   -0.068688
H      -0.73568721    2.31589843   -0.068688

```

where `root=1` means the first excited state which has the same spin as the spin of the ground state. Several electronic states will be calculated and the S<sub>1</sub> state can be automatically tracked by `automr`, via checking the spin of each state. To calculate the S<sub>2</sub>  state, just specify `mokit{root=2}`.

For T<sub>1</sub> state, you need to write `mokit{root=1,Xmult=3}`, where `Xmult` means the spin multiplicity of the target excited state. Of course, we know that the T<sub>1</sub> state can be calculated in a easier way: we can just perform a ground state calculation with spin mmultiplicity 3. So this functionality is useful for S<sub>1</sub>, S<sub>2</sub>, T<sub>2</sub> or higher states.

The State-Averaged CASSCF (SA-CASSCF) calculation is under development. To give it a shot, you can try `mokit{nstates=2}` for an average of S<sub>0</sub>, S<sub>1</sub>, and S<sub>2</sub> states. To mix electronic states with different spins, you need `mokit{nstates=2,Mix_Spin}`.

## 5.1.3 MRCISD calculation of the ground state
To be added.

## 5.1.4 Acceleration techniques
To speed up the calculation for a large molecule and/or a large basis set, one can add `RI` to enable the Resolution-of-Identity (RI) techniques whenever possible. For example,
```
%mem=16GB
%nprocshared=16
#p CASSCF(6,6)/cc-pVTZ

mokit{RI}

0 1
[Cartesian coordinates of benzene]
```
The RI-JK will be enabled in the CASSCF calculation and the auxiliary basis set are automatically dealt with.

To perform the NEVPT2 calculation for a large molecule, you can use the local correlation method DLPNO-NEVPT2 in ORCA, e.g.
```
%mem=96GB
%nprocshared=48
#p NEVPT2(6,6)/cc-pVTZ

mokit{CASSCF_prog=ORCA,NEVPT2_prog=ORCA,DLPNO}
...
```

