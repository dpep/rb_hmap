Hmap
======

Improved Hash mapping functions

### Install
gem coming soon


### Usage
#### Hash.map
Create a Hash using an Enumerable and mapping it's items into hash values
```
Hash.map [:a, :bb, :ccc] {|v| v.length }
=> { a: 1, bb: 2, ccc: 3 }
```

#### Hash.hmap
Map an Enumerable into a Hash, like Hash[obj.map ... ]
```
Hash.hmap [ 1, 2, 3 ] { |v| [ v, v * 2 ] }
=> { 1 => 2, 2 => 4, 3 => 6 }

{
  'a' => 1,
  'b' => 2,
  'c' => 3,
}.hmap {|k, v| [ k * v, v ** 2 ] }
=> { 'a' => 1, 'bb' => 4, 'ccc' => 9 }
```

#### vmap
Transform the values of a Hash
```
{
  a: 1,
  b: 2,
  c: 3,
}.vmap {|v| v * 2 }
=> { a: 2, b: 4, c: 6 }

{
  a: 1,
  b: 2,
  c: 3,
}.vmap &:to_s
=> { a: '2', b: '4', c: '6' }
```

#### kmap
Transform the keys of a Hash
```
{
  'a' => 1,
  'b' => 2,
  'c' => 3,
}.kmap {|k, v| k * v }
=> { 'a' => 1, 'bb' => 2, 'ccc' => 3 }
```
