require_relative "composite"

module Mozart
  module Composable
    private

    def C(*method_names, target)
      Mozart.context(*method_names).new(target)
    end

    def V(*field_names, params)
      Mozart.value(*field_names).new(params)
    end

    def features
      @features ||= Mozart::Composite.new
    end

    def respond_to_missing?(m, *a, &b)
      features.receives?(m)
    end

    def method_missing(m, *a, &b)
      return super unless features.receives?(m)

      features.dispatch(m, *a, &b)
    end
  end
end
