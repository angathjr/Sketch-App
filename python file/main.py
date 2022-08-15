import cv2
import pyautogui as pg
import time
import random
import os
import subprocess
import threading

from firebase import Firebase
config = {
    "apiKey": "AIzaSyCOeZpQzMwNyc-NS55MDMoHpgirxLOA1Nc",
    "authDomain": "draw-49df3.firebaseapp.com",
    "projectId": "draw-49df3",
    "storageBucket": "draw-49df3.appspot.com",
    "messagingSenderId": "1070391728243",
    "appId": "1:1070391728243:web:246d90fbf9920885057206",
    "databaseURL": ""
}
firebase = Firebase(config)
storage = firebase.storage()
storage.child("images/new.jpg").download("new.jpg")

def open_paint():
    os.system("mspaint")

originalImage = cv2.imread('new.jpg')
resizeimage = cv2.resize(originalImage, (140, 170))
grayImage = cv2.cvtColor(resizeimage, cv2.COLOR_BGR2GRAY)

(thresh, blackAndWhiteImage) = cv2.threshold(
    grayImage, 127, 255, cv2.THRESH_BINARY)
x_start = 500
y_start = 300
x = threading.Thread(target=open_paint)
x.start()
time.sleep(5)
pg.moveTo(x_start, y_start)
random_rows = list(range(len(blackAndWhiteImage)))
random_rows = random.sample(
    range(len(blackAndWhiteImage)), len(blackAndWhiteImage))
random.shuffle(random_rows)
for y in random_rows:
    row = blackAndWhiteImage[y]
    random_cols = list(range(len(row)))

    for x in random_cols:
        if row[x] == 0:
            pg.click(x_start + x, y_start + y, _pause=False)
           # print('Drawing at:', x_start + x, y_start + y)
            time.sleep(0.00000000000001)
            # animation speed
