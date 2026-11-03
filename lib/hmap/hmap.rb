module Hmap
  # create Hash from given keys and mapped values
  def map(obj, &block)
    raise ArgumentError, "no block given" unless block

    obj.zip(obj.map(&block)).to_h
  end

  # map an Enumerable into a Hash, like obj.map { ... }.to_h
  def hmap(obj, &block)
    raise ArgumentError, "no block given" unless block

    obj.map(&block).compact.to_h
  end

  # call with (key, value) if the block takes both, else just the one
  def self.yield_pair(block, one, key, value)
    positional = block.parameters.count { |type, _| type == :req || type == :opt }
    positional >= 2 ? block.call(key, value) : block.call(one)
  end

  def self.extended(base)
    base.include(InstanceMethods)
  end

  module InstanceMethods
    # map the block's results back to a hash
    def hmap(&block)
      dup.hmap!(&block)
    end

    def hmap!(&block)
      data = Hash.hmap(self, &block)
      clear
      merge! data
    end

    # map keys, but preserve associated values
    # ie. http://apidock.com/rails/v4.2.7/Hash/transform_keys
    def kmap(&block)
      dup.kmap!(&block)
    end

    def kmap!(&block)
      raise ArgumentError, "no block given" unless block

      hmap! do |k, v|
        [ Hmap.yield_pair(block, k, k, v), v ]
      end
    end

    # map values, but preserve associated keys
    # ie. http://apidock.com/rails/v4.2.7/Hash/transform_values
    def vmap(&block)
      dup.vmap!(&block)
    end

    def vmap!(&block)
      raise ArgumentError, "no block given" unless block

      each do |k, v|
        self[k] = Hmap.yield_pair(block, v, k, v)
      end
    end
  end
end
