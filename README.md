# Obelisk

This repository is the public GitHub mirror of the Obelisk operating system.

Obelisk is a modern, UNIX-inspired system built from first principles with a focus on clarity, control, and performance. This mirror exists to make the project accessible, browsable, and easy to contribute to.

## Overview

The repository contains the core source tree for Obelisk, including:

* Kernel and low-level system components
* Userspace utilities and base tooling
* Filesystem and service infrastructure
* Package system integration (`opkg`)
* Build and distribution tooling

It reflects the current state of development and is kept in sync with the primary working tree.

## Package Repository (opkg)

Obelisk uses a lightweight package system built around `opkg`.
This repository includes a ready-to-publish layout for hosting packages via GitHub Pages.

### Layout

* `index.json` — package index used by `opkg update`
* `packages/` — compiled `.opk` package files
* `recipes/` — package definitions (`*.opkrecipe`)
* `scripts/` — indexing and validation tools

## Hosting a Repository

To publish your own Obelisk package repository:

1. Copy the `obelisk-repo/` directory into a new GitHub repository
2. Commit and push
3. Enable GitHub Pages for the repository root

The repository will then be usable as a package source.

## Using a Repository

Add a repository to your system by editing `repos.conf`:

```
desktop https://<user>.github.io/<repo>
```

Optionally, pin the index for integrity:

```
desktop https://<user>.github.io/<repo> sha256:<index-json-sha256>
```

## Creating Packages

Obelisk includes tools for creating and managing package recipes directly on the system:

```
opkg recipe scaffold /tmp/mytool.opkrecipe mytool
opkg recipe validate /tmp/mytool.opkrecipe
opkg recipe show /tmp/mytool.opkrecipe
```

Recipes define how software is built and packaged into `.opk` files.

## Contributing

Obelisk is an evolving system. Contributions and feedback are welcome.

The codebase emphasizes:

* Minimalism over abstraction
* Explicit behavior over hidden mechanisms
* Systems-level clarity

## Philosophy

From Axioms, Order.

Obelisk is built with the goal of remaining understandable and controllable as it grows.
