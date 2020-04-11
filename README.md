# mdbook Pages template

An mdbook template for GitLab pages. This template automatically builds your mdbook with CI/CD using the following `.gitlab-ci.yml`:

```
pages:
  stage: deploy
  script:
  - wget https://github.com/badboy/mdbook-toc/releases/download/0.2.4/mdbook-toc-0.2.4-x86_64-unknown-linux-gnu.tar.gz
  - wget https://github.com/rust-lang/mdBook/releases/download/v0.3.7/mdbook-v0.3.7-x86_64-unknown-linux-gnu.tar.gz
  - tar xvzf mdbook-v0.3.7-x86_64-unknown-linux-gnu.tar.gz
  - tar xvzf mdbook-toc-0.2.4-x86_64-unknown-linux-gnu.tar.gz
  - ./mdbook build
  artifacts:
    paths:
    - public
  only:
  - master
```

More Information:

- [https://yethiel.gitlab.io/post/mdbook-with-gitlab-ci-cd/](https://yethiel.gitlab.io/post/mdbook-with-gitlab-ci-cd/)
- [https://gitlab.com/yethiel/pages-mdbook](https://gitlab.com/yethiel/pages-mdbook)
