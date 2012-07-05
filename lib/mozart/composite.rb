module Mozart
  class Composite
    def receives?(message)
      [:foo, :bar].include?(message)
    end
  end
end
