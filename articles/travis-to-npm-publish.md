# Publish packages from Travis CI to NPM

## Development process

Process is the following

1. (contributor) Add/modify/remove code
2. (contributor) Send pull request to master
3. (maintainer) Approve PR (if it is useful)
4. (maintainer) Bump version for the package
5. (maintainer) Tag the commit `git tag ...`
6. (Travis CI) Test and **publish** new version on NPM

## HOWTO: Configure the repository

Here is a checklist:

- [ ] Ingored files. You should publish only files required for usage package as a dependency.
  - [ ] add and fill `.npmignore` (see [npmignore](#npmignore) for details)
  - [ ] check that private files are ignored:
    - [ ] `.env`
    - [ ] `.npmrc`
    - [ ] `node_repl_history`
- [ ] `.travis.yml`:
  - [ ] get auth key from your `.npmrc`
  - [ ] encrypt auth key `travis encrypt 6xxxxxxx-axxx-xxxa-xxxx-xxxxxxxxxxxb -r volebo/express-mw-lang`
- [ ] deploy filters in .travis.yml`:
  - [ ] ONLY for tags
  - [ ] ONLY ONCE (even if there are several builds on Travis CI)
  - [ ] ONLY for **upstream** repository (not forks)

### Sample travis.yml

```yaml

deploy:
  provider: npm
  api_key:
    secure: Ivf1sGIwxxxxxxxxxxxxxxx....3an=
  email:
    secure: TXbFHByxxxxxxxxxxxxxxx.....bd0=
  on:
    tags: true
    node_js: 6
    repo: volebo/express-mw-lang

```

### npmignore

`.npmignore` should be checked for:

1. required files are published
2. dev-files (like `.env` or `gulpfile` ) are not published

Remember - published NPM package is not for changing, it is just a dependency for other packages. If you want to modify the package - welcome to github;)

## Helpful links

- deploy: https://docs.travis-ci.com/user/deployment/npm
- travis conditional: https://docs.travis-ci.com/user/deployment#Conditional-Releases-with-on%3A
- npm ignore: https://docs.npmjs.com/misc/developers#keeping-files-out-of-your-package

for `NPM > 5.5.1`

- npm tokens: https://docs.npmjs.com/getting-started/working_with_tokens
- 2fa: https://docs.npmjs.com/getting-started/using-two-factor-authentication
- update profile from CLI: https://docs.npmjs.com/getting-started/modifying_your_profile_from_command_line
