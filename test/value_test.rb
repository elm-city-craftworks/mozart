require "minitest/autorun"
require_relative "../lib/mozart/value"

describe "Mozart.value" do
  it "produces Struct-like classes" do
    Position = Mozart.value(:x, :y)

    pos1 = Position.new(:x => 10, :y => 20)
    pos1.x.must_equal(10)
    pos1.y.must_equal(20)

    pos2   = Position.new
    pos2.x = 3
    pos2.y = 5

    pos2.x.must_equal(3)
    pos2.y.must_equal(5)
  end
end
