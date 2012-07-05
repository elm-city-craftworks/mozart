require "minitest/autorun"

require_relative "../lib/mozart/composite"

describe Mozart::Composite do
  let(:parts) do
    { :a => Struct.new(:bar).new(:returned_by_bar),
      :b => Struct.new(:foo).new(:returned_by_foo) }
  end

  it "knows what messages it can receive" do
    composite = Mozart::Composite.new

    parts.values.each { |part| composite << part }

    assert composite.receives?(:foo), "Expected composite to receive foo"
    assert composite.receives?(:bar), "Expected composite to receive bar"
    refute composite.receives?(:baz), "Did not expect composite to receive baz"
  end
end
