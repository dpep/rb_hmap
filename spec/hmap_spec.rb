describe Hmap do
  let(:data) do
    {
      c: 2,
      b: 3,
      a: 1,
    }
  end

  describe "Hash.map" do
    it "maps itself" do
      expect(
        Hash.map(data.keys) {|x| data[x] }
      ).to eq data
    end

    it "handles empty input" do
      expect(
        Hash.map([]) {|x| nil }
      ).to eq({})
    end

    it "maps nils" do
      expect(
        Hash.map([1,2,3]) {|x| nil }
      ).to eq(
        {
          1 => nil,
          2 => nil,
          3 => nil,
        }
      )
    end

    it "maps" do
      expect(
        Hash.map([1]) {|x| [ 2, 3 ] }
      ).to eq(
        { 1 => [ 2, 3 ] }
      )

      expect(
        Hash.map([1,2,3]) {|x| x > 2 }
      ).to eq(
        {
          1 => false,
          2 => false,
          3 => true,
        }
      )
    end
  end

  describe "Hash.hmap" do
    it "maps" do
      expect(
        Hash.hmap(data) {|k, v| [k, v] }
      ).to eq data

      expect(
        Hash.hmap(data) {|k, v| [k, v * 2] }
      ).to eq({ a: 2, b: 6, c: 4 })

      expect(
        Hash.hmap([1, 2]) {|x| [ x, x * 2 ] }
      ).to eq({ 1 => 2, 2 => 4 })

      expect(
        Hash.hmap(data.keys) {|x| [x, data[x]] }
      ).to eq data

      expect(
        Hash.hmap([1,2,3]) {|x| [nil, x] }
      ).to eq({ nil => 3 })

      expect(
        Hash.hmap([]) {|x| nil }
      ).to eq({})

      expect(
        Hash.hmap([1, 2, 3]) {|x| nil }
      ).to eq({})
    end
  end

  describe "Hash#hmap" do
    it "maps" do
      expect(
        data.hmap {|k, v| [k, v * 2] }
      ).to eq(
        {
          c: 4,
          b: 6,
          a: 2,
        },
      )

      expect(
        data.hmap {|k, v| [(k.to_s * 2).to_sym, v * 2] }
      ).to eq(
        {
          cc: 4,
          bb: 6,
          aa: 2,
        },
      )

      expect(
        {}.hmap {|k, v| [k, v * 2] }
      ).to eq({})

      expect(
        { a: 1 }.hmap {|k, v| nil }
      ).to eq({})
    end
  end

  describe "Hash#hmap!" do
    it "mutates" do
      expect(
        data.hmap! {|k, v| [k, v * 2]}
      ).to eq(
        {
          c: 4,
          b: 6,
          a: 2,
        },
      )

      expect(data).to eq(
        {
          c: 4,
          b: 6,
          a: 2,
        },
      )
    end
  end

  describe "Hash#kmap" do
    let(:data) do
      {
        'a' => 1,
        'b' => 2,
        'c' => 3,
      }
    end

    it "maps" do
      expect(
        data.kmap(&:to_s)
      ).to eq data

      expect(
        data.kmap {|k| k * 2}
      ).to eq(
        {
          'aa' => 1,
          'bb' => 2,
          'cc' => 3,
        },
      )

      expect(
        data.kmap {|k, v| k * 2}
      ).to eq(
        {
          'aa' => 1,
          'bb' => 2,
          'cc' => 3,
        },
      )
    end

    describe "Hash#kmap!" do
      let(:data) do
        {
          'a' => 1,
          'b' => 2,
          'c' => 3,
        }
      end

      it "mutates" do
        expect(
          data.kmap! {|k, v| k * 2}
        ).to eq(
          {
            'aa' => 1,
            'bb' => 2,
            'cc' => 3,
          },
        )

        expect(data).to eq(
          {
            'aa' => 1,
            'bb' => 2,
            'cc' => 3,
          },
        )
      end
    end
  end

  describe "Hash#vmap" do
    let(:data) do
      {
        a: 1,
        b: 2,
        c: 3,
      }
    end

    it "maps" do
      def test_vmap
        expect(
          data.vmap(&:to_f)
        ).to eq(
          {
            a: 1.0,
            b: 2.0,
            c: 3.0,
          },
        )

        expect(
          data.vmap {|v| v * 2}
        ).to eq(
          {
            a: 2,
            b: 4,
            c: 6,
          },
        )

        expect(
          data.vmap {|k, v| v * 2}
        ).to eq(
          {
            a: 2,
            b: 4,
            c: 6,
          },
        )

        expect(
          data.vmap {|k, v| k}
        ).to eq(
          {
            a: :a,
            b: :b,
            c: :c,
          },
        )
      end
    end

    describe "Hash#vmap!" do
      let(:data) do
        {
          a: 1,
          b: 2,
          c: 3,
        }
      end

      it "mutates" do
        expect(
          data.vmap! {|v| v * 2}
        ).to eq(
          {
            a: 2,
            b: 4,
            c: 6,
          },
        )

        expect(data).to eq(
          {
            a: 2,
            b: 4,
            c: 6,
          },
        )
      end
    end
  end

  describe "Hash#default" do
    let(:data) { Hash.new(default) }
    let(:default) { 123 }

    it "preserves the default value" do
      expect(
        data.kmap {|v| nil }[:abc]
      ).to eq default

      expect(
        data.vmap {|v| nil }[:abc]
      ).to eq default

      expect(
        data.hmap {|v| nil }[:abc]
      ).to eq default
    end
  end
end
