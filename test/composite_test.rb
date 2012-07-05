require "minitest/autorun"

require_relative "../lib/mozart/composite"

describe Mozart::Composite do
  it "knows what messages it can receive" do
    composite = Mozart::Composite.new

    part_a = MiniTest::Mock.new
    part_b = MiniTest::Mock.new

    part_a.expect(:respond_to?, false, [:foo])
    part_b.expect(:respond_to?, true,  [:foo])

    part_a.expect(:respond_to?, true,  [:bar])
    part_b.expect(:respond_to?, false, [:bar])

    part_a.expect(:respond_to?, false, [:baz])
    part_b.expect(:respond_to?, false, [:baz])

    composite << part_a
    composite << part_b

    assert composite.receives?(:foo)
    assert composite.receives?(:bar)
    refute composite.receives?(:baz)
  end
end
