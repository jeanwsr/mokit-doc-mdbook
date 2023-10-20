## 3.1 Quick Start with Examples

* Each utility is self-explanatory. For example, run `fch2inp` in Shell, you will find
```
 ERROR in subroutine fch2inp: wrong command line arguments!  
 Example 1 (R(O)HF, UHF, CAS): fch2inp a.fch  
 Example 2 (GVB)             : fch2inp a.fch -gvb [npair]  
 Example 3 (ROGVB)           : fch2inp a.fch -gvb [npair] -open [nopen]
```
You can search a utility and read the documentations in [Section 4.5](./chap4-5.md) or [4.6](./chap4-6.md).

* The input syntax of the `automr` program is like Gaussian gjf. For example, the input file `00-h2o_cc-pVDZ_1.5.gjf` of the water molecule at d(O-H) = 1.5 A is shown below
```
%mem=4GB
%nprocshared=4
#p CASSCF/cc-pVDZ

mokit{}

0 1
O      -0.23497692    0.90193619   -0.068688
H       1.26502308    0.90193619   -0.068688
H      -0.73568721    2.31589843   -0.068688
```

Run
```
automr 00-h2o_cc-pVDZ_1.5.gjf >& 00-h2o_cc-pVDZ_1.5.out
```
in Shell. The `automr` program will successively perform HF, GVB, and CASSCF computations. The active space will be automatically determined as (4,4) during computations. Detailed instructions for `automr` input can be found in [Section 4.1 - 4.4](./chap4-1.md).

See more examples in `examples/` of source code. More details to be added.

