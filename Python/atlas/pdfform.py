#!/usr/bin/env python3

from os import path
from datetime import datetime
from json import load
from pdfrw import PdfReader, PdfDict, PdfWriter, PdfObject, PdfName
from cliinterface import CLIInterface
from interface import Interface

class PdfForm:
    """Class for managing PDF forms"""

    def __init__(self) -> None:
        currdir = path.dirname(path.realpath(__file__))
        self.config = load(open(file=path.join(currdir, "config.json"), encoding="utf-8"))

    def fill_pdf(self, ui: Interface):
        data = self.config["data"]
        checks = self.config["checks"]
        template = PdfReader(path.join(self.config["pdf_path"], self.config["template"]))
        fields = template.Root.AcroForm.Fields

        # Prepare the checkboxes
        for check in checks:
            data[ui.check_field(checks[check])] = True

        # Fill the regular fields
        for field in fields:
            key = field["/T"][1:-1]

            if key not in data:
                continue

            if type(data[key]) == bool:
                field.AS = PdfName('Yes')
                continue

            if "@date" in data[key]:
                value = f"{datetime.now():%d/%m/%Y}"
            elif "@choose" in data[key]:
                dictionary = data[key].split(":")[1]
                value = ui.choose_value(key, self.config[dictionary])
            elif "@ask" in data[key]:
                value = ui.input_field(data[key])
            else:
                value = data[key]

            field.V = value
            field.AP = None

        # Save the new PDF file
        PdfWriter().write(path.join(self.config["pdf_path"], self.config["target"]), template)

def main():
    PdfForm().fill_pdf(CLIInterface())

if __name__ == "__main__":
    main()