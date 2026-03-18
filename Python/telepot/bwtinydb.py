from tinydb import TinyDB, Query
from tinydb.table import Table, Document

from bookwormdb import Book, Status

class BWTinyDB:
    """ Class to access the Bookworm TinyDB database """

    def __init__(self) -> None:
        self._db = TinyDB('bookwormdb.json')
        self._tabla_libros: Table = self._db.table('books')
        self._tabla_chats: Table= self._db.table('chats')
        self._Libro = Query()
        self._Chat = Query()

    def upsert_chat(self, chat_id: int, who: dict) -> None:
        """ Ensures the chat exists in the database """

        self._tabla_chats.upsert({'chat_id': chat_id,
                                  'first_name': who['first_name'],
                                  'last_name': who.get('last_name', ''),
                                 }, self._Chat.chat_id == chat_id)

    def add(self, chat_id: int, title: str) -> None:
        """ Add a book to the database for a specific chat """

        if not self._tabla_chats.contains(self._Chat.chat_id == chat_id):
            self._tabla_chats.insert({'chat_id': chat_id})

        self._tabla_libros.upsert({ 'chat_id': chat_id, 
                                    'title': title, 
                                    'status': Status.UNREAD.value }, 
                                   self._Libro.title == title)

    def remove(self, chat_id: int, title: str | None) -> bool:
        """ Remove a book from the database for a specific chat """

        if not title:
            return False

        result = self._tabla_libros.remove((self._Libro.chat_id == chat_id) & 
                                           (self._Libro.title == title))

        return len(result) > 0

    def list(self, chat_id: int) -> list[Book]:
        """ List all books for a specific chat """

        books = self._tabla_libros.search(self._Libro.chat_id == chat_id)
        if not books:
            return []

        return [ Book(chat_id=book['chat_id'], 
                      title=book['title'], 
                      status=book['status']) for book in books ]

    def next(self, chat_id: int) -> Book | None:
        """ Get the next book to read for a specific chat """

        books = self._tabla_libros.search((self._Libro.chat_id == chat_id) & 
                                          (self._Libro.status == Status.UNREAD.value))
        if not books:
            return None

        return Book(chat_id=books[0]['chat_id'], 
                    title=books[0]['title'], 
                    status=books[0]['status'])

    def get(self, chat_id: int, title: str) -> Book | None:
        """ Get a specific book by title for a specific chat """

        book = self._tabla_libros.get((self._Libro.chat_id == chat_id) & 
                                      (self._Libro.title == title))
        if not book:
            return None

        if isinstance(book, list):
            book = book[0]

        return Book(chat_id=book['chat_id'], 
                    title=book['title'], 
                    status=book['status'])

    def read(self, chat_id: int, title: str) -> None:
        """ Mark a book as read for a specific chat """

        self._tabla_libros.update({'status': Status.READING.value}, 
                                  (self._Libro.chat_id == chat_id) & 
                                  (self._Libro.title == title))

    def finish(self, chat_id: int, title: str) -> None:
        """ Mark a book as read for a specific chat """

        self._tabla_libros.update({'status': Status.READ.value}, 
                                  (self._Libro.chat_id == chat_id) & 
                                  (self._Libro.title == title))