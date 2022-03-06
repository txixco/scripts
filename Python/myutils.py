from os import name, path, system
from shutil import copyfile

def set_wallpaper(img_file: str) -> None:
    """Sets the wallpaper"""

    if name == "nt":
        dest_file = path.join(path.dirname(img_file), "ng-potd.jpg")
        copyfile(img_file, dest_file)

        return

#    gconftool-2 -t string -s /desktop/gnome/background/picture_filename $IMAGE_FILE

    commands = [
        "export DISPLAY=:0.0",
        # Gnome
        f"gsettings set org.gnome.desktop.background picture-uri file:///{img_file}",
        # i3
        f"nitrogen --set-zoom-fill {img_file}",
    ]

    system("; ".join(commands))
