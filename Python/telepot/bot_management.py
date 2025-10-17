from telepot import Bot
from requests import get
from time import sleep


def _get_commands(token: str) -> list:
	""" Get the list of commands from the Telegram Bot API """
	""" Returns a list of dictionaries with command details """

	req = get('https://api.telegram.org/bot{}/getMyCommands'.format(token))

	data = req.json()
	if data['ok']:
		return data['result']
	else:
		print('Error en la respuesta de la API')
		return []

def show_help(token: str, chat_id: int) -> None:
	""" Sends a message with the list of available commands """

	bot = Bot(token)
	commands = _get_commands(token)
	if not commands:
		bot.sendMessage(chat_id, 'No hay comandos disponibles.')
		return

	text = '🤖 Comandos disponibles:\n\n'
	for command in commands:
		text += f'    /{command["command"]} - {command["description"]}\n'

	bot.sendMessage(chat_id, text)

def keep_typing(token: str, chat_id: int, stop_event):
	""" Keeps sending 'typing' action to the chat until stop_event is set """

	bot = Bot(token)
	while not stop_event.is_set():
		bot.sendChatAction(chat_id, 'typing')
		sleep(1)

def parse_command(text: str) -> tuple[str, str]:
	""" Splits the command text into command and arguments """
	""" If the command is not recognized, it returns an empty string for args """

	parts = text.strip().split(maxsplit=1)
	command = parts[0]
	args = parts[1] if len(parts) > 1 else ''

	return command, args
