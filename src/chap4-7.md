# Methods and Keywords in `autosr`

## 4.7.1 Methods in `autosr`

### 4.7.1.1 MP2, RI-MP2
To be documented.

### 4.7.1.2 CCD
To be documented.

### 4.7.1.3 CCSD, CCSD(T), CCSD(T)-F12
To be documented.

### 4.7.1.4 DLPNO-CCSD, DLPNO-CCSD(T), DLPNO-CCSD(T1)
To be documented.

### 4.7.1.5 EOM-CCSD, IP-EOM-CCSD, EA-EOM-CCSD
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

#### ADC_prog
To be documented.

#### EOM_prog
Supported programs are Molpro/Gaussian/PSI4/ORCA/QChem.

### 4.7.2.2 Nstates
To be documented.

### 4.7.2.3 RI settings

#### NoRI
To be documented.

#### RIJK_bas
To be documented.

#### RIC_bas
To be documented.

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

