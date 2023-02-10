# 4.1 Syntax Rules of `automr`
Syntax rules of the input file of `automr` is almost identical to those of Gaussian software. Therefore, it takes little time to become familiar with the usage of `automr`. A simple input (.gjf) example is shown below
```
%mem=4GB
%nprocshared=2
#p CASSCF/cc-pVDZ

mokit{}

0 1
O      -0.23497692    0.90193619   -0.068688
H       1.26502308    0.90193619   -0.068688
H      -0.73568721    2.31589843   -0.068688
```
This is a water molecule with two O-H bonds stretched. CAS(4,4) active space will be automatically determined during computations. One can also provide a .fch(k) file if he/she already performed a UHF job. An example is shown below
```
%mem=4GB
%nprocshared=4
#p CASSCF/cc-pVTZ

mokit{ist=1,readuhf='N2_cc-pVTZ_4.0_uhf.fchk'}
```
For the memory and parallel settings, please read Section 4.2. For the theoretical method and basis set, please read Section 4.3. Here we focus on the keywords in mokit{}.

1. All keywords must be written in the curly bracket of `mokit{}` in the Title Card line of a .gjf file.

2. Using upper or lower case of keywords in `automr` makes no difference. For example,
the following two lines have identical meanings:
`MOKIT{readuhf='a.fchk',ist=1,LocalM=Boys}`  
`mokit{readuhf='a.fchk',ist=1,localm=boys}`

3. If `readrhf`, `readuhf`, or `readno` keyword is used, a filename of the provided .fch(k) file must be included in a pair of single quotation marks `''`. Do not use double quotation marks `""` or no quotation marks.

4. If pure Cartesian functions of basis set are used in the provided .fch(k) file, you need to write keyword `cart`. The default is pure spherical harmonic functions. And you do not need to write any keyword about this if you provide a .fch(k) file in which pure spherical harmonic functions are used.

5. Use a comma to separate different keywords. Do not use other symbols (like spacing).

