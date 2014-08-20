#!/usr/bin/ruby

class A
  def hello
    puts "hello " + name
#    puts "hello " + self.name # error. private methods can not be called with self as a receiver
  end

  private
  def name
    "me is me"
  end
end

a = A.new
a.hello

def my_method
  42
end

puts self.class
puts self.methods.sort.inspect
puts self.my_method # private method called for main:Object
