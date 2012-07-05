require_relative "lib/mozart"

# this generates a wrapper which will delegate
# methods to a target object, but prevents
# public calls to anything not in the whitelist

Stack = Mozart.context(:push, :pop) do
  def each
    target.reverse_each { |e| yield(e) }
  end
end

# messages are sent to each of these objects
# in order until one matches.

EnumerableStack = Mozart.delegator do |params|
  [params[:stack], params[:enum]]
end

stack = Stack.new([])
stack.push(1)
stack.push(2)
stack.push(3)

# this will raise an error
# stack[0]

enum = Enumerator.new { |yielder| stack.each { |e| yielder.yield(e) } }

enum_stack = EnumerableStack.new(:stack => stack, :enum  => enum)

enum_stack.pop
enum_stack.push(4)
p enum_stack.map { |x| "..#{x}.."}
