#!/usr/bin/env python3

import requests, json

class Trello:
    # Constructor
    def __init__(self, key, token):
        self.key = key
        self.token = token

    ## Private methods

    # Get the lists
    def _getLists(self, idBoard):
        url = 'https://api.trello.com/1/boards/{}/lists'.format(idBoard)

        params = {
           'key': self.key,
           'token': self.token
        }

        return requests.request(method='GET', url=url, params=params)

    # Get the id for a list, given the name and the board
    def _getListId(self, idBoard, list):
        for list in self._getLists(idBoard):
            if (list['name'] == list):
                return list['id']

        return ''

    ## Public methods

    # Create a card
    def addCard(self, list, name, description):

        url = 'https://api.trello.com/1/cards'

        params = {
           'key': self.key,
           'token': self.token,
           'idList': list,
           'name': name,
           'desc': description
        }

        return requests.request(
           'POST',
           url,
           params=params
        )

    # Get the cards in a list
    def getCards(self, idList):
        url = 'https://api.trello.com/1/lists/{}/cards'.format(idList)

        params = {
           'key': self.key,
           'token': self.token
        }

        return requests.request(
           method='GET',
           url=url,
           params=params
        )

    # Get a card
    def getCard(self, idCard):
        url = 'https://api.trello.com/1/cards/{}'.format(idCard)

        params = {
           'key': self.key,
           'token': self.token
        }

        headers = {
           'Accept': 'application/json'
        }

        return requests.request(
            'GET',
            url,
            params=params,
            headers=headers
        )

    # Delete a card
    def deleteCard(self, idList, cardName):
        for card in self.getCards(idList).json():
            if (card['name'] == cardName):
                print('Deleting the card {} ({})'.format(cardName, card['id']))
                url = 'https://api.trello.com/1/cards/{}'.format(card['id'])
                params = {
                   'key': self.key,
                   'token': self.token
                }

                response = requests.request(
                   method="DELETE",
                   url=url,
                   params=params
                )

                return

        print('Not found the card {} in the list {}'.format(cardName, idList))
