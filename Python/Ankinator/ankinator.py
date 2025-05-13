#! /usr/bin/env python3

"""
Get questions and answers from pdf files and create a csv file for Anki
"""

from pymupdf import open as mupdf_open, Document
from re import compile, findall, DOTALL
from csv import writer, QUOTE_MINIMAL

# Functions

def get_questions() -> dict:
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

def get_answers() -> dict:
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
            process_page(answers, table)

    return answers

def get_pairs(table) -> list[tuple[int]]:
    """
    Get the pairs of question and answer columns from the table

    :param table: The table to get the pairs from
    :return: The list of pairs of question and answer columns
    """

    question_cols: list[int] = []
    answer_cols: list[int] = []

    headers = table.header.names
    for i in range(len(headers)):
        match headers[i]:
            case 'PREGUNTA':
                question_cols.append(i)
                continue
            case 'RESPUESTA':
                answer_cols.append(i)
                continue

    return [(question_cols[i], answer_cols[i]) for i in range(len(question_cols))]

def process_page(answers, table) -> None:
    """
    Process the page and get the answers from the table

    :param answers: The dictionary to store the answers
    :param table: The table to process
    """

    pairs = get_pairs(table)

    for row in table.extract():
        if row[pairs[0][0]] == table.header.names[pairs[0][0]]:
            continue

        for (question_col, answer_col) in pairs:
            num_str, answer = row[question_col], row[answer_col]
            if num_str:
                num = findall(r'\d+', num_str)[0]
                answers[int(num)] = answer

def main():
    """
    Main function
    """

    questions:dict = get_questions()   
    answers:dict = get_answers()

    with open('anki.csv', 'w', newline='', encoding='UTF-8') as file:
        card_writer = writer(file, delimiter=';', quotechar='"', quoting=QUOTE_MINIMAL)

        for num, qstn in questions.items():
            anki_answer:str = answers[num]
            if anki_answer != 'ANULADA':
                anki_question:str = f'<p>{qstn["question"]}</p><ol><li>{qstn["opt_a"]}</li><li>{qstn["opt_b"]}</li><li>{qstn["opt_c"]}</li></ol>'
                card_writer.writerow([anki_question, anki_answer])

# Allons-y!

if __name__ == '__main__':
    main()