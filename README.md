# mdbook Pages for MOKIT Doc

## Build and preview the documentation locally

Install `mdbook` and `mdbook-admonish` first. You can use `cargo install mdbook mdbook-admonish` or go to the [mdbook release](https://github.com/rust-lang/mdBook/releases) and [mdbook-admonish release](https://github.com/tommilligan/mdbook-admonish/releases) to download the executables. Then,
```
# modify md in src
mdbook-admonish install .
mdbook build
mdbook serve
# open your browser to visit http://localhost:3000
```

## Offline browsing

Download the released tar.gz of this repo, and do

```
tar xzvf mokit-doc-1.2.5rc19.tar.gz
cd mokit-doc-1.2.5rc19
firefox public/index.html # double-click it if using Windows
```

Most of the the links in doc in offline mode should be still valid, but I'm not very sure...

## Features

### Theme

Use Nord Theme from [gbrlsnchs/mdBook-nord-template](https://github.com/gbrlsnchs/mdBook-nord-template).

### Note/Warning

See [blocks for note](https://jeanwsr.gitlab.io/mokit-doc-mdbook/chap6.html#blocks-for-notewarning).


## Links

More Information:

- [https://yethiel.gitlab.io/post/mdbook-with-gitlab-ci-cd/](https://yethiel.gitlab.io/post/mdbook-with-gitlab-ci-cd/)
- [https://gitlab.com/yethiel/pages-mdbook](https://gitlab.com/yethiel/pages-mdbook)


