#!/usr/bin/env python3

import requests, json

class Spotify:
    # Constructor
    def __init__(self, key, token):
        self.key = key
        self.token = token

    ## Private methods

    # Get the playlists
    def _getPlaylists(self, idPlaylist):
        url = 'https://api.spotify.com/1/playlists'.format(idPlaylist)

        params = {
           'key': self.key,
           'token': self.token
        }

        return requests.request(method='GET', url=url, params=params)

    # Get the id for a Playlist
    def _getPlaylistId(self, playlist):
        for playlist in self._getPlaylists():
            if (playlist['name'] == playlist):
                return playlist['id']

        return ''

    ## Public methods

    # Create a card
    def addCard(self, playlist, name, description):

        url = 'https://api.spotify.com/1/cards'

        params = {
           'key': self.key,
           'token': self.token,
           'idPlaylist': playlist,
           'name': name,
           'desc': description
        }

        return requests.request(
           'POST',
           url,
           params=params
        )

    # Get the cards in a playlist
    def getCards(self, idPlaylist):
        url = 'https://api.spotify.com/1/playlists/{}/cards'.format(idPlaylist)

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
        url = 'https://api.spotify.com/1/cards/{}'.format(idCard)

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
    def deleteCard(self, idPlaylist, cardName):
        for card in self.getCards(idPlaylist).json():
            if (card['name'] == cardName):
                print('Deleting the card {} ({})'.format(cardName, card['id']))
                url = 'https://api.spotify.com/1/cards/{}'.format(card['id'])
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

        print('Not found the card {} in the playlist {}'.format(cardName, idPlaylist))
