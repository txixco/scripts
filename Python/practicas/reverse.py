#! /usr/bin/env python

def revSentence(sentence):
	words = sentence.split(" ")

	return " ".join(words[::-1])

sentence = input("Dime una oración: ")
print(revSentence(sentence))
