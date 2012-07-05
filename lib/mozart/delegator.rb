require_relative "composite"

module Mozart
  def self.delegator(&block)
    Class.new do
      define_method(:initialize) do |params|
        self.composite = Mozart::Composite.new

        block.call(params).each do |feature|
          composite << feature
        end
      end

      def respond_to_missing?(m, *a)
        composite.receives?(m)
      end

      def method_missing(m, *a, &b)
        composite.dispatch(m, *a, &b)
      end

      private

      attr_accessor :composite
    end
  end
end

