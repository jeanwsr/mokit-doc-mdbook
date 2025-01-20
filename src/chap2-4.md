# 2.4 Installation on Cluster

## 2.4.1 Compile MOKIT on Cluster(集群)
If you already install MOKIT using `conda`, or you prefer using pre-built packages of MOKIT, you can skip this subsection. This is for compiling MOKIT from the source code on a Cluster. If you can write environment variables freely into `~/.bashrc`, then there is nothing different with installation on your local Linux computer.

However, sometimes you are not allowed, or you do not want to modify `~/.bashrc`. And usually environment variables of various packages (e.g. ifort, python, etc) are controlled by the `module` function. For example, if you need some version of python (other than system default), you have to run `module load python/...` to make it accessible. In such case, you have to firstly load proper versions of Intel compiler and Python before installing MOKIT. For example,

```
module avai                 # find which compilers/versions you can use
module load intel/2019u5    # load the Intel version you want to use
module load anaconda/2024.2 # load the Python version you want to use
cd $MOKIT_ROOT/src          # enter MOKIT source code directory
make all                    # compile MOKIT
```

The first line finds which versions of software packages you can choose. The 2nd and 3rd lines load the corresponding software. The 4th line is that you enter the MOKIT source code directory. And the 5th line is compiling MOKIT. This is just a simple example telling you how to load modules on a Cluster. For detailed questions, please consult the administrator of your Cluster.

## 2.4.2 Use MOKIT on Cluster
Usually you are not allowed to submit any job in the main node or login node. And there exists a queue/batch system on your cluster, e.g. `bsub` of LSF, `qsub` of PBS, or `sbatch` of SLURM, which distributes your job to a certain computation node. Taking `bsub` as an example, you should write a Shell script like
```
#!/bin/sh
#BSUB -q ... # queue name
#BSUB -n 4 # number of cores
module load intel/2019u5
module load anaconda/2024.2

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
to submit the job. This job will call the quantum chemistry packages Gaussian, GAMESS and PySCF in succession, and all three packages are of OpenMP parallelism. Note that before you submit the calculation job, you are supposed to be in the appropriate Python virtual environment. For example, the Bash in the terminal on my computer looks like
```
(mokit-py39) [jxzou@mu012 src]$
(mokit-py39) [jxzou@mu012 src]$ sbatch run_automr.sh
```
which means that I am in the `mokit-py39` virtual environment currently. Some users may want to write `conda init` and `conda activate mokit-py39` in the SLURM script, but it often does not work since SLURM does not support `conda` commands properly. So it is recommended that you are already in an appropriate virtual environment.

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
Do not worried about `-c 1`. OpenMP programs can also run parallelly.

If you need to run a small MOKIT job on the current node without modifying your `~/.bashrc`, you should create a Shell script, e.g. `run.sh`, with
```
module load intel/2019u5
module load anaconda/2024.2
gjfname=$1
outname=${gjfname%.*}.out
automr $gjfname > $outname 2>&1
```
written in this script. Then you can run
```
chmod +x run.sh
./run.sh 00-h2o_cc-pVDZ_1.5.gjf &
```

If you still encounter problems of installing or running MOKIT on your cluster, please consult the administrator of your Cluster. This is beyond the scope of this manual.

