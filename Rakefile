# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

desc "Sort the array"
task :sort_array do
  array = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
  n = array.length
  for i in 0..n-1
    for j in 0..n-i-1
      if array[j+1] && array[j] > array[j+1]
        array[j], array[j+1] = array[j+1], array[j]
      end
    end
  end
  puts array
end

desc "Singleton class"
task :singleton_class do
  object = Object.new

  def object.object_specific_method
    puts "This method is declared for object only and is independent of class.
      In real, there's a different class (Singleton) which is declared for this object"
  end

  object.object_specific_method
end

desc "Append and prepend to array"
task :append_and_prepend_to_array do
  array = [1, 2]
  array << 3
  puts "Append 3 -> #{array}"
  array.insert(0, 0)
  puts "Prepend 0 -> #{array}"
end

desc "linked list"
task :linked_list do
  linked_list = LinkedList.new
  linked_list.insert(1)
  linked_list.insert(2)
  linked_list.insert(3)
  linked_list.insert(4)
  linked_list.insert(5)

  puts "Linked List =>"
  linked_list.traverse

  linked_list.delete(2)

  puts "Linked List after Deletion =>"
  linked_list.traverse

  puts "Linked List in Reverse Order =>"
  linked_list.reverse
end

class Node
  attr_accessor :data, :next

  def initialize(data)
    @data = data
    @next = nil
  end
end

class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  def insert(data)
    new_node = Node.new(data)
    if @head.nil?
      @head = new_node
    else
      current = @head
      while current.next
        current = current.next
      end
      current.next = new_node
    end
  end

  def delete(data)
    return if @head.nil?
    if @head.data == data
      @head = @head.next
      return
    end
    current = @head
    while current.next && current.next.data != data
      current = current.next
    end
    return if current.next.nil?
    current.next = current.next.next
  end

  def traverse
    current = @head
    while current
      puts current.data
      current = current.next
    end
  end

  def reverse(node = @head)
    return if node.nil?
    reverse(node.next)
    puts node.data
  end
end
