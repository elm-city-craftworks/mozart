require "minitest/autorun"

require_relative "../lib/mozart/composite"
require_relative "../lib/mozart/value"

describe Mozart::Composite do
  let(:composite) { Mozart::Composite.new }

  let(:parts) do
    [ Mozart.value(:foo).new(:foo => :returned_by_foo),
      Mozart.value(:bar).new(:bar => :returned_by_bar) ]
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
  end

  it "raises an exception for unhandled messages" do
    assert_raises(NotImplementedError) do
      composite.dispatch(:baz)
    end
  end
  
  it "raises an exception for messages with multiple recipients" do
    composite << Mozart.value(:foo).new(:foo => true)
    composite << Mozart.value(:foo).new(:foo => false)

    assert_raises(Mozart::AmbiguousMessageError) do
      composite.dispatch(:foo) 
    end

    assert_raises(Mozart::AmbiguousMessageError) do
      composite.receives?(:foo)
    end
  end
end
