import json
import requests
from requests import status_codes
from typing import Tuple

def getToken(server: str, name: str, password: str, site: str='') -> Tuple[str, str]:
    endPoint = f'https://{server}/api/3.11/auth/signin'
    request = {
        'credentials': {
            'name': name,
            'password': password,
            'site': {
                'contentUrl': site
            }
        }
    }

    header = {
        'accept': 'application/json',
        'content-type': 'application/json'
    }

    res = requests.post(endPoint, json=request, headers=header, verify=False)
    res.raise_for_status()
    response = json.loads(res.content)

    return (response['credentials']['token'], response['credentials']['site']['id'])

def getExcel(token: str, server: str, siteId: str) -> str:
    endPoint = f'https://{server}/api/3.11/sites/{siteId}/views/1a84313b-7801-436a-866e-a6643df9a38e/crosstab/excel'

    header = {
        'X-Tableau-Auth': token
    }

    res = requests.get(endPoint, headers=header)
    res.raise_for_status()

    return res.content

if __name__ == "__main__":
    server = '10ax.online.tableau.com'
    userName = 'fjrueda+tableau@slmail.me'
    password = 'TBL101cm!'
    fileName = 'C:\\Code\\UIPath\\application-libraries\\Tableau\\testing.xlsx'

    (token, siteId) = getToken(server, userName, password, 'testingapidev303653')
    excel = getExcel(token, server, siteId)

    with open(fileName, 'wb') as excelFile:
        excelFile.write(excel)