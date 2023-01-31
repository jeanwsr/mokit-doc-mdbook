# 2.3 Installation under Linux

## 2.3.1 Prerequisite
1. Fortran compiler: `ifort`(>=2017) or `gfortran`(>=4.8.5)
2. Intel MKL(recommended) or [OpenBLAS](https://github.com/xianyi/OpenBLAS)
3. `f2py`: Anaconda Python3(recommended) or Miniconda + Numpy

It is strongly recommended to install Intel compiler and Anaconda Python3 on your
computer/node. Although these two packages may be large, they meet all prerequisites
of compiling MOKIT. Note that the Intel compiler is free of charge for academic use.

If you do not have the ifort compiler or MKL on your computer, you may want to
download and install them. There are several versions recommended, you can choose
any one of them:  
(1) Intel Parallel Studio XE 2017~2020 are all OK (2019 or 2020 preferred).  
(2) Since 2021, there is no Parallel Studio XE, but only the Intel OneAPI. You should
download and install both HPC Toolkit and MKL if you want to use 2021 version.

If you want to use other compilers, please read Section 2.3.5.

## 2.3.2 How to compile
Assuming you've already downloaded the MOKIT .zip package, just run
```
unzip mokit-master.zip
```
to uncompress it. Note that do not uncompress the package in Windows* OS, but un-
compress it in Linux* OS. Then simply run the following three command lines in
Shell
```
mv mokit-master mokit
cd mokit/src
make all
```
to compile MOKIT. This will take about 2 minutes. There is no `make install`.
Assuming that you want to use gfortran+OpenBLAS instead of ifort+MKL, you should
run
```
make all -f Makefile.gnu_openblas
```
to compile MOKIT. If you do not need `automr` for automatic multireference calculations
and only want to compile one or several modules, e.g. fch2inp (for Gaussian ->
GAMESS orbital transferring), then you simply need to run
```
make fch2inp
```
Be careful with hints on the screen, some modules depend on other modules, thus
a compilation of two or three modules is necessary sometimes.

## 2.3.3 Environment variables
After successful compilation, you need to add the following environment variables
into your `~/.bashrc` file:
```
export MOKIT_ROOT=/home/$USER/software/mokit
export PATH=$MOKIT_ROOT/bin:$PATH
export PYTHONPATH=$MOKIT_ROOT/mokit/lib:$PYTHONPATH
export GMS=/home/$USER/software/games/rungms        # optional
export PSI4=/home/$USER/psi4conda/bin/psi4          # optional
export BDF=/home/$USER/software/bdf-pkg/sbin/run.sh # optional
```
Please modify the above paths to suit your situations. Since PySCF is run by `python`,
OpenMolcas is run by `pymolcas`, Molpro is run by `molpro`, PSI4 is run by `psi4`
and Dalton is run by `dalton`, there is no extra environment variable to be exported
here. But if you define `export PSI4=...`, then this variable has priority to the
path found by `which psi4`.

Note that the original GAMESS source code can only deal with GVB up to 12 pairs.
To go beyond that (which is routine type of calculation in `automr` of MOKIT), please
read Section 4.4.10 carefully. After re-compiling GAMESS (followed by instructions
in Section 4.4.10), an executable `gamess.01.x` will be generated. This is the
executable to be called in `automr`.

The environment variable `BDF` are optional, there is no need to write it if you
do not want to use BDF. For Dalton, currently only the MKL version of Dalton is
supported. The MPI parallel version will be supported in the future.

The configuration file 'program.info' is no longer used since MOKIT 1.2.1. After
writing environment variables, a logout and re-login on your terminal is strongly
recommended.

The scratch directory (in Chinese, 临时文件存放目录) is not determined by MOKIT
or `automr`, but by each quantum chemistry package (Gaussian, OpenMolcas, GAMESS,
etc). Please do not submit two computations with the same input filename (even in
different work directories) at the same time, since their temporary files may be
overwritten by each other. For example, GAMESS, OpenMolcas and Molpro jobs are
sensitive to the files in the scratch directory, while Gaussian, PySCF and ORCA
are not that sensitive.

## 2.3.4 Test
To see the version and help information, you can run
```
automr -v (or -V, --version)
automr -h (or -help, --help)
```
To test whether the automr program works, please change into the example directory,
and pick up a .gjf file. For example,
```
cd $MOKIT_ROOT/examples/automr/
automr 00-h2o_cc-pVDZ_1.5.gjf >& 00-h2o_cc-pVDZ_1.5.out &
```
If you are running calculations on Ubuntu* OS, where the default sh is probably
`/bin/dash`, not `/usr/bin/bash`, you should submit a job like
```
automr 00-h2o_cc-pVDZ_1.5.gjf >00-h2o_cc-pVDZ_1.5.out 2>&1 &
```
If you encounter any errors in output, please search your problem in Section A1
FAQ of Appendix firstly. Some common questions have be listed. For bug reporting,
please read Section A3.

It is strongly recommended to create a new directory and put in the input file.
Because during computation many files will be generated by `automr` and those common
software packages.

## 2.3.5 Compiler notes
If you want to use any Fortran compiler other than `ifort` (e.g. `gfortran`), you
need to install the MKL library or OpenBLAS on your node. The recommended version
of `gfortran` is >= 4.8.5. Note that `gfortran` <= 4.7 is outdated and thus not
recommended. Even if you can successfully compile all utilities using `gfortran`
<= 4.7, they may not work normally or correctly.

### Option 1: gfortran + Intel MKL
```
make all -f Makefile.gnu_mkl
```

### Option 2: gfortran + OpenBLAS
```
make all -f Makefile.gnu_openblas
```

### Option 3: gfortran + OpenBLAS for Arch/Manjaro distributions
```
make all -f Makefile.gnu_openblas_arch
```

If you had compiled MOKIT before, and assuming now you want to use another compiler,
REMEMBER to run `make distclean` before re-compiling. Note that if you change the
version of Python on your node/machine, the dynamic library files `*.so` in `$MOKIT_ROOT/mokit/lib/`
may become unrecognized, in which case you have to re-compile MOKIT.

If you want to use **Miniconda** instead of **Anaconda Python3**, you should install
`numpy` since `numpy` is not in Miniconda by default. `f2py` will be installed along
with `numpy`. If your `f2py` comes from `psi4conda/bin/f2py`, then errors may occur
when compiling MOKIT. In such case you are recommended to comment environment variables
of PSI4 and use your previous python, e.g. Anaconda Python 3. MOKIT can still call
PSI4 even if PSI4 environment variables commented (see Section 2.2.3). If you encounter
compilation errors when using Intel 2017 and Anaconda Python 3.8, you can try to
use gfortran+MKL instead of Intel compiler by running `make all -f Makefile.gnu_mkl`.

For trouble shooting during compiling, please read Section A1.

## 2.3.6 Notes on Quantum chemistry packages
The `automr` program in MOKIT is an integrated interface program connecting common
quantum chemistry software packages. The `automr` itself does not contain any code
for computing electron integrals currently, it just transfers MOs among software,
sometimes read one-electron integrals from some package, and call various packages
to do specified computations. Therefore, the users are assumed to have successfully
installed some of these common software packages, which are [Gaussian](https://gaussian.com),
[PySCF](https://github.com/pyscf/pyscf), [GAMESS](https://www.msg.chem.iastate.edu),
[OpenMolcas](https://gitlab.com/Molcas/OpenMolcas), [Molpro](https://www.molpro.net),
[ORCA](https://orcaforum.kofo.mpg.de), [BDF](http://182.92.69.169:7226/Introduction),
[PSI4](https://github.com/psi4/psi4), [Dalton](https://gitlab.com/dalton/dalton) and
[QChem](https://www.q-chem.com). Some recommended versions are shown below

Gaussian: >= g09 (>=g16 preferred)  
PySCF >= 1.7.4  
GAMESS >= 2017 (>= 2019 preferred)  
ORCA >= 4.2.1 (>= 5.0 preferred)  
OpenMolcas >= v21.02  
Molpro >= 2015 (>= 2019 preferred)  
BDF >= 0.9.8  
PSI4 >= 1.3.2 (>= 1.4 preferred)  
Dalton >= 2020.0, OpenMP version
QChem >= 5.0

For DMRG related packages:  
Block >= 1.5.3  
pyblock2 >= preview-0.5.0  
QCMaquis >= 3.0.3  
CheMPS2 >= 1.8.9

Older versions are not recommended, since (1) they are possibly not tested by the
developers, (2) they had been tested but some functionality had not been (correctly)
implemented at that time. So that they may work or may not. OpenMolcas-v18.09 has
also been tested, but you need to take care of a problem, see Section A1, Q5 in Appendix.

Of course, not all packages will be called in an `automr` job. It depends on the
job type and the program specified by users (see Section 4.4.9 ~ 4.4.19 for details).
Usually three software packages (Gaussian, PySCF and GAMESS) are extensively used
in routine computations. Thus you are recommended to install at least these 3 packages.
If you have any difficulty in installing software, please read their corresponding
manuals carefully. Or you can find answers from their official websites, forums,
and GitHub/GitLab pages:

Gaussian: http://gaussian.com/help  
PySCF: https://github.com/pyscf/pyscf/issues  
ORCA: https://orcaforum.kofo.mpg.de  
OpenMolcas: https://gitlab.com/Molcas/OpenMolcas/-/issues  
Molpro: https://groups.google.com/d/forum/molpro-user  
GAMESS: https://github.com/gms-bbg/gamess-issues/issues  
PSI4: http://forum.psicode.org  
Dalton: https://gitlab.com/dalton/dalton

If you can read Chinese, the following installation instructions or tutorials of
common software packages on the WeChat Official Accounts 'quantumchemistry'(微
信公众号"量子化学") are strongly recommended:  
[Linux下安装Intel oneAPI](https://mp.weixin.qq.com/s/7pQETkrDO1C83vQjKQqI4w)  
[Linux下Gaussian 16安装教程](https://mp.weixin.qq.com/s/ffGo6eOEacfgqg3sYbrLJA)  
[ORCA 5.0安装及运行](https://mp.weixin.qq.com/s/yeCOMhothZeL-V7veAcbuw)  
[GAMESS简易编译教程](https://mp.weixin.qq.com/s/SF5BEfKsGwdKSlZdAe1t4A)  
[离线安装PySCF-2.x](https://mp.weixin.qq.com/s/KlIKk0Onlc1ELLezlaya0A)  
[PSI4程序安装及运行](https://mp.weixin.qq.com/s/I7Q1YXX5oSsXDe3oMo2jPw)  
[量子化学程序OpenMolcas的简易安装](https://mp.weixin.qq.com/s/wA8YClRxkRTChtQvuum-Uw)  
[离线编译OpenMolcas+QCMaquis](https://mp.weixin.qq.com/s/Gb1Lzv1bcQmvuHMZjAQLxQ)  
[Block-1.5的编译和安装](https://mp.weixin.qq.com/s/EUZKLYSqbuIUL9-zlySfbQ)  
[Boost.MPI的编译](https://mp.weixin.qq.com/s/AMYUTB5pTNLFZ8NEtFIG-Q)  
[安装基于openmpi的mpi4py](https://mp.weixin.qq.com/s/f5bqgJYG5uAK1Zubngg65g)  
[自动做多参考态计算的程序MOKIT](https://mp.weixin.qq.com/s/bM244EiyhsYKwW5i8wq0TQ)  

also these installation instructions on GitLab  
[离线安装OpenMolcas-v22.06](https://gitlab.com/jxzou/qcinstall/-/blob/main/%E7%A6%BB%E7%BA%BF%E5%AE%89%E8%A3%85OpenMolcas-v22.06.md)  
[编译MPI并行版OpenMolcas](https://gitlab.com/jxzou/qcinstall/-/blob/main/%E7%BC%96%E8%AF%91MPI%E5%B9%B6%E8%A1%8C%E7%89%88OpenMolcas.md)  
[block2的编译和安装](https://gitlab.com/jxzou/qcinstall/-/blob/main/block2%E7%9A%84%E7%BC%96%E8%AF%91%E5%92%8C%E5%AE%89%E8%A3%85.md)

