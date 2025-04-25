#!/usr/bin/env python3

from telepot import Bot, glance
from telepot.loop import MessageLoop
from requests import get
from threading import Thread, Event
from time import sleep

TELEGRAM_TOKEN = "7682218401:AAFqO8fT8H75B5i6FFEmguDbUkX1mHU290U"

bot: Bot = None

def keep_typing(chat_id, stop_event):
    while not stop_event.is_set():
        bot.sendChatAction(chat_id, 'typing')
        sleep(4)

def msg_loop(msg: str) -> None:
	global bot

	content_type, chat_type, chat_id = glance(msg)
	text = msg["text"]
	who = msg["from"]
	
	if content_type == "text" and text.startswith("/"):
		process_command(chat_id, text, who)
	else:
		bot.sendMessage(chat_id, text)

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
			stop_event = Event()
			typing_thread = Thread(target=keep_typing, args=(chat_id, stop_event))
			typing_thread.start()

			try:
				req = get("https://randomuser.me/api/")
				if req.status_code == 200:
					data = req.json()
					name = data["results"][0]["name"]
					email = data["results"][0]["email"]

					bot.sendMessage(chat_id, f"{name['first']} {name['last']}\n{email}")
				else:
					bot.sendMessage(chat_id, "Error al obtener datos.")
			finally:
				stop_event.set()
				typing_thread.join()
		case "/stop":
			bot.sendMessage(chat_id, "¡Hasta luego!")
		case _:
			bot.sendMessage(chat_id, "Comando no reconocido.")
			show_help(chat_id)
				
def main() -> None:
	global bot

	bot = Bot(TELEGRAM_TOKEN)
	MessageLoop(bot, msg_loop).run_as_thread()

	while True:
		sleep(5)

if __name__ == "__main__":
	main()