require "minitest/autorun"

require_relative "../lib/mozart/value" 
require_relative "../lib/mozart/delegator" 

describe "Mozart.delegator" do
  let(:position_class) do
    Mozart.value(:x,:y) do 
      def distance(other)
        Math.hypot(x-other.x, y-other.y)
      end
    end
  end

  let(:label_class) do
    Mozart.value(:name) do
      def short_name
        name[0..4] + "..."
      end
    end
  end

  it "should do something fun!" do
    Pin = Mozart.delegator do |params|
      [params[:position], params[:label]]
    end

    pin1 = Pin.new(:position => position_class.new(:x => 10, :y => 20),
                   :label    => label_class.new(:name => "Home Base"))

    pin2 = Pin.new(:position => position_class.new(:x => 10, :y => 30),
                   :label    => label_class.new(:name => "Enemy Base"))

    pin1.distance(pin2).must_equal(10)
    pin1.short_name.must_equal("Home ...")
  end
end
