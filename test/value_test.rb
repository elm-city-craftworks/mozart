require "minitest/autorun"
require_relative "../lib/mozart/value"

describe "Mozart.value" do
  it "produces Struct-like classes" do
    pos_builder = Mozart.value(:x, :y)

    pos1 = pos_builder.new(:x => 10, :y => 20)
    pos1.x.must_equal(10)
    pos1.y.must_equal(20)

    pos2   = pos_builder.new
    pos2.x = 3
    pos2.y = 5

    pos2.x.must_equal(3)
    pos2.y.must_equal(5)
  end

  it "implements equality" do
    pos_builder = Mozart.value(:x, :y)

    pos1 = pos_builder.new(:x => 10, :y => 15)
    pos2 = pos_builder.new(:x => pos1.x, :y => pos1.y + 1)

    pos1.wont_equal(pos2)

    pos2.y = pos1.y

    pos1.must_equal(pos2)
  end

  it "implements hash" do
    pos_builder = Mozart.value(:x, :y)

    pos1 = pos_builder.new(:x => 10, :y => 15)
    pos2 = pos_builder.new(:x => pos1.x, :y => pos1.y)

    data = { pos1 => true }

    assert data[pos1]
    assert data[pos2]

    pos2.x = pos1.x + 1

    assert data[pos1]
    refute data[pos2]
  end
end
