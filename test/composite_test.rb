require "minitest/autorun"

require_relative "../lib/mozart/composite"

describe Mozart::Composite do
  let(:parts) do
    { :a => MiniTest::Mock.new,
      :b => MiniTest::Mock.new }
  end

  it "knows what messages it can receive" do
    composite = Mozart::Composite.new

    parts[:a].expect(:respond_to?, false, [:foo])
    parts[:b].expect(:respond_to?, true,  [:foo])

    parts[:a].expect(:respond_to?, true,  [:bar])
    parts[:b].expect(:respond_to?, false, [:bar])

    parts[:a].expect(:respond_to?, false, [:baz])
    parts[:b].expect(:respond_to?, false, [:baz])

    parts.values.each { |part| composite << part }

    assert composite.receives?(:foo)
    assert composite.receives?(:bar)
    refute composite.receives?(:baz)

    parts.values.each { |part| part.verify }
  end
end
