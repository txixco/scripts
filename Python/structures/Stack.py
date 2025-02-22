class Node:
	def __init__(self, value: int) -> None:
		self.value = value
		self.next = None


class Stack:
	def __init__(self, value: int = None) -> None:
		if value is None:
			self.make_empty()
			return

		new_node = Node(value)
		self.top = new_node
		self.height = 1
			
	def make_empty(self):
		self.top = None
		self.height = 0
	
	def print_stack(self) -> None:
		if not self.top:
			print("empty stack")
		else:
			temp = self.top
			values = []
			while temp:
				values.append(f"|{str(temp.value)}|")
				temp = temp.next

			print("\n".join(values))

	def push(self, value: int) -> bool:
		new_node = Node(value)

		if self.top:
			new_node.next = self.top
		
		self.top = new_node
		self.height += 1

		return True
 
	def pop(self) -> Node:
		if not self.top:
			return None

		temp = self.top
		if self.height == 1:
			self.top = None
		else:
			self.top = temp.next
			temp.next =  None

		self.height -= 1

		return temp 
			


# ----------- TEST CODE ------------

my_stack = Stack(4)
my_stack.push(3)
my_stack.push(2)
my_stack.push(1)

print('Stack before pop():')
my_stack.print_stack()

print('\nPopped node:')
print(my_stack.pop().value)

print('\nStack after pop():')
my_stack.print_stack()
