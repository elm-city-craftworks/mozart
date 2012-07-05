require_relative "composite"

module Mozart
  module Composable
    private

    def features
      @features ||= Mozart::Composite.new
    end

    def internals
      @internals ||= Mozart::Composite.new
    end

    def _(m, *a, &b)
      internals.dispatch(m, *a, &b)
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
