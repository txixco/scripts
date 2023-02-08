#! /usr/bin/env python3

from operator import mod
from urllib import response
from flask import Flask, render_template
from datetime import time
import requests
import json

def get_meme() -> None:
    url = "https://meme-api.herokuapp.com/gimme"
    response = json.loads(requests.request("GET", url).text)
    meme_large = response["preview"][-2]
    subreddit = response["subreddit"]

    return meme_large, subreddit

app = Flask(__name__)
app.config['COUNT'] = 0

@app.route("/")
def index() -> None:
    app.config['COUNT'] += 1

    if app.config['COUNT'] % 3 == 0:
        return render_template("rickroll_index.html", subreddit="¡¡Rickroleado!!")

    meme_pic, subreddit = get_meme()

    return render_template("meme_index.html", meme_pic=meme_pic, subreddit=subreddit)

app.run(host="0.0.0.0", port="8080")