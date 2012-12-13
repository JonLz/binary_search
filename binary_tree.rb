require 'rspec'

class BinaryTree
	class Node
		attr_accessor :value, :right, :left
		def initialize( value, right=nil, left=nil)
			@value = value
			@left, @right = left, right
		end

		def insert( value )
      if value >= @value then
        # insert right
        if @right.nil?
          @right = Node.new( value )
        else
          @right.insert( value )
        end
      else
        # insert left
        if @left.nil?
          @left = Node.new( value )
        else
          @left.insert( value )
        end
      end
    end

    # depth first (from left to right)
    def traverse(&b)
      @left.traverse(&b) if @left
      b.call(self)
      @right.traverse(&b) if @right
    end
	end

	attr_accessor :root

	def initialize
		@root = nil
	end

	def insert( value )
		if @root.nil?
			@root = Node.new( value )
		else
			@root.insert( value )
		end
	end

	def traverse(&b)
    return if @root.nil?
    @root.traverse(&b)
  end

  def find( value )
  	return if @root.nil?
  	@root.traverse
end

# tests below
describe BinaryTree do
	before (:each) do
		@tree = BinaryTree.new
	end

	it 'can create a root node which is nil' do
		@tree.should respond_to(:root)
		@tree.root.should be_nil
	end

	it 'can insert a new node into the root' do
		@tree.insert(1)
		@tree.root.should_not be_nil
		@tree.root.should be_instance_of(BinaryTree::Node)
	end
	
	describe BinaryTree::Node do
		before (:each) do
			@node = BinaryTree::Node.new(100)
		end

		it 'can have node children to the right or left' do
			@node.should respond_to(:right)
			@node.should respond_to(:left)
			@node.right.should be_nil
			@node.left.should be_nil
		end

		it 'can store a value' do
			@node.value.should_not be_nil
		end

		it 'properly sorts new nodes' do
			@node.insert(200)
			@node.right.value.should eq 200
			
			@node.insert(50)
			@node.left.value.should eq 50

			@node.insert(300)
			@node.right.right.value.should eq 300
		end
	end
end

describe 'integration test for binary tree and nodes' do
	it 'can traverse and properly return values' do
		tree = BinaryTree.new
		array = [4,1,7,4,6,7,2,5,1,10]
		array.each { |x| tree.insert( x ) }
		sorted_array = Array.new
		tree.traverse do |node|
			sorted_array << node.value
		end
		sorted_array.should eq array.sort
	end
end