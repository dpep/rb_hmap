## Unreleased
- Requires Ruby 3.3 or newer.

### 1.1.0  (2026-11-03)
- require Ruby >= 3.2
- fix FrozenError from hmap, kmap, and vmap on frozen hashes
- raise ArgumentError when called without a block
- hmap and Hash.hmap raise on malformed pairs, e.g. [key], instead of filling in a nil value
- kmap and vmap pass the key and value to blocks with an optional second param, e.g. |k, v = nil|

###  1.0.1  (2024-07-12)
- fix changelog
- rebuild
- codecov
- readme
- upgrades
- update libs

### 1.0.0, 2018-12-03
- launch
