This package should be automatically published to the NPM on every new tag.

Process is the following
1. Changes:
   - (add feature to dev) \* N times
   - (hotfix the master) \* N times
2. pull request to master
3. approve PR
4. set the appropriate version in master
5. **RELATED TO THIS ISSUE**:
   1. tag the commit `git tag ...`
   2. ensure, that travis build and published new version to NPM

The main tasks:
- [x] configure `.travis.yml`
  - [x] deploy ON tags
  - [x] ~deploy ONLY for nodejs.4 (just one build)~
  - [x] deploy ONLY for **nodejs.6** (just one build)
- [x] check `.npmignore` and `.gitignore`
  - [x] required files are published
  - [x] dev-files (like `.env` or `gulpfile` ) are not published. Remember - NPM package is not for changing, it is just a dependency. If you want to modify the package - go to github;)
- [x] set up the environment:
  - [x] secure auth keys
  - [x] clean `.npmrc`
## Help links
- deploy: https://docs.travis-ci.com/user/deployment/npm
- travis conditional: https://docs.travis-ci.com/user/deployment#Conditional-Releases-with-on%3A
- npm ignore: https://docs.npmjs.com/misc/developers#keeping-files-out-of-your-package
