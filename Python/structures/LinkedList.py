class Node:
	def __init__(self, value: int) -> None:
		self.value = value
		self.next = None


class LinkedList:
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

			print(" -> ".join(values))

	def append(self, value: int) -> bool:
		new_node = Node(value)

		if not self.head:
			self.head = new_node
			self.tail = new_node
		else:
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
			previous = self.head
			while previous.next != self.tail:
				previous = previous.next

			return_node = self.tail
			previous.next = None
			self.tail = previous

		self.length -= 1

		return return_node 

	def pop_first(self) -> Node:
		if not self.head:
			return None

		return_node = self.head
		self.head = self.head.next

		if not self.head:
			self.tail = None

		self.length -= 1

		return return_node
  
	def prepend(self, value: int) -> None:
		new_node = Node(value)

		if not self.head:
			self.tail = new_node
		else:
			new_node.next = self.head

		self.head = new_node
		self.length += 1
	
	def get(self, index: int) -> Node:
		if not (0 <= index <= self.length-1):
			return None
		
		traverser = self.head

		for _ in range(1, index+1):
			traverser = traverser.next

		return traverser	
		
	def set_value(self, index: int, value: int) -> bool:
		node = self.get(index)

		if not node:
			return False
		
		node.value = value
		
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
		
		node = Node(value)
		previous_node = self.get(index-1)
		previous_node.next = node
		node.next = next_node
		self.length += 1

		return True

	def remove(self, index: int) -> Node:
		if index < 0 or index >= self.length:
			return None

		if index == 0:
			return self.pop_first()

		if index == self.length - 1:
			return self.pop()

		pre = self.get(index - 1)
		temp = pre.next
		pre.next = temp.next
		temp.next = None
		self.length -= 1

		return temp

	def reverse(self) -> None:
		if self.length == 0 or self.length == 1:
			return

		prev_node = self.head
		next_node = prev_node.next
		prev_node.next = None

		while next_node:
			temp = next_node.next
			next_node.next = prev_node
			prev_node = next_node
			next_node = temp

		temp = self.tail
		self.tail = self.head
		self.head = temp

	def find_middle_node(self) -> Node:
		if not self.head:
			return None

		selected: Node = self.head
		if not selected.next:
			return selected
		
		temporary: Node = selected.next.next
		while temporary and temporary.next:
			temporary = temporary.next.next
			selected = selected.next

		return selected.next

	def has_loop(self) -> bool:
		slow: Node = self.head
		fast: Node = self.head

		while fast and fast.next:
			slow = slow.next
			fast = fast.next.next

			if slow == fast:
				return True
		
		return False

	def find_kth_from_end(self, k: int) -> Node:
		if k < 1:
			return None

		slow: Node = self.head
		fast: Node = self.head

		for i in range(k):
			if not fast:
				return None

			fast = fast.next

		while fast:
			slow = slow.next
			fast = fast.next
		
		return slow

	def partition_list(self, value: int) -> Node:
		lesser = LinkedList()
		bigger = LinkedList()
		pointer = self.head

		while pointer:
			if pointer.value < value:
				lesser.append(pointer.value)
			else:
				bigger.append(pointer.value)

			pointer = pointer.next
		
		if lesser.tail:
			lesser.tail.next = bigger.head
		else:
			lesser.head = bigger.head

		self.head = lesser.head
		self.tail = bigger.tail

	def remove_duplicates(self) -> None:
		previous: Node = self.head
		current: Node = self.head
		values: set = set()

		while current:
			if current.value in values:
				previous.next = current.next
				current.next = None
			else:
				values.add(current.value)
				previous = current

			current = previous.next

	def binary_to_decimal(self) -> int:
		current: Node = self.head
		power: int = self.length - 1
		decimal: int = 0

		while current:
			if current.value not in range(2):
				raise ValueError("The linked list is not a representation of a binary number")

			decimal += current.value * (2 ** power)
			current = current.next
			power -= 1

		return decimal
			


# ----------- TEST CODE ------------

# Test case 1: Binary number 110 = Decimal number 6
linked_list = LinkedList(1)
linked_list.append(1)
linked_list.append(0)
result = linked_list.binary_to_decimal()
try:
    assert result == 6
    print("Test case 1 passed, returned: ", result)
except AssertionError:
    print("Test case 1 failed, returned: ", result)

# Test case 2: Binary number 1000 = Decimal number 8
linked_list = LinkedList(1)
linked_list.append(0)
linked_list.append(0)
linked_list.append(0)
result = linked_list.binary_to_decimal()
try:
    assert result == 8
    print("Test case 2 passed, returned: ", result)
except AssertionError:
    print("Test case 2 failed, returned: ", result)

# Test case 3: Binary number 0 = Decimal number 0
linked_list = LinkedList(0)
result = linked_list.binary_to_decimal()
try:
    assert result == 0
    print("Test case 3 passed, returned: ", result)
except AssertionError:
    print("Test case 3 failed, returned: ", result)

# Test case 4: Binary number 1 = Decimal number 1
linked_list = LinkedList(1)
result = linked_list.binary_to_decimal()
try:
    assert result == 1
    print("Test case 4 passed, returned: ", result)
except AssertionError:
    print("Test case 4 failed, returned: ", result)

# Test case 5: Binary number 1101 = Decimal number 13
linked_list = LinkedList(1)
linked_list.append(1)
linked_list.append(0)
linked_list.append(1)
result = linked_list.binary_to_decimal()
try:
    assert result == 13
    print("Test case 5 passed, returned: ", result)
except AssertionError:
    print("Test case 5 failed, returned: ", result)
    
 
"""
    EXPECTED OUTPUT:
    ----------------
    Test case 1 passed, returned:  6
    Test case 2 passed, returned:  8
    Test case 3 passed, returned:  0
    Test case 4 passed, returned:  1
    Test case 5 passed, returned:  13
"""

