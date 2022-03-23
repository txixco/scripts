#!/usr/bin/env python3

"""
Script to access the FreshBooks API
"""

import json
import sys
from configparser import ConfigParser
from distutils.command.config import config

from requests import request

# Classes


class FreshBooks:
    """Class to manage a FreshBooks connection"""

    def __init__(self,
                 url: str,
                 config: ConfigParser) -> None:
        super().__init__()

        self.url = url
        self.config = config

        self.client_id = config.get('Token', 'client_id'),
        self.client_secret = config.get('Token', 'client_secret'),
        self.redirect_uri = config.get('Token', 'redirect_uri'),

    def refresh_bearer_token(self) -> str:
        """Refresh the Bearer Token"""

        params = {
            "grant_type": "refresh_token",
            "client_id": self.client_id,
            "refresh_token": self.config.get('Token', 'refresh_token'),
            "client_secret": self.client_secret,
            "redirect_uri": self.redirect_uri
        }

        url = f"{self.url}/auth/oauth/token"
        response = request(method='POST', url=url, params=params)
        json_response = response.json()

        if response.status_code != 200:
            error = json_response['error']
            description = json_response['error_description']
            print(
                f"Failed refreshing the Bearer Token, with error {error}: {description}")
            sys.exit(1)

        refresh_token = json_response['refresh_token']

        print(f"New refresh token: {refresh_token}")

        self.config.set('Token', 'refresh_token', refresh_token)
        with open("freshbooks.ini", "w") as conf_file:
            self.config.write(conf_file)

        return json_response['access_token']

    def _get_stuff(self, url: str) -> json:
        url = url[:-1] if url[-1] == "/" else url
        token = self.refresh_bearer_token()

        headers = {'Authorization': f'Bearer {token}'}
        response = request(method='GET', url=url, headers=headers)

        return response.json()

    def get_clients(self, account_id: str, client_id: str = "") -> None:
        """Returns the specified client in FreshBooks, or all if no client is specified"""

        print(self._get_stuff(
            f"{self.url}/accounting/account/{account_id}/users/clients/{client_id}"))

    def get_items(self, account_id: str, item_id: str = "") -> None:
        """Returns the specified client in FreshBooks, or all if no item is specified"""

        print(self._get_stuff(
            f"{self.url}/accounting/account/{account_id}/items/items/{item_id}"))


def main():
    """Main function"""

    # Init the config
    parser = ConfigParser()
    parser.read('freshbooks.ini')

    # Alons-y!
    freshbooks = FreshBooks(url="https://api.freshbooks.com", config=parser)

    freshbooks.get_clients(account_id=parser.get('Others', 'account_id'),
                           client_id=parser.get('Others', 'test_client'))
    freshbooks.get_items(account_id=parser.get('Others', 'account_id'))


if __name__ == "__main__":
    main()
