require "minitest/autorun"

require_relative "../lib/mozart/composite"

describe Mozart::Composite do
  let(:parts) do
    { :a => Struct.new(:foo).new(:returned_by_foo),
      :b => Struct.new(:bar).new(:returned_by_bar) }
  end

  it "knows what messages it can receive" do
    composite = Mozart::Composite.new

    parts.values.each { |part| composite << part }

    assert composite.receives?(:foo), "Expected composite to receive foo"
    assert composite.receives?(:bar), "Expected composite to receive bar"
    refute composite.receives?(:baz), "Did not expect composite to receive baz"
  end

  it "dispatches messages to its parts" do
    composite = Mozart::Composite.new

    parts.values.each { |part| composite << part }

    composite.dispatch(:foo).must_equal(:returned_by_foo)
    composite.dispatch(:bar).must_equal(:returned_by_bar)
  end
end
