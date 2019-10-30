
class Bottles
  def song()
    verses(99, 0)
  end
​
  def verses(starting, ending)
    verse_arr = []
    starting.downto(ending) do |n|
      verse_arr << verse(n)
    end
    verse_arr.join("\n")
  end
​
  def verse(n)
    bottle_number = BottleNumber.new(n)
    next_bottle_number = BottleNumber.new(bottle_number.successor)
      <<-VERSE
#{bottle_number.quantity.capitalize} #{bottle_number.package} of beer on the wall, #{bottle_number.quantity} #{bottle_number.package} of beer.
#{bottle_number.action}, #{next_bottle_number.quantity} #{next_bottle_number.package} of beer on the wall.
VERSE
  end
end
​
​
​
# An explanation of reasoning for extracting out BottleNumber: `Primitive Obsession` is when you use one a data class (String, Integer, Array, Hash) to represent a concept in your domain. In this case it was n / n-1. Obsessing on a privimitive results in code that passes built-in types around and supplies behaviour for them. The cure for `Primitive Obsession` is to create a new class to use in place of the primitive. 
​
​
class BottleNumber
  attr_reader :n # no setter because never setting n!
    def initialize(n)
      @n = n
    end
​
  def action
    n == 0 ? "Go to the store and buy some more" : "Take #{identifier} down and pass it around"
  end
​
  def successor
    n == 0 ? 99 : n-1
  end
​
  def package
    n == 1 ? 'bottle' : 'bottles'
  end
​
  def quantity
    case n
    when 0
      'no more'
    when -1 
      "99"
    else
      n.to_s
    end
  
  end
​
  private   # private because only being used internally by action!
​
  def identifier
    n == 1 ? 'it' : 'one'
  end
​
end