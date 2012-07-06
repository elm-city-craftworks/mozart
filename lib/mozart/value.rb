module Mozart
  def self.value(*field_names, &block)
    Class.new do
      define_method(:initialize) do |params={}|
        raise ArgumentError unless params.keys == field_names

        self.__data__ = {}

        params.each { |k,v| __data__[k] = v }

        __data__
      end

      def ==(other)
        self.class == other.class && __data__ == other.__data__
      end

      def to_hash
        Marshal.load(Marshal.dump(__data__))
      end

      alias_method :eql?, :==

      def hash
        __data__.hash
      end

      field_names.each do |name|
        define_method(name)       { __data__[name] }
        define_method("#{name}=") { |value| __data__[name] = value }
      end

      protected

      attr_accessor :__data__
    end
  end
end
