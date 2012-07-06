require_relative "lib/mozart"

class BasicCalculator
  include Mozart::Composable
  include Mozart::SingleAssignment

  def initialize
    array = []

    features << X(:push, array)

    _(:data, X(:reduce, :clear, array))
  end

  def sum
    _(:data).reduce(0, :+).tap { _(:data).clear }
  end
end

stack = BasicCalculator.new
stack.push(10)
stack.push(20)
stack.push(30)

p stack.sum

stack.push(20)
stack.push(50)

p stack.sum


class Person
  include Mozart::Composable

  def initialize(params)
    features << V(:name, :email, params) 
  end

  def to_s
    "#{name} <#{email}>"
  end
end


person = Person.new(:name  => "Gregory Brown",
                    :email => "gregory.t.brown@gmail.com")

puts person
