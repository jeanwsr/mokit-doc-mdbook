# 2.4 Installation on Cluster

## 2.4.1 Compile MOKIT on Cluster
If you can write environment variables freely into `~/.bashrc`, then there is nothing different with installation on your local Linux computer.

However, sometimes you are not allowed, or you do not want to modify `~/.bashrc`. And usually environment variables of various packages (e.g. ifort, python, etc) are controlled by the `module` function. For example, if you need some version of python (other than system default), you have to run `module load python/...` to make it accessible. In such case, you have to firstly load proper versions of Intel compiler and Python before installing MOKIT. For example,

```
module avai               # find which versions you can use
module load intel/2019u5  # load the version you want to use
module load python/3.7.6  # load the version you want to use
make all                  # compile MOKIT
```

The first line finds which versions of software packages you can choose. The 2nd and 3rd lines load the corresponding software. And the 4th line is just the installing of MOKIT. This is just a simple example telling you how to load modules on a cluster. For detailed questions, please consult the administrator of your cluster.

## 2.4.2 Use MOKIT on Cluster
Usually you are not allowed to submit any job in the main node or login node. And there exists a queue/batch system on your cluster, e.g. `bsub` of LSF, `qsub` of PBS, or `sbatch` of SLURM, which distributes your job to a proper computation node. Taking `bsub` as an example, you should write a Shell script like
```
#!/bin/sh
#BSUB -q ... # queue name
#BSUB -n 4 # number of cores
module load intel/2019u5
module load python/3.7.6

gjfname=$1
outname=${gjfname%.*}.out
automr $gjfname > $outname 2>&1
```
Then you can run
```
bsub run.sh 00-h2o_cc-pVDZ_1.5.gjf
```
to submit the job.

If you are using the SLURM, the Shell script would look like
```
#!/bin/bash
#SBATCH -J automr
#SBATCH -e automr.err.%j
#SBATCH -p ... # queue name
#SBATCH -N 1
#SBATCH -n 1   # number of MPI processors
#SBATCH -c 32  # number of OpenMP threads
#SBATCH --mem=64G

gjfname=$1
outname=${gjfname%.*}.out
automr $gjfname > $outname 2>&1
```
And you need to run
```
sbatch run.sh 00-h2o_cc-pVDZ_1.5.gjf
```
to submit the job. This job will call the quantum chemistry packages Gaussian, GAMESS and PySCF in succession, and all three packages are of OpenMP parallelism.

If some MPI programs (e.g. ORCA) would be called during computations, remember to swap the parameters of `-n` and `-c`. For example, if `mokit{CASSCF_prog=ORCA}` is specified in your input file, you will need a Shell script like
```
#!/bin/bash
#SBATCH -J automr
#SBATCH -e automr.err.%j
#SBATCH -p ... # queue name
#SBATCH -N 1
#SBATCH -n 32  # number of MPI processors
#SBATCH -c 1   # number of OpenMP threads
#SBATCH --mem=64G

gjfname=$1
outname=${gjfname%.*}.out
automr $gjfname > $outname 2>&1
```

If you need to run a small MOKIT job on the current node without modifying your `~/.bashrc`, you should create a Shell script, e.g. `run.sh`, with
```
module load intel/2019u5
module load python/3.7.6
gjfname=$1
outname=${gjfname%.*}.out
automr $gjfname > $outname 2>&1
```
written in this script. Then you can run
```
chmod +x run.sh
./run.sh 00-h2o_cc-pVDZ_1.5.gjf &
```

If you still encounter problems of installing or running MOKIT on your cluster, please consult the administrator of your cluster. This is beyond the scope of this manual.

