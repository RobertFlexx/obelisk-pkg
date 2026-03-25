# Obelisk Package Repository

This directory is a ready-to-publish GitHub Pages package repository for Obelisk `opkg`.

## Layout

- `index.json` - repository package index consumed by `opkg update`
- `packages/` - `.opk` package payloads
- `recipes/` - community-editable recipe DSL files (`*.opkrecipe`)
- `scripts/` - helper scripts for indexing and validation

## Publish

1. Copy this `obelisk-repo/` directory into a new GitHub repository.
2. Commit and push.
3. Enable GitHub Pages for repository root.

## Configure Obelisk

Add this to `repos.conf`:

`desktop https://<user>.github.io/<repo>`

Optional index pin:

`desktop https://<user>.github.io/<repo> sha256:<index-json-sha256>`

## Recipe DSL skeleton

Use in-image opkg:

- `opkg recipe scaffold /tmp/mytool.opkrecipe mytool`
- `opkg recipe validate /tmp/mytool.opkrecipe`
- `opkg recipe show /tmp/mytool.opkrecipe`
