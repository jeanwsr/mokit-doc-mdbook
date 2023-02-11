# Developers' Guide
## How to contribute

See [CONTRIBUTING](https://gitlab.com/jxzou/mokit/-/blob/master/CONTRIBUTING.md). Also, this page contains a few tips for handling the CI/CD.

## Tips for Coding

To be added.

## Tips for CI/CD and packaging

### How to write GitLab CI yml file
GitLab CI jobs are triggered by `.gitlab-ci.yml`.
[The official manual](https://docs.gitlab.com/ee/ci/) provides a lot of useful materials for writing it, but it's quite long. 

A typical job can be
```
centos7_conda_py37:
  image: centos:7
  variables:
    TARGET: mokit-master_linux_centos7_conda_py37
    MCONDA_VER: py37_4.10.3
  extends: .setup_system
  script:
    - pip install numpy==1.18
    - cd src
    - make all -f Makefile.gnu_openblas_ci
    - cd ..
  artifacts:
    name: $TARGET
    paths:
      - ./$TARGET/
```

It means, this job pull a docker `image` and run a `script` inside it, then zip and upload some `artifacts`. A job can `extends` another job (actually means "inherit", not "run after"). Here `.setup_system` is a virtual job (because it starts with a "."), provides a `before_script` and `after_scipt`, to be executed before and after the `script`.
```
.setup_system:
  except:
    - conda
  before_script:
    - yum install -y epel-release
    - yum install -y openblas-devel make gcc gcc-gfortran wget 
    - wget -q --no-check-certificate https://mirrors.bfsu.edu.cn/anaconda/miniconda/Miniconda3-${MCONDA_VER}-Linux-x86_64.sh
    - >
      { echo ${KEYCODE_ENTER};
      echo "yes";
      echo ${KEYCODE_ENTER};
      } | sh ./Miniconda3-${MCONDA_VER}-Linux-x86_64.sh 
    - /root/miniconda3/bin/conda init bash
    - . ~/.bashrc
  after_script:
    - xxx
```

### Conda packaging

Currently the GitLab CI for conda build works fine. It can be triggered by any modification of `mokit/__init__.py` or `conda/meta.yaml`, as indicated by [this yml](
https://gitlab.com/jxzou/mokit/-/blob/master/gitlab-ci/conda.yml#L6-L9).

If something went wrong in the conda build, a manual build can be done to debug as follows.

Set up environment by docker first (may require sudo)
```
docker pull continuumio/miniconda3:latest
docker run -it --name myconda continuumio/miniconda3:latest /bin/bash
```
Now we enter the shell inside docker container
```
cd /root
apt update && apt install git vim # and so on
git clone https://gitlab.com/jxzou/MOKIT
cd MOKIT
conda create -n mokit-build python=3.7
conda activate mokit-build
conda install anaconda-client conda-build
conda build --output-folder ./output conda
anaconda upload ./output/linux-64/*.bz2
```
Next time, we can re-enter the container by
```
docker start -i myconda
```
and build a new version
```
conda activate mokit-build
conda build --output-folder ./output conda
anaconda upload ./output/linux-64/*.bz2
```

### Other CI/CD

Other CI jobs build the usual pre-built artifacts. They can also be debugged by manual docker pull and run.

For example, to manually debug centos7_conda_py37, you can `docker pull centos:7` and follow the steps defined in [the corresponding yml](https://gitlab.com/jxzou/mokit/-/blob/master/gitlab-ci/centos7.yml).

Of course, debugging can be: simply commit the change, push to GitLab and see what happens in the pipeline log. But this will consume the limited CI job time quota. Another option is to fork the repo to NJU Git and debug, which provides free, unlimited CI runner for NJUers.

## Documentation

The current online documentation is enabled via [mdBook](https://github.com/rust-lang/mdBook), utilizing [Yethiel's template](https://gitlab.com/yethiel/pages-mdbook) and modified [Nord Theme](https://github.com/gbrlsnchs/mdBook-nord-template).

For configuration tips (rendering, themes, etc.), see [mdBook Doc](https://rust-lang.github.io/mdBook/format/configuration/index.html). 

All chapters should be registered in `SUMMARY.md`, and thus they will appear in the side bar.

### Build and preview
We have included the `mdbook` linux binary in the source code, so simply do

```bash
tar xzvf mdbook-toc*.tar.gz
tar xzvf mdbook-v*.tar.gz
# modify md in src
./mdbook build
./mdbook serve
# open your browser to visit http://localhost:3000
```

On other platforms, you can download the binaries in the GitHub repo of mdBook and mdbook-toc, or use WSL (you don't need a browser inside WSL).

Simple modifications can be done on the GitLab website. Clicking the `Edit` button or `Open the Web IDE` allows you modify and commit online.

### Markdown syntax

You should [learn some basic Markdown](https://rust-lang.github.io/mdBook/format/markdown.html) to modify the documentation.

However, mdBook's [math support](https://rust-lang.github.io/mdBook/format/mathjax.html) is a little different from common Markdown syntax.