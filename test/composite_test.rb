require "minitest/autorun"

require_relative "../lib/mozart/composite"

describe Mozart::Composite do
  let(:composite) { Mozart::Composite.new }

  let(:parts) do
    [ Struct.new(:foo).new(:returned_by_foo),
      Struct.new(:bar).new(:returned_by_bar) ]
  end

  it "knows what messages it can receive" do
    parts.each { |part| composite << part }

    assert composite.receives?(:foo), "Expected composite to receive foo"
    assert composite.receives?(:bar), "Expected composite to receive bar"
    refute composite.receives?(:baz), "Did not expect composite to receive baz"
  end

  it "dispatches messages to its parts" do
    parts.each { |part| composite << part }

    composite.dispatch(:foo).must_equal(:returned_by_foo)
    composite.dispatch(:bar).must_equal(:returned_by_bar)

    # an example using arguments
    composite.dispatch(:foo=, :updated_foo_return)

    composite.dispatch(:foo).must_equal(:updated_foo_return)
  end

  it "raises an exception for unhandled messages" do
    assert_raises(NotImplementedError) do
      composite.dispatch(:baz)
    end
  end
end
