module Mozart
  def self.context(*accepted_methods, &class_definition)
    Class.new do
      define_method :initialize do |target|
        self.target = target
        instance_eval(&class_definition) if class_definition
      end

      define_method :respond_to_missing? do |m, *a|
        accepted_methods.include?(m)
      end

      def method_missing(m, *a, &b)
        raise NotImplementedError unless respond_to_missing?(m)

        target.public_send(m, *a, &b)      
      end

      private 

      attr_accessor :target
    end
  end
end
