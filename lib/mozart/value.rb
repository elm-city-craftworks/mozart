module Mozart
  def self.value(*field_names)
    Class.new do
      define_method(:initialize) do |params={}|
        raise ArgumentError unless (params.keys - field_names).empty?

        self.data = {}

        params.each { |k,v| data[k] = v }
      end

      field_names.each do |name|
        define_method(name) { data[name] }
        define_method("#{name}=") { |v| data[name] = v }
      end

      private

      attr_accessor :data
    end
  end
end
