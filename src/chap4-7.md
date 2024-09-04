# Methods and Keywords in `autosr`

## 4.7.1 Methods in `autosr`

### 4.7.1.1 MP2, RI-MP2
```
%mem=4GB
%nprocshared=2
#p MP2/cc-pVTZ

mokit{noRI}

0 1
O     0.000000    0.000000    0.062007
H     0.000000   -0.783976   -0.492052
H     0.000000    0.783976   -0.492052
```

Different keywords in the Title Card Line can be applied:

(1) RI-MP2: `mokit{}`.
(2) MP2 NO using unrelaxed density: `mokit{noRI,NO}`.
(3) MP2 NO using relaxed density: `mokit{noRI,NO,relaxed_dm}`.
(4) RI-MP2 NO using unrelaxed density: `mokit{NO}`.
(5) RI-MP2 NO using relaxed density: `mokit{NO,relaxed_dm}`.
(6) MP2 analytical gradients: `mokit{noRI,force}`.
(7) RI-MP2 analytical gradients: `mokit{force}`.

### 4.7.1.2 CCD, CCSD, CCSD(T), CCSD(T)-F12
```
%mem=4GB
%nprocshared=2
#p CCSD(T)/cc-pVTZ

mokit{noRI}

0 1
O     0.000000    0.000000    0.062007
H     0.000000   -0.783976   -0.492052
H     0.000000    0.783976   -0.492052
```

Other cases like:
```
#p CCSD(T)/cc-pVTZ

mokit{noRI,CC_prog=Molpro,NO}
```

```
#p CCSD/cc-pVTZ

mokit{noRI,CC_prog=PySCF,force}
```

### 4.7.1.3 DLPNO methods
```
%mem=4GB
%nprocshared=2
#p DLPNO-CCSD(T1)/cc-pVTZ

mokit{}

0 1
O     0.000000    0.000000    0.062007
H     0.000000   -0.783976   -0.492052
H     0.000000    0.783976   -0.492052
```

Other cases like:
```
#p MP2/cc-pVTZ

mokit{DLPNO,NO,relaxed_dm}
```

```
#p MP2/cc-pVTZ

mokit{DLPNO,force}
```

### 4.7.1.4 EOM-CCSD, IP-EOM-CCSD, EA-EOM-CCSD
To be documented.

## 4.7.2 Keywords in `autosr`

There are quite a few keywords that do the same thing here as in `automr`, as follows

`readrhf`, `readuhf`, `Cart`, `DKH2`, `X2C`, `charge`

Search them in [Section 4.4](./chap4-4.md) for their usage.

### 4.7.2.1 Sepcify programs for each step

#### HF_prog
Supported programs are Gaussian/PySCF/PSI4/ORCA.

#### MP2_prog
Supported programs are Molpro/Gaussian/PySCF/PSI4/ORCA/QChem/OpenMolcas.

#### CC_prog
Supported programs are Molpro/Gaussian/PySCF/PSI4/ORCA/QChem/OpenMolcas.

| feature | supported programs |
| --- | --- |
| CCSD energy | all |
| CCSD unrelaxed DM | Molpro/PySCF/PSI4/ORCA/QChem/OpenMolcas |
| CCSD force | Molpro/PySCF/Gaussian/PSI4/QChem |
| CCSD relaxed DM | Molpro/Gaussian/PSI4/QChem |
| CCSD(T) energy | all |
| CCSD(T) unrelaxed DM | Molpro |
| CCSD(T) force & relaxed DM | Molpro/PSI4 |

#### ADC_prog
To be documented.

#### EOM_prog
Supported programs are Molpro/Gaussian/PSI4/ORCA/QChem.

### 4.7.2.2 Nstates
To be documented.

### 4.7.2.3 RI settings

#### NoRI
Request to turn off the RI acceleration technique.

#### RIJK_bas
Specify the RI-JK auxiliary basis set.

#### RIC_bas
Specify the RI-C auxiliary basis set.

### 4.7.2.4 

#### F12
To be documented.

#### F12_cabs
To be documented.

### 4.7.2.5 DLPNO
To be documented.

### 4.7.2.6 
#### NO
This keyword requests the generation of Natural Orbitals(NOs) in a post-HF calculation. The NOs will be stored in a file like `xxx_NO.fch`, which can be visualzied using GaussView or Multiwfn. By default NOs will not be generated. If you want NOs, do not write `mokit{NO=True}` but simply write `mokit{NO}`. See the next keyword for using relaxed or unrelaxed density to generate NOs.

#### Relaxed_DM
Generate NOs using the relaxed density or unrelaxed density.

### 4.7.2.7 Force
This keyword requests the calculation of analytical nuclear gradients.

### 4.7.2.8 Miscellaneous
#### FC
Control the number of frozen core orbitals in a post-HF calculation. By default, the number of frozen core orbitals is equal to settings in ORCA manual `9.11 Frozen Core Options`. For example, if we perform a post-HF calculation for a water molecule, `FC=1` will be automatically set and the user does not need to take care of this. If you want no frozen core, write `mokit{FC=0}`.

