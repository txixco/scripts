#!/usr/bin/env python3

from os import getenv
from telepot import Bot, glance
from telepot.loop import MessageLoop
from dotenv import load_dotenv
from requests import get
from threading import Thread, Event
from time import sleep

load_dotenv()

TELEGRAM_TOKEN = getenv("TEST_TOKEN")
if not TELEGRAM_TOKEN:
	print("Error: TOKEN no encontrado.")
	exit(1)

bot: Bot = None
visits: dict = {}

def get_commands() -> list:
	req = get("https://api.telegram.org/bot{}/getMyCommands".format(TELEGRAM_TOKEN))

	data = req.json()
	if data["ok"]:
		return data["result"]
	else:
		print("Error en la respuesta de la API.")
		return []

def show_help(chat_id: int) -> None:
	commands = get_commands()
	if not commands:
		bot.sendMessage(chat_id, "No hay comandos disponibles.")
		return

	text = "🤖 Comandos disponibles:\n\n"
	for command in commands:
		text += f"    /{command['command']} - {command['description']}\n"

	bot.sendMessage(chat_id, text)

def keep_typing(chat_id, stop_event):
    while not stop_event.is_set():
        bot.sendChatAction(chat_id, 'typing')
        sleep(1)

def obtain_fake_data(chat_id: str) -> dict:
	data: dict = None
	stop_event = Event()
	typing_thread = Thread(target=keep_typing, args=(chat_id, stop_event))
	typing_thread.start()

	try:
		req = get("https://randomuser.me/api/")
		if req.status_code == 200:
			data = req.json()
	finally:
		stop_event.set()
		typing_thread.join()

	return data

def process_command(chat_id: int, text: str, who: dict) -> None:
	match text:
		case "/start":
			bot.sendMessage(chat_id, f"¡Bienvenido, {who['first_name']}!")
			show_help(chat_id)
		case "/help":
			show_help(chat_id)
		case "/me":
			bot.sendMessage(chat_id, f"Tu nombre es {who['first_name']} {who['last_name']}")
		case "/fake":
			obtained_data = obtain_fake_data(chat_id)
			if obtained_data:
				user = obtained_data["results"][0]
				name = user["name"]
				email = user["email"]
				bot.sendMessage(chat_id, f"{name['first']} {name['last']}\n{email}")
			else:
				bot.sendMessage(chat_id, obtained_data)
		case _:
			bot.sendMessage(chat_id, "Comando no reconocido.")
			show_help(chat_id)
				
def msg_loop(msg: str) -> None:
	global bot
	global visits

	content_type, chat_type, chat_id = glance(msg)
	text = msg["text"]
	who = msg["from"]
	visits[chat_id] = visits.get(chat_id, 0) + 1
	
	if content_type == "text" and text.startswith("/"):
		process_command(chat_id, text, who)
	else:
		bot.sendMessage(chat_id, text)
	
	if visits[chat_id] == 5:
		bot.sendMessage(chat_id, "¡Por Cutie!, sí que te está gustando el bot 🦾")

def main() -> None:
	global bot

	bot = Bot(TELEGRAM_TOKEN)
	MessageLoop(bot, msg_loop).run_as_thread()

	while True:
		sleep(5)

if __name__ == "__main__":
	main()