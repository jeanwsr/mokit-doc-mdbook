# 2.2 Linux Pre-built

## 2.2.1 Online Installation
### Optional 1: Install from conda
This is the easiest way, but network is required to auto-download the requirements
(like Intel MKL). And, creating a new environment before installing is highly
recommended, to avoid changing your base environment.
```
conda create -n mokit-py37 python=3.7 # 3.8, 3.9 are also available
conda activate mokit-py37
conda install mokit -c mokit
```
If you have no access to network, but still don't want to compile MOKIT manually,
you can try options in Section 2.2.2.

### Optional 2: Use homebrew-toolchains (for MacOS only)
* Prerequisites: 
    - You need to install [homebrew](https://brew.sh) on your mac 
    - You need to install conda via brew and install numpy in base env. via pip 

Notice: if you are China, mainland user, follow [brew mirrors help doc](https://mirrors.ustc.edu.cn/help/brew.git.html) and [conda mirrors help doc](https://mirrors.ustc.edu.cn/help/anaconda.html) to install prerequisites
* A detailed brew-tap install guideline is located in [homebrew-mokit github repo](https://github.com/ansatzX/homebrew-mokit)
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```
brew install --cask miniconda
conda init bash (or zsh) 
conda activate base
pip install numpy
```
Then 
`brew install ansatzx/homebrew-mokit/mokit`

Or `brew tap ansatzx/homebrew-mokit` and then `brew install mokit`.

Finally, follow caveats guides, add these commmand in your zsh/bash/fish etc. profile.

```
export MOKIT_ROOT="$(brew --prefix)/Cellar/mokit/master"
export PATH=$MOKIT_ROOT/bin:$PATH
export PYTHONPATH=$MOKIT_ROOT:$PYTHONPATH
export LD_LIBRARY_PATH=$MOKIT_ROOT/mokit/lib:$LD_LIBRARY_PATH
```

## 2.2.2 Pre-built Linux Executables and Libraries

### Download
[centos7_conda_py37](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=centos7_conda_py37)  
[centos7_conda_py38](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=centos7_conda_py38)  
[centos7_conda_py39](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=centos7_conda_py39)  
[py37_gcc8](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=py37_gcc8)  
[py38_gcc8](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=py38_gcc8)  
[py39_gcc10](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=py39_gcc10)  
[py310_gcc10](https://gitlab.com/jxzou/mokit/-/jobs/artifacts/master/download?job=py310_gcc10)

### Compatibility Note

| Artifacts | Compatible OS | Maybe Compatible | Python version | GCC version | NumPy version |
| :---: | :---: | :---: | :---: | :---: | :---: |
| centos7_conda_py37 | Centos 7 | | 3.7 | 4.8.5 | 1.18 |
| centos7_conda_py38 | Centos 7 | | 3.8 | 4.8.5 | 1.21 |
| centos7_conda_py39 | Centos 7 | | 3.9 | 4.8.5 | 1.21 |
| py37_gcc8 | Debian 10, SUSE 15, Ubuntu 20.04 | Centos 8 | 3.7 | 8.3 | 1.21 |
| py38_gcc8 | Debian 10, SUSE 15, Ubuntu 20.04 | Centos 8 | 3.8 | 8.3 | latest |
| py39_gcc10 | Debian 11, Ubuntu 20.04 | SUSE 15 | 3.9 | 10.2 | latest |
| py310_gcc10 | Debian 11, Arch | Ubuntu 22.04 | 3.10 | 10.2 | latest |

Tips:
* Do not extract the zip with GUI (like KDE)! Use `unzip` in command line.
* The artifacts started with 'centos7_conda' need to be used with Anaconda3/Miniconda3, and the rest works with system-provided python (conda is also OK).
* We cannot list every supported linux distribution here, especially those similar to listed ones: Rocky 8, Manjaro, etc. More compatibility tests and reports are welcome.
* The GCC and NumPy version listed refer to the version used to compile the artifacts. 
  - NumPy can be sensitive to version sometimes. Try upgrade numpy if your python complained about version when `import`. 
  - The NumPy version for conda based prebuilts is fixed, because we use fixed-version miniconda image for building and would not upgrade anything for convenience. We may switch to newer miniconda image when the current ones are considered too old. The NumPy version for other prebuilts are latest (currently 1.24, because they are installed from pip) except py37 (because NumPy did not provide newer releases than 1.21 for it).

Known issues:
* 
