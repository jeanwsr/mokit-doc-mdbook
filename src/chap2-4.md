# Installation on Cluster
Installing MOKIT on a cluster is somewhat troublesome (also for other software packages). If you can write environment variables freely into `~/.bashrc`, then there is nothing different with installation on your local Linux computer.
However, sometimes you are not allowed, or you don't want to modify `~/.bashrc`. And usually environment variables of various packages (e.g. ifort, python, etc) are controlled by the `module` function. For example, if you need some version of python (other than system default), you have to run `module load python/…` to make it accessible. In such case, you have to firstly load proper versions of Intel compiler and Python before installing MOKIT. For example,
```
module avai               # find which version you can use
module load intel/2019u5  # load the version you want to use
module load python/3.7.6  # load the version you want to use
make all                  # compile MOKIT
```
The first line finds which versions of software packages you can choose. The 2nd and 3rd lines load the corresponding software. And the 4th line is just the installing of MOKIT. This is just a simple example telling you how to load modules on a cluster. For detailed questions, please consult the administrator of your node, or the cluster. Moreover, a good choice to running automr is that you should create a Shell script, e.g. run.sh, with
```
module load intel/2019u5
module load python/3.7.6
gjfname=$1
outname=${gjfname%.*}.out
automr $gjfname >& $outname
```
written in this script. If you are allowed to submit jobs to the current node, then you can run
```
chmod +x run.sh
./run.sh 00-h2o_cc-pVDZ_1.5.gjf &
```
However, usually you are not allowed to submit any job in the main node or login node. And there exists a queue/batch system on your cluster, e.g. 'bsub' in LSF batch or ‘qsub’ in PBS batch, which distributes your job to a proper computation node. Taking 'bsub' as an example, you should write a Shell script like
```
#!/bin/sh
#BSUB -q …   # queue name
#BSUB -n …   # number of cores
module load intel/2019u5
module load python/3.7.6
gjfname=$1
outname=${gjfname%.*}.out
automr $gjfname >& $outname
```
Note that do not write `&` symbol after the outname. Then you can run
```
bsub run.sh 00-h2o_cc-pVDZ_1.5.gjf
```
to submit the job. If you still encounter problems of installing or running MOKIT on your cluster, please consult the administrator of your cluster. This is beyond the scope of this manual.
