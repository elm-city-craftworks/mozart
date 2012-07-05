require "minitest/autorun"
require_relative "../lib/mozart/context"

describe "Mozart.context" do

  it "must restrict method calls" do
    stack_builder = Mozart.context(:push, :pop)
    stack = stack_builder.new([])

    stack.push(2)
    stack.push(3)

    stack.pop.must_equal 3
    stack.pop.must_equal 2

    assert_raises(NotImplementedError) do
      stack[0]
    end
  end
end
