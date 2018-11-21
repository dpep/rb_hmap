require 'minitest/autorun'
require 'hmap'


class HmapTest < Minitest::Test

  def test_Hash_map
    data = {
      c: 2,
      b: 3,
      a: 1,
    }

    assert_equal(
      data,
      Hash.map(data.keys) {|x| data[x]}
    )

    assert_equal(
      {},
      Hash.map([]) {|x| nil}
    )

    assert_equal(
      {
        1 => nil,
        2 => nil,
        3 => nil,
      },
      Hash.map([1,2,3]) {|x| nil}
    )

    assert_equal(
      {
        1 => false,
        2 => false,
        3 => true,
      },
      Hash.map([1,2,3]) {|x| x > 2 }
    )

    assert_equal(
      { 1 => [ 2, 3 ] },
      Hash.map([1]) {|x| [ 2, 3 ] }
    )
  end


  def test_Hash_hmap
    data = {
      c: 2,
      b: 3,
      a: 1,
    }

    assert_equal(
      data,
      Hash.hmap(data) {|k, v| [k, v]}
    )

    assert_equal(
      { a: 2, b: 6, c: 4 },
      Hash.hmap(data) {|k, v| [k, v * 2]}
    )

    assert_equal(
      { 1 => 2, 2 => 4 },
      Hash.hmap([1, 2]) {|x| [ x, x * 2 ] }
    )

    assert_equal(
      data,
      Hash.hmap(data.keys) {|x| [x, data[x]]}
    )

    assert_equal(
      { nil => 3 },
      Hash.hmap([1,2,3]) {|x| [nil, x]}
    )

    assert_equal(
      {},
      Hash.hmap([]) {|x| nil}
    )

    assert_equal(
      {},
      Hash.hmap([1, 2, 3]) {|x| nil}
    )
  end


  def test_hmap
    data = {
      c: 2,
      b: 3,
      a: 1,
    }

    assert_equal(
      {
        c: 4,
        b: 6,
        a: 2,
      },
      data.hmap {|k, v| [k, v * 2]}
    )

    assert_equal(
      {
        cc: 4,
        bb: 6,
        aa: 2,
      },
      data.hmap {|k, v| [(k.to_s * 2).to_sym, v * 2]}
    )

    assert_equal(
      {},
      {}.hmap {|k, v| [k, v * 2]}
    )

    assert_equal(
      {},
      {a: 1}.hmap {|k, v| nil}
    )


    assert_equal(
      {
        c: 4,
        b: 6,
        a: 2,
      },
      data.hmap! {|k, v| [k, v * 2]}
    )
    assert_equal(
      {
        c: 4,
        b: 6,
        a: 2,
      },
      data
    )
  end


  def test_kmap
    data = {
      'a' => 1,
      'b' => 2,
      'c' => 3,
    }

    assert_equal(
      data,
      data.kmap(&:to_s)
    )

    assert_equal(
      {
        'aa' => 1,
        'bb' => 2,
        'cc' => 3,
      },
      data.kmap {|k| k * 2}
    )

    assert_equal(
      {
        'aa' => 1,
        'bb' => 2,
        'cc' => 3,
      },
      data.kmap {|k, v| k * 2}
    )

    assert_equal(
      {
        'aa' => 1,
        'bb' => 2,
        'cc' => 3,
      },
      data.kmap! {|k, v| k * 2}
    )
    assert_equal(
      {
        'aa' => 1,
        'bb' => 2,
        'cc' => 3,
      },
      data
    )
  end


  def test_vmap
    data = {
      a: 1,
      b: 2,
      c: 3,
    }

    assert_equal(
      {
        a: 1.0,
        b: 2.0,
        c: 3.0,
      },
      data.vmap(&:to_f)
    )

    assert_equal(
      {
        a: 2,
        b: 4,
        c: 6,
      },
      data.vmap {|v| v * 2}
    )

    assert_equal(
      {
        a: 2,
        b: 4,
        c: 6,
      },
      data.vmap {|k, v| v * 2}
    )

    assert_equal(
      {
        a: :a,
        b: :b,
        c: :c,
      },
      data.vmap {|k, v| k}
    )


    assert_equal(
      {
        a: 2,
        b: 4,
        c: 6,
      },
      data.vmap! {|v| v * 2}
    )
    assert_equal(
      {
        a: 2,
        b: 4,
        c: 6,
      },
      data
    )
  end


  def test_default_value
    data = Hash.new 123

    assert_equal(
      123,
      data.kmap {|v| nil }[:abc]
    )

    assert_equal(
      123,
      data.vmap {|v| nil }[:abc]
    )

    assert_equal(
      123,
      data.hmap {|v| nil }[:abc]
    )
  end

end
