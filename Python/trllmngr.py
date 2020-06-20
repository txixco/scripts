#!/usr/bin/env python3

from pathlib import Path
import trello, yaml, argparse

# Get the options
parser=argparse.ArgumentParser(description='Manage Trello cards')

parser.add_argument('-d', '--delete', help='Delete the specified cards')
parser.add_argument('-c', '--create', help='Create a new card')
parser.add_argument('config', default='~/.config/trllmngr.yml', help='Config file to be used (default: ~/.config/trllmngr.yml)')

args=parser.parse_args()

configFile = '{}/.config/trllmgr/josue.yml'.format(str(Path.home()))
config = yaml.safe_load(open(configFile))

listIds = config['board']['lists']
trll = trello.Trello(config['security']['key'], config['security']['token'])

#print(trll.addCard(LIST_ES, 'test', 'Testing card\n\nArchives:\n  - Test archive').json())

#for card in trll.getCards(listIds['ES']).json():
#    print(card['name'])

#print(trll.getCard('NgWf3taI').json()['name'])

# for i in range(10, 16):
#     trll.deleteCard(listIds['FR'], '{}-Mai-2020'.format(i))
trll.deleteCard(listIds['ES'],'10-mayo-2020')
