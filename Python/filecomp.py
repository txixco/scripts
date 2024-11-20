#! /usr/bin/env python3

from os import path
from dataclasses import dataclass

import pandas as pd
import sys

@dataclass
class InputFiles:
    path: str
    file1: str
    file2: str

    def __init__(self) -> None:
        self.take_arguments()

    def take_arguments(self) -> dict:
        if len(sys.argv) != 4:
            print('Use: python script.py path file1 file2')
            sys.exit(1)

        self.path = sys.argv[1]
        self.file1 = sys.argv[2]
        self.file2 = sys.argv[3]

def read_csv(filename: str) -> pd.DataFrame:
    return pd.read_csv(filename, sep=';') 

def write_csv(data: pd.DataFrame, filename: str) -> None:
    data.to_csv(filename, sep=';', index=False)

def main():
    files = InputFiles()

    sheet1 = read_csv(path.join(files.path, files.file1))
    sheet2 = read_csv(path.join(files.path, files.file2))

    # Realizar la combinación usando las columnas clave
    combined_sheet = sheet2.merge(sheet1[['nomB1', 'nomB2', 'nomB3', 'nomELEM', 'zona_grafica']], 
                                on=['nomB1', 'nomB2', 'nomB3', 'nomELEM'], 
                                how='left')

    result_file = f'new_{files.file2}'
    write_csv(data=combined_sheet, filename=path.join(files.path, result_file))

    print(f'Archivo guardado como: {result_file}')

if __name__ == '__main__':
    main()