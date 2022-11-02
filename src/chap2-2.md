# Pre-built Linux Executables and Libraries

## Download

## Compatibility Note

| Artifacts | Compatible OS | Maybe Compatible | Python version | GCC version | NumPy version |
| :---: | :---: | :---: | :---: | :---: | :---: |
| centos7_conda_py37 | Centos 7 | | 3.7 | 4.8.5 | 1.18 |
| centos7_conda_py38 | Centos 7 | | 3.8 | 4.8.5 | 1.21 |
| centos7_conda_py39 | Centos 7 | | 3.9 | 4.8.5 | 1.21 |
| py37_gcc8 | Debian 10, SUSE 15, Ubuntu 20.04 | Centos 8 | 3.7 | 8.3 | 1.21 |
| py38_gcc8 | Debian 10, SUSE 15, Ubuntu 20.04 | Centos 8 | 3.8 | 8.3 | 1.23 |
| py39_gcc10 | Debian 11, Ubuntu 20.04 |  | 3.9 | 10.2 | 1.23 |
| py310_gcc10 | Debian 11, Arch | Ubuntu 22.04 | 3.10 | 10.2 | 1.23 |

Tips:
* Do not extract the zip with GUI (like KDE)! Use `unzip` in command line.
* The artifacts started with 'centos7_conda' need to be used with Anaconda3/Miniconda3, and the rest works with system-provided python (conda is also OK).
* We cannot list every supported linux distribution here, especially those similar to listed ones: Rocky 8, Manjaro, etc. More compatibility tests and reports are welcome.
* The GCC and NumPy version listed refer to the version used to compile the artifacts. It does not mean users need to limit their GCC, NumPy versions strictly. 
  - GCC with `libgfortran.so.4` can be compatible with py3x_gcc8, and `libgfortran.so.5` can be compatible with py3x_gcc10. Use `ldconfig -p | grep libgfort` to check your libgfortran.so version.
  - NumPy can be sensitive to version sometimes. Try upgrade numpy if your python complained about version when `import`. 

Known issues:
* py310_gcc10 on Opensuse tumbleweed: NumPy version not compatible.
