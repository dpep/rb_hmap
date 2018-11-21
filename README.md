Hmap
======

Improved Hash mapping functions

#### Install
# ```gem install hmap```


#### Usage
```
require 'hmap'

Hash.map [:a, :b, :c] do |v|
  [ v, v ]
end
=> { a: :a, b: :b, c: :c }

{
  a: 1,
  b: 2,
  c: 3,
}.vmap {|v| v * 2}
=> { a: 2, b: 4, c: 6 }

{
  'a' => 1,
  'b' => 2,
  'c' => 3,
}.kmap {|k, v| [ k * v, v ** 2 ] }
=> { 'a' => 1, 'bb' => 4, 'ccc' => 9 }
```
