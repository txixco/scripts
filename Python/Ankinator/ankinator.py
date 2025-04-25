#! /usr/bin/env python3

"""
Get questions and answers from pdf files and create a csv file for Anki
"""

from pymupdf import open as mupdf_open, Document
from re import compile, DOTALL
from csv import writer, QUOTE_MINIMAL

# Functions

def get_questions():
    """
    Get the questions from the pdf file
    
    :return: The list of questions
    """

    questions:dict = {}

    fname:str = 'preguntas.pdf'
    doc: Document = mupdf_open(fname)

    for page in doc:
        if page.number == 0:
            continue

        page_text:str = page.get_text()
        pattern = compile(r'(\d+)\.\s(.+?)(?:\n\s*a\)\s(.+?)\n\s*b\)\s(.+?)\n\s*c\)\s(.+?))(?=\n\d+\.|\Z)', DOTALL)
        matches = pattern.findall(page_text)

        for match in matches:
            question:dict = {}
            num, qstn, opt_a, opt_b, opt_c = match

            question['question'] = qstn
            question['opt_a'] = opt_a
            question['opt_b'] = opt_b
            question['opt_c'] = opt_c

            questions[int(num)] = question

    return questions

def get_answers():
    """
    Get the answers from the pdf file
    
    :return: The list of answers
    """

    answers:dict = {}

    fname:str = 'respuestas.pdf'
    doc: Document = mupdf_open(fname)

    for page in doc:
        page_text:str = page.get_text()

        for table in page.find_tables():
            for row in table.extract():
                if row[0] == table.header.names[0]:
                    continue

                num, answer = row
                answers[int(num)] = answer

    return answers

def main():
    """
    Main function
    """

    questions:dict = get_questions()   
    answers:dict = get_answers()

    with open('anki.csv', 'w', newline='', encoding='UTF-8') as file:
        card_writer = writer(file, delimiter=';', quotechar='"', quoting=QUOTE_MINIMAL)

        for num, qstn in questions.items():
            anki_question:str = f'<p>{qstn["question"]}</p><ol><li>{qstn["opt_a"]}</li><li>{qstn["opt_b"]}</li><li>{qstn["opt_c"]}</li></ol>'
            anki_answer:str = answers[num]

            card_writer.writerow([anki_question, anki_answer])

# Allons-y!

if __name__ == '__main__':
    main()