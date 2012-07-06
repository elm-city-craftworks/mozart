require "minitest/autorun"
require_relative "../lib/mozart/value"

describe "Mozart.value" do
  it "produces Struct-like classes" do
    pos_builder = Mozart.value(:x, :y)

    pos1 = pos_builder.new(:x => 10, :y => 20)
    pos1.x.must_equal(10)
    pos1.y.must_equal(20)
  end

  it "can be converted into a Hash object" do
    pos_builder = Mozart.value(:x, :y)

    pos1 = pos_builder.new(:x => 10, :y => 20)

    pos1.to_hash.must_equal(:x => 10, :y => 20)
  end

  it "implements equality" do
    pos_builder = Mozart.value(:x, :y)

    pos1 = pos_builder.new(:x => 10, :y => 15)
    pos2 = pos_builder.new(:x => pos1.x,     :y => pos1.y)
    pos3 = pos_builder.new(:x => pos1.x + 1, :y => pos1.y)

    pos1.must_equal(pos2)

    pos1.wont_equal(pos3)
    pos2.wont_equal(pos3)
  end

  it "implements hash" do
    pos_builder = Mozart.value(:x, :y)

    pos1 = pos_builder.new(:x => 10,         :y => 15)
    pos2 = pos_builder.new(:x => pos1.x,     :y => pos1.y)
    pos3 = pos_builder.new(:x => pos1.x + 1, :y => pos1.y)

    data = { pos1 => true }

    assert data[pos1]
    assert data[pos2]
    refute data[pos3]
  end
end
