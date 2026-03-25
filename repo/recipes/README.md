# Recipes

Recipe files use `*.opkrecipe` with simple key/value syntax:

```ini
name=gnu-grep
version=3.11
arch=x86_64
section=base
license=GPL-3.0-or-later
summary=GNU grep for Obelisk
description=Pattern search utility built for Obelisk
source=https://ftp.gnu.org/gnu/grep/grep-3.11.tar.xz
build=gnu
depends=libc,libpcre2
```

Validate in Obelisk with:

`opkg recipe validate <file.opkrecipe>`
