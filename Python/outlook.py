import argparse

from win32com.client import Dispatch
from win32com.client import constants as cnst


def get_subfolder(parent: object, path: str) -> object:
    """Get the Folder object corresponding to the path"""

    splitted = path.split("\\")
    dest = parent
    for current in splitted:
        dest = dest.Folders(current)

    return dest


def remove_attachments(subject: str, folder_path: str, move: bool = False) -> None:
    """Remove the attachments in the emails with the given subject and move the emails to the folder"""

    outlook = Dispatch("Outlook.Application")
    inbox = outlook.Session.GetDefaultFolder(6)

    to_be_moved = []
    for item in inbox.Items:
        if item.Subject == subject:
            for attch in item.Attachments:
                item.Attachments.Remove(1)

            to_be_moved.append(item)

    if move:
        dest = get_subfolder(parent=inbox.parent, path=folder_path)
        for item in to_be_moved:
            item.Move(dest)


def main() -> None:
    """Main function"""

    parser = argparse.ArgumentParser()
    parser.add_argument("-r", "--remove_attachment")
    remove_attachments(subject="Summary of OnSIP Billing Process",
                       folder_path="RPA\OnSIP Billing",
                       move=True)


if __name__ == "__main__":
    main()
