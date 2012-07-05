module Mozart
  def self.value(*field_names, &block)
    Class.new do
      define_method(:initialize) do |params={}|
        raise ArgumentError unless (params.keys - field_names).empty?

        self.data = {}

        params.each { |k,v| data[k] = v }

        instance_eval(&block) if block
      end

      def ==(other)
        self.class == other.class && data == other.data
      end

      alias_method :eql?, :==

      def hash
        data.hash
      end

      field_names.each do |name|
        define_method(name) { data[name] }
        define_method("#{name}=") { |v| data[name] = v }
      end

      protected

      attr_accessor :data
    end
  end
end
