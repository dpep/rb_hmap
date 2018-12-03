class Hash

  class << self

    # create Hash from given keys and mapped values
    def map(obj, &block)
      res = obj.map do |*args|
        block.call(*args)
      end

      Hash[obj.zip res]
    end


    # map an Enumerable into a Hash, like Hash[obj.map ... ]
    def hmap(obj, &block)
      Hash[
        obj.map do |*args|
          block.call(*args)
        end.compact
      ]
    end

  end  # class << self


  # map the block's results back to a hash
  def hmap(&block)
    clone.hmap!(&block)
  end

  def hmap!(&block)
    data = Hash.hmap(self, &block)
    clear
    merge! data
  end


  # map keys, but preserve associated values
  # ie. http://apidock.com/rails/v4.2.7/Hash/transform_keys
  def kmap(&block)
    clone.kmap!(&block)
  end

  def kmap!(&block)
    hmap! do |k, v|
      [ block.arity <= 1 ? block.call(k) : block.call(k, v), v ]
    end
  end


  # map values, but preserve associated keys
  # ie. http://apidock.com/rails/v4.2.7/Hash/transform_values
  def vmap(&block)
    clone.vmap!(&block)
  end

  def vmap!(&block)
    each do |k, v|
      self[k] = block.arity <= 1 ? block.call(v) : block.call(k, v)
    end
  end


end
