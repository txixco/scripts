class Node:
	def __init__(self, value: int) -> None:
		self.value = value
		self.next = None


class Queue:
	def __init__(self, value: int = None) -> None:
		if value is None:
			self.make_empty()
			return

		new_node = Node(value)
		self.first = new_node
		self.last = new_node
		self.length = 1
			
	def make_empty(self):
		self.first = None
		self.last = None
		self.length = 0
	
	def print_queue(self) -> None:
		if self.first is None:
			print("empty queue")
		else:
			temp = self.first
			values = []
			while temp is not None:
				values.append(str(temp.value))
				temp = temp.next

			print(" -> ".join(values))

	def enqueue(self, value: int) -> bool:
		new_node = Node(value)

		if not self.first:
			self.first = new_node
			self.last = new_node
		else:
			self.last.next = new_node
			self.last = new_node
		
		self.length += 1

		return True

	def dequeue(self) -> Node:
		if not self.first:
			return None

		return_node = self.first
		self.first = self.first.next

		if not self.first:
			self.last = None

		self.length -= 1

		return return_node
			


# ----------- TEST CODE ------------

my_queue = Queue(1)
my_queue.enqueue(2)

# (2) Items - Returns 2 Node
print(my_queue.dequeue().value)
# (1) Item -  Returns 1 Node
print(my_queue.dequeue().value)
# (0) Items - Returns None
print(my_queue.dequeue())



"""
    EXPECTED OUTPUT:
    ----------------
    1
    2
    None

"""