from dataclasses import dataclass
from enum import Enum
from typing import Protocol, Any

@dataclass
class Book:
    """ Data class representing a book in the database """
    
    chat_id: int
    title: str
    status: str

    def __post_init__(self):
        if not isinstance(self.chat_id, int):
            raise ValueError("chat_id must be an integer")
        if not isinstance(self.title, str):
            raise ValueError("title must be a string")
        if self.status is not None and not isinstance(self.status, (str, int)):
            raise ValueError("status must be a string or an integer")

class Status(Enum):
    """ Enum for book status """

    UNREAD = "UNREAD"
    READING = "READING"
    READ = "READ"


    def emoji(self) -> str:
        """ Returns an icon representation of the status """
        return {
            Status.UNREAD: '📚',
            Status.READING: '📖',
            Status.READ: '✅'
        }[self]

class BookwormDB(Protocol):
    """ Protocol for Bookworm database operations """

    def upsert_chat(self, chat_id: int, who: dict) -> None:
        """ Ensures the chat exists in the database """
        ...
    def add(self, chat_id: int, title: str) -> None:
        """ Add a book to the database for a specific chat """
        ...

    def remove(self, chat_id: int, title: str | None) -> bool:
        """ Remove a book from the database for a specific chat """
        ...

    def list(self, chat_id: int) -> list[Book]:
        """ List all books for a specific chat """
        ...

    def next(self, chat_id: int) -> Book | None:
        """ Get the next book to read for a specific chat """
        ...

    def get(self, chat_id: int, title: str) -> Book | None:
        """ Get a specific book by title for a specific chat """
        ...

    def read(self, chat_id: int, title: str) -> None:
        """ Mark a book as reading for a specific chat """
        ...

    def finish(self, chat_id: int, title: str) -> None:
        """ Mark a book as read for a specific chat """
        ...