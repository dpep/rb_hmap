Hmap
======

Improved Hash mapping functions

### Install
```gem install hmap```


### Usage
#### Hash.map
Create a Hash using an Enumerable by mapping it's items into corresponding hash values
```
Hash.map [:a, :bb, :ccc] {|v| v.length }
=> { a: 1, bb: 2, ccc: 3 }
```

#### hmap
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

{
  'a' => 1,
  'b' => 2,
  'c' => 3,
}.kmap &:to_sym
=> { a: 1, b: 2, c: 3 }
```


## 
Thanks to [J. Pablo Fernández](https://github.com/pupeno/hmap)

----
![Gem](https://img.shields.io/gem/dt/hmap?style=plastic)
