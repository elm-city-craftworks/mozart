require_relative "lib/mozart"

class BasicCalculator
  include Mozart::Composable

  def initialize
    data = []

    features  << Mozart.context(:push).new(data)
    internals << Mozart.context(:reduce, :clear).new(data)
  end

  def sum
    _(:reduce, 0, :+).tap { _(:clear) }
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
    data = Mozart.value(:name, :email).new(params) 

    features << data
  end

  def to_s
    "#{name} <#{email}>"
  end
end


person = Person.new(:name  => "Gregory Brown",
                    :email => "gregory.t.brown@gmail.com")

puts person
