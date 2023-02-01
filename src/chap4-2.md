# 4.2 Memory and Parallel Settings
The settings of memory and the number of processors are identical to that in Gaussian. For example, the following syntax
```
%chk=16GB
%nprocshared=8
```
requests a `automr` calculation use 16GB memory and 8 processors. Note that only the unit GB and %nprocshared is supported. Some DON'T things are listed below:  
(1) Do not use unit MB, MW, GW, or %cpu..  
(2) Do not write %chk since it is useless for `automr`.

Since multireference computations often require large memory, it is recommended to use at least %mem=1GB for even a small molecule. It is also recommended to set mem (in GB) ≥ nproc. Note that the memory and parallel settings of OpenMolcas in your ~/.bashrc (MOLCAS_NPROCS and MOLCAS_MEM) will be overridden by settings in the .gjf file, and the OpenMP version or MPI version of OpenMolcas can be automatically detected. The memory and parallel settings of the BDF program is controlled by variables in the Shell script bdf-pkg/sbin/run.sh, you should properly modify the script before doing computations.

The memory and parallel settings are passed into various programs called by `automr` (e.g. PySCF, Gaussian, etc). The `automr` itself only needs negligible memory and usually run in a serial mode.
