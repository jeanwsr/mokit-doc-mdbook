# mdbook Pages for MOKIT Doc

## Usage for developers

For linux (including WSL), the executable of mdbook and mdbook-toc is included in this repo, so we can do
```
tar xzvf mdbook-toc*.tar.gz
tar xzvf mdbook-v*.tar.gz
# modify md in src
./mdbook build
./mdbook serve
# open your browser to visit http://localhost:3000
```

If using Windows, please go to the [mdbook release](https://github.com/rust-lang/mdBook/releases) and [mdbook-toc release](https://github.com/badboy/mdbook-toc/releases) to download the executables for Windows platform.


## Offline browsing

Download the released tar.gz of this repo, and do

```
tar xzvf mokit-doc-1.2.5rc19.tar.gz
cd mokit-doc-1.2.5rc19
firefox public/index.html # double-click it if using Windows
```

Most of the the links in doc in offline mode should be still valid, but I'm not very sure...

## Features

### mdbook-toc

This template comes with `mdbook-toc`. That means you can insert `<!-- toc -->` into your pages to generate a table of contents.

<!--
### kdb-Element Style

A custom.css file for styled `<kdb>` elements to display keyboard inputs like <kbd>Ctrl</kbd> + <kbd>C</kbd> from the [MDN web docs](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/kbd).
-->

### Theme

Use Nord Theme from [gbrlsnchs/mdBook-nord-template](https://github.com/gbrlsnchs/mdBook-nord-template).

## Links

More Information:

- [https://yethiel.gitlab.io/post/mdbook-with-gitlab-ci-cd/](https://yethiel.gitlab.io/post/mdbook-with-gitlab-ci-cd/)
- [https://gitlab.com/yethiel/pages-mdbook](https://gitlab.com/yethiel/pages-mdbook)


