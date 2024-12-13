class Node:
	def __init__(self, value: int) -> None:
		self.value = value
		self.next = None
		self.prev = None


class DoublyLinkedList:
	def __init__(self, value: int = None) -> None:
		if value is None:
			self.make_empty()
			return

		new_node = Node(value)
		self.head = new_node
		self.tail = new_node
		self.length = 1
			
	def make_empty(self):
		self.head = None
		self.tail = None
		self.length = 0
	
	def print_list(self) -> None:
		if self.head is None:
			print("empty list")
		else:
			temp = self.head
			values = []
			while temp is not None:
				values.append(str(temp.value))
				temp = temp.next

			print(" <-> ".join(values))

	def append(self, value: int) -> bool:
		new_node = Node(value)

		if not self.head:
			self.head = new_node
			self.tail = new_node
		else:
			new_node.prev = self.tail
			self.tail.next = new_node
			self.tail = new_node
		
		self.length += 1

		return True
 
	def pop(self) -> Node:
		if not self.head:
			return None

		if self.head == self.tail:
			return_node = self.head
			self.head = None
			self.tail = None
		else:
			return_node = self.tail
			self.tail = self.tail.prev
			self.tail.next = None
			return_node.prev = None

		self.length -= 1

		return return_node 

	def pop_first(self) -> Node:
		if not self.head:
			return None

		return_node = self.head

		if self.length == 1:
			self.head = None
			self.tail = None
		else:
			self.head = self.head.next
			self.head.prev = None
			return_node.next = None

		self.length -= 1

		return return_node
  
	def prepend(self, value: int) -> None:
		new_node = Node(value)

		if not self.head:
			self.tail = new_node
		else:
			new_node.next = self.head
			self.head.prev = new_node

		self.head = new_node
		self.length += 1
	
	def get(self, index: int) -> Node:
		if not (0 <= index <= self.length-1):
			return None
		
		if index < self.length / 2:
			temp = self.head
			for _ in range(1, index+1):
				temp = temp.next
		else:
			temp = self.tail
			for _ in range(self.length-1, index, -1):
				temp = temp.prev

		return temp	
		
	def set_value(self, index: int, value: int) -> bool:
		temp = self.get(index)

		if not temp:
			return False
		
		temp.value = value
		
		return True
	
	def insert(self, index: int, value: int) -> bool:
		if index == 0:
			self.prepend(value)
			return True
		
		if index == self.length:
			self.append(value)
			return True

		next_node = self.get(index)

		if not next_node:
			return False
		
		temp = Node(value)
		before = self.get(index-1)
		after = before.next
		temp.prev = before
		temp.next = after
		before.next = temp
		after.prev = temp
		self.length += 1

		return True

	def remove(self, index: int) -> Node:
		if not 0 <= index < self.length:
			return None

		if index == 0:
			return self.pop_first()

		if index == self.length - 1:
			return self.pop()

		temp = self.get(index)
		temp.next.prev = temp.prev
		temp.prev.next = temp.next
		temp.next = None
		temp.prev = None
		self.length -= 1

		return temp

	def swap_first_last(self):
		if not self.head:
			return
		
		(self.head.value, self.tail.value) = (self.tail.value, self.head.value)

	def reverse(self) -> None:
		if self.length == 0 or self.length == 1:
			return

		current = self.head

		while current:
			temp = current.next
			current.next = current.prev
			current.prev = temp
			current = temp

		temp = self.tail
		self.tail = self.head
		self.head = temp

	def is_palindrome(self):
		if not self.head:
			return True

		left = self.head
		right = self.tail
		l = 1
		r = self.length
		while l <= r:
			if left.value != right.value:
				return False
			
			left = left.next
			right = right.prev
			l += 1
			r -= 1

		return True

	def swap_pairs(self) -> None:
		if self.length < 2:
			return
		
		left = self.head
		while left and left.next:
			right = left.next
			(left.value, right.value) = (right.value, left.value)
			left = right.next


# ----------- TEST CODE ------------

my_dll = DoublyLinkedList(1)
my_dll.append(2)
my_dll.append(3)
my_dll.append(4)

print('my_dll before swap_pairs:')
my_dll.print_list()

my_dll.swap_pairs() 


print('my_dll after swap_pairs:')
my_dll.print_list()


"""
    EXPECTED OUTPUT:
    ----------------
    my_dll before swap_pairs:
    1 <-> 2 <-> 3 <-> 4
    ------------------------
    my_dll after swap_pairs:
    2 <-> 1 <-> 4 <-> 3

"""