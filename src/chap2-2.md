# 2.2 Linux Pre-built and MacOS Build from Source

## 2.2.1 Online Installation
### Option 1: Install from conda (for Linux only)
This is the easiest way, but network is required to auto-download the requirements
(like Intel MKL). And, creating a new environment before installing is highly
recommended, to avoid changing your base environment.
```
conda create -n mokit-py39 python=3.9 # 3.7-3.11 are all available
conda activate mokit-py39
conda install mokit -c mokit
```
If you have no access to network, but still don't want to compile MOKIT manually,
you can try options in [Section 2.2.2](#222-pre-built-linux-executables-and-libraries).

#### Update MOKIT with conda

Usually `conda update mokit -c mokit` works. Sometimes it may fail to find the latest version of MOKIT. In this case, a workaround can be 
```
conda uninstall mokit mkl
conda install mokit -c mokit
```

### Option 2: Use homebrew-toolchains (for MacOS only)
* Prerequisites: 
    - You need to install [homebrew](https://brew.sh) on your mac 


> If you are mainland China user, follow [brew mirrors help doc](https://mirrors.ustc.edu.cn/help/brew.git.html) to install prerequisites
* A detailed brew-tap install guideline is located in [homebrew-mokit github repo](https://github.com/ansatzX/homebrew-mokit)
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Release Installation

Assume you will use mokit in a python 3.9 environment (3.8-3.11 are all available)

```
brew install ansatzx/homebrew-mokit/mokit --with-py39
```

or

```
brew tap ansatzx/homebrew-mokit
brew install mokit --with-py39 
```

However, the release version is not up-to-date, it's highly recommended to install the latest commit.

#### Latest Commit Installation

Also assume you use mokit in a py-39 environment.

```
brew install ansatzx/homebrew-mokit/mokit --with-py39 --HEAD

```

Finally, follow caveats guides, add these commmand in your `~/.zshrc` (or bash/fish etc. profile).

You can run `brew info mokit` to check details.

```
export MOKIT_ROOT="$(brew --prefix mokit)"
export PATH=$MOKIT_ROOT/bin:$PATH
export PYTHONPATH=$MOKIT_ROOT:$PYTHONPATH
export LD_LIBRARY_PATH=$MOKIT_ROOT/mokit/lib:$LD_LIBRARY_PATH
```

#### Upgrade Mokit

##### release upgrade 

```
brew update -f 
```

Run the command below if there's a newer mokit release.

```
brew upgrade mokit  # or `brew upgrade ` to upgrade everything

```
##### latest commit upgrade 

```
brew upgrade --fetch-HEAD mokit
```




## 2.2.2 Pre-built Linux Executables and Libraries

Unlike the conda install approach, using pre-built MOKIT in this subsection do not require network. 
If you want full functionality of MOKIT, you still need to have necessary dependencies: Python3 environment and NumPy, which can be achieved by anaconda/miniconda. If you only want part of MOKIT, especially some certain binary utilities, see [Section 2.2.3](#223-only-want-frag_guess_wfn) for a simpler instruction.

### Download

[centos7_conda_py37](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=centos7_conda_py37)  
[centos7_conda_py38](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=centos7_conda_py38)  
[centos7_conda_py39](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=centos7_conda_py39)   
[py38_gcc8](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=py38_gcc8)  
[py39_gcc10](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=py39_gcc10)  
[py310_gcc10](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=py310_gcc10)

After downloading the pre-built artifacts, you need to set the following environment
variables (assuming MOKIT is put in `$HOME/software/mokit`) in your `~/.bashrc`:

```bash
export MOKIT_ROOT=$HOME/software/mokit
export PATH=$MOKIT_ROOT/bin:$PATH
export PYTHONPATH=$MOKIT_ROOT:$PYTHONPATH
export LD_LIBRARY_PATH=$MOKIT_ROOT/mokit/lib:$LD_LIBRARY_PATH
export GMS=$HOME/software/gamess/rungms
```
  
The `LD_LIBRARY_PATH` is needed since the OpenBLAS dynamic library is put there.
Remember to modify the `GMS` path to suit your local environment. 

> Attention: the PYTHONPATH has changed since MOKIT version 1.2.5rc2.

Note that you need to run `source ~/.bashrc` or exit the terminal as well as
re-login, in order to activate newly written environment variables.



### Compatibility Note

| Artifacts | Compatible OS | Maybe Compatible | Python version | GCC version | NumPy version |
| :---: | :---: | :---: | :---: | :---: | :---: |
| centos7_conda_py37 | Centos 7 | | 3.7 | 4.8.5 | 1.21 |
| centos7_conda_py38 | Centos 7 | | 3.8 | 4.8.5 | 1.21 |
| centos7_conda_py39 | Centos 7 | | 3.9 | 4.8.5 | 1.21 |
| py38_gcc8 | Debian 10, SUSE 15, Ubuntu 20.04 | Centos 8 | 3.8 | 8.3 | latest |
| py39_gcc10 | Debian 11, Ubuntu 20.04 | SUSE 15 | 3.9 | 10.2 | latest |
| py310_gcc10 | Debian 11 | Ubuntu 22.04 | 3.10 | 10.2 | latest |

Tips:
* Do not extract the zip with right-click (like the one in KDE)! Use `unzip` in command line.
* The artifacts started with 'centos7_conda' need to be used with Anaconda3/Miniconda3, and the rest works with system-provided python (conda is also OK).
* We cannot list every supported linux distribution here, especially those similar to listed ones: Rocky Linux, OpenEuler, etc. More compatibility tests and reports are welcome.
* The GCC and NumPy version listed refer to the version used to compile the artifacts. 
  - NumPy can be sensitive to version sometimes. Try upgrade (or downgrade) numpy if your python complained about version when `import`. 
  - The NumPy version for conda based prebuilts is fixed, because we use fixed-version miniconda image for building and would not upgrade anything for convenience. We may switch to newer miniconda image when the current ones are considered too old. The NumPy version for other prebuilts are latest (currently 1.24, because they are installed from pip).

Known issues:
* Currently no artifacts for Archlinux and Manjaro, because their python goes beyond 3.10.


## 2.2.3 Only want `frag_guess_wfn`?

If you do not need full functionality of MOKIT and only want `frag_guess_wfn` for generating the input file of various EDA methods (or other binary utilities, like `fch2mkl`), the easiest way is to download the pre-compiled MOKIT in Section [2.2.2](./chap2-2.html#222-pre-built-linux-executables-and-libraries). There is no need to install Miniconda/Anaconda Python in this case, and no need for `conda install`.

Firstly, download a pre-compiled MOKIT package according to your OS (e.g. CentOS 7), and change the directory name
```
unzip mokit-master_linux_centos7_conda_py39.zip
rm -f mokit-master_linux_centos7_conda_py39.zip
mv mokit-master_linux_centos7_conda_py39 mokit
```

Then write proper environment variables in your `~/.bashrc` file,
```
export MOKIT_ROOT=$HOME/software/mokit
export PATH=$MOKIT_ROOT/bin:$PATH
export LD_LIBRARY_PATH=$MOKIT_ROOT/mokit/lib:$LD_LIBRARY_PATH
```

Remember to run `source ~/.bashrc` to make the environment variables valid. If you are working on a Cluster（集群） and using a script to submit any computational task, you should write the environment variables into your script.

