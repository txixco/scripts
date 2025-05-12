#! /usr/bin/env python3

"""
Given a pdf file, the pages and the rotation, rotate the pages
"""

from pypdf import PdfReader, PdfWriter
from argparse import ArgumentParser

def get_arguments():
    """
    Get the arguments from the command line
    """

    parser = ArgumentParser(description='Rotate the pages of a PDF file')

    parser.add_argument('input', help='The path to the PDF file to be rotated')
    parser.add_argument('range_type', choices=['odd', 'even', 'all', 'range', 'list'], help='The type of pages to be rotated')
    parser.add_argument('rotation', type=int, help='The number of degrees to rotate the pages')
    parser.add_argument('pages', nargs='*', type=str, help='The pages to be rotated (if applicable)')

    args = parser.parse_args()

    # Validaciones
    if args.range_type in ['odd', 'even', 'all'] and args.pages:
        parser.error(f"El argumento 'pages' no debe proporcionarse con 'range_type={args.range_type}'.")

    if args.range_type in ['range', 'list'] and not args.pages:
        parser.error(f"El argumento 'pages' es obligatorio cuando 'range_type' es 'range' o 'list'.")

    return args

def rotate_pages(input_pdf:str, range_type:str, pages:list, rotation:int)->str:
    """
    Rotate the pages of the pdf file, and saves it in a new file named like the original 
    file with the suffix '_rotated'

    :param pdf_path: The path to the PDF file to be rotated
    :param range_type: The type of pages to be rotated
    :param pages: The pages to be rotated
    :param rotation: The number of degrees to rotate the pages
    """

    reader:PdfReader = PdfReader(input_pdf)
    writer:PdfWriter = PdfWriter()
    output_pdf:str = input_pdf.replace('.pdf', '_rotated.pdf')
    pages_range:range = range(len(reader.pages))


    match range_type:
        case 'odd':
            pages = [i for i in pages_range if i % 2 == 0]
        case 'even':
            pages = [i for i in pages_range if i % 2 != 0]
        case 'all':
            pages = [i for i in pages_range]
        case 'range':
            pages = [int(i) for i in pages[0].split('-')]
        case 'list':
            pages = [int(i) for i in pages]
        case _:
            pages = []

    for i, page in enumerate(reader.pages):
        if i in pages:
            writer.add_page(page.rotate(rotation))

    with open(output_pdf, 'wb') as out:
        writer.write(out)

    return output_pdf


def main():
    """
    Main function
    """

    args = get_arguments()
    out_pdf_path:str = rotate_pages(args.input, args.range_type, args.pages, args.rotation)

if __name__ == '__main__':
    main()