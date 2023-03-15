# 5.8 Examples of `autosr`
The utility `autosr` is designed for automatic single reference calculation. Currently supported methods are CCD, CCSD, CCSD(T), DLPNO-CCSD, DLPNO-CCSD(T), DLPNO-CCSD(T1). Supported basis sets are cc-pV*n*Z, aug-cc-pV*n*Z, and the def2- series. The RI technique is turned on by default in MP2 or CC calculations. By default, `HF_prog=Gaussian`.

## 5.8.1 DLPNO-CCSD(T1) calculation using ORCA
The input file of `autosr` is just the Gaussian .gjf file. For example, the DLPNO-CCSD(T1) calculation of a water molecule is shown as follows (h2o.gjf)
```
%mem=20GB
%nprocshared=4
#p DLPNO-CCSD(T1)/cc-pVTZ

mokit{}

0 1
O   2.72506079   -0.54744525    0.0
H   3.68506079   -0.54744525    0.0
H   2.40460620    0.35749058    0.0

```

Submit the job
```
autosr h2o.gjf >h2o.out 2>&1 &
```

By default, the HF calculation will be performed by calling Gaussian, and the DLPNO-CCSD(T1) calculation will be performed by calling ORCA. The auxiliary basis set of cc-pVTZ are automatically dealt with by `autosr`. You are supposed to write the memory as large as possible since post-HF jobs usuallty needs a lot of memory. The `%maxcore` in ORCA input file will be the total memory multiplied by 0.8 and divided by the number of processors.

## 5.8.2 CCSD(T) calculation using Molpro
See an example
```
%mem=20GB
%nprocshared=4
#p CCSD(T)/cc-pVTZ

mokit{CC_prog=Molpro}

0 1
O   2.72506079   -0.54744525    0.0
H   3.68506079   -0.54744525    0.0
H   2.40460620    0.35749058    0.0

```

By default, the RI technique is turned on and the auxiliary basis set of cc-pVTZ are automatically dealt with, so this is in fact a DF-CCSD(T) calculation.

