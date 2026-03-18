#!/usr/bin/env python3

from os import getenv
from telepot import Bot, glance
from telepot.loop import MessageLoop
from dotenv import load_dotenv
from threading import Thread, Event
from time import sleep

from bot_management import show_help, keep_typing, parse_command
from bwtinydb import BWTinyDB
from bookwormdb import BookwormDB, Status

load_dotenv()

TELEGRAM_TOKEN: str = str(getenv('WORMBOOK_TOKEN'))
if not TELEGRAM_TOKEN:
	print('Error: TOKEN no encontrado.')
	exit(1)

bot: Bot = Bot(TELEGRAM_TOKEN)
db: BookwormDB = BWTinyDB()

def add(chat_id, title: str | None):
	""" Adds a book to the database for the specified chat """

	if not title:
		bot.sendMessage(chat_id=chat_id, 
						text='Debe especificar el título del libro a añadir')
		return

	db.add(chat_id=chat_id, title=title)
	bot.sendMessage(chat_id, f'Libro «{title}» añadido a tu lista')

def remove(chat_id, title: str | None):
	""" Removes a book from the database for the specified chat """

	if not title:
		bot.sendMessage(chat_id, 'Debe especificar el título del libro a eliminar')
		return

	if db.remove(chat_id=chat_id, title=title):
		bot.sendMessage(chat_id, f'Libro «{title}» eliminado de tu lista')
	else:
		bot.sendMessage(chat_id, f'No se ha encontrado el libro «{title}»')

def list(chat_id: int):
	""" Lists all books for the specified chat """

	books = db.list(chat_id=chat_id)
	if not books:
		bot.sendMessage(chat_id, 'No tienes libros en tu lista')
		return

	text = '*Lista de libros*\n\n'
	for book in books:
		status = book.status if book.status else Status.UNREAD.value
		text += f'  - {book.title} {Status(status).emoji()}\n'

	text += f'\n({Status.UNREAD.emoji()} = No leído, {Status.READING.emoji()} = Leyendo, {Status.READ.emoji()} = Leído)'

	bot.sendMessage(chat_id, text=text, parse_mode='Markdown')

def next(chat_id: int):
	""" Gets the next book to read for the specified chat """

	book = db.next(chat_id=chat_id)
	if not book:
		bot.sendMessage(chat_id, 'No tienes libros pendientes por leer')
		return

	bot.sendMessage(chat_id, f'Tu próximo libro es: _{book.title}_', parse_mode='Markdown')

def read(chat_id: int, title: str | None):
	""" Marks a book as reading for the specified chat """

	if not title:
		book = db.next(chat_id=chat_id)
	else:
		book = db.get(chat_id=chat_id, title=title)

	if not book:
		bot.sendMessage(chat_id, 'No se ha encontrado el libro')
		return

	if book.status == Status.READING.value:
		bot.sendMessage(chat_id, f'Ya estás leyendo _{book.title}_', parse_mode='Markdown')
		return

	if book.status == Status.READ.value:
		bot.sendMessage(chat_id, f'Ya has leído _{book.title}_. Usa /reread para volver a leerlo', parse_mode='Markdown')
		return
	
	db.read(chat_id=chat_id, title=book.title)
	bot.sendMessage(chat_id, f'Ahora estás leyendo _{book.title}_', parse_mode='Markdown')

def reread(chat_id: int, title: str | None):
	""" Marks a book as rereading for the specified chat """

	if not title:
		bot.sendMessage(chat_id, 'Debe especificar el título del libro a volver a leer')
		return

	book = db.get(chat_id=chat_id, title=title)
	if not book:
		bot.sendMessage(chat_id, 'No se ha encontrado el libro')
		return

	if book.status == Status.READING.value:
		bot.sendMessage(chat_id, f'Ya estás leyendo _{book.title}_', parse_mode='Markdown')
		return

	db.read(chat_id=chat_id, title=book.title)
	bot.sendMessage(chat_id, f'Ahora estás volviendo a leer _{book.title}_', parse_mode='Markdown')

def finish(chat_id: int, title: str | None):
	""" Marks a book as finished for the specified chat """

	if not title:
		bot.sendMessage(chat_id, 'Debe especificar el título del libro a marcar como leído')
		return

	book = db.get(chat_id=chat_id, title=title)
	if not book:
		bot.sendMessage(chat_id, 'No se ha encontrado el libro')
		return

	if book.status == Status.READ.value:
		bot.sendMessage(chat_id, f'Ya has leído _{book.title}_. Usa /reread para volver a leerlo', parse_mode='Markdown')
		return

	db.finish(chat_id=chat_id, title=book.title)
	bot.sendMessage(chat_id, f'Has marcado _{book.title}_ como leído', parse_mode='Markdown')

def process_command(chat_id: int, command:str, args:str, who: dict) -> None:
	""" Processes the command received from the user """

	match command:
		case '/start':
			bot.sendMessage(chat_id, f'¡Bienvenido, {who['first_name']}!')
			show_help(TELEGRAM_TOKEN, chat_id)
		case '/help':
			show_help(TELEGRAM_TOKEN, chat_id)
		case '/add':
			add(chat_id=chat_id, title = args)
		case '/remove':
			remove(chat_id=chat_id, title=args)
		case '/list':
			list(chat_id=chat_id)
		case '/next':
			next(chat_id=chat_id)
		case '/read':
			read(chat_id=chat_id, title=args)
		case '/reread':
			reread(chat_id=chat_id, title=args)
		case '/finish':
			finish(chat_id=chat_id, title=args)
		case _:
			bot.sendMessage(chat_id, 'Comando no reconocido.')
			show_help(TELEGRAM_TOKEN, chat_id)
				
def msg_loop(msg: dict) -> None:
	""" Main message loop to handle incoming messages """

	global bot

	content_type, chat_type, chat_id, *_ = glance(msg)
	text = msg['text']
	who = msg['from']

	db.upsert_chat(chat_id=chat_id, who=who)
	
	if content_type == 'text' and text.startswith('/'):
		command, args = parse_command(text=text)
		process_command(chat_id=chat_id, command=command, args=args, who=who)
	else:
		bot.sendMessage(chat_id, text)

def main() -> None:
	""" Main function to start the bot and message loop """

	global bot

	MessageLoop(bot, msg_loop).run_as_thread()

	while True:
		sleep(5)

if __name__ == '__main__':
	main()