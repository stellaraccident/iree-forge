# IREE Forge

This repository is a monorepo consisting of the various projects that
interface to IREE and a) need to be built and released in a consistent fashion,
and b) lack a release methodology of their own (that is usable by us).

The goal is to have a repo that can be patched to a releasable state at a
regular cadence and then have everything branched as a unit.

There are two kinds of projects herein:

* Core projects that we manage via `git subtree` directly into this repository.
* Adjunct dependencies, mostly of IREE itself needed for one thing or
  another. These are managed as submodules as they are not shared with other
  things and rarely require project specific patching.

## Core projects

* `trees/iree`
* `trees/llvm-project`
* `trees/mlir-hlo`
* `trees/mlir-npcomp`

We always sync shared dependencies to what IREE expects and then patch others
as needed. In practice, some of these already come with consistent commit
points, so the job is easier.

## Check out and Build

```shell
# Clone repository.
git clone git@github.com:stellaraccident/iree-forge.git
cd iree-forge/
export PATH=$PWD/scripts:$PATH

# Initialize adjunct submodules.
git iree-init-submodules
git submodule update
```


## Syncing to upstream.

From a clean repository, run:

```shell
git iree-sync-trees ALL
```

This will sync each tree and bring dependent trees to a consistent commit. It
will result in multiple merges and commits to the `iree-forge` repository and
must be done from a clean working directory.

This will sync to iree HEAD. To sync to something else:

```shell
git iree-sync-trees iree@snapshot-20210626.363 ALL
```

Note that if syncing far back or far forward, you may need to choose explicit
commits for other trees that default to HEAD.
