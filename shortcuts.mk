.DEFAULT:
	zenity --info --title='Shortcuts help' --text="Window '$@' not in list"

spotify:
	uzbl -u https://support.spotify.com/mx/learn-more/faq/#!/article/Keyboard-shortcuts

skype:
	uzbl -u https://support.skype.com/en/faq/FA12330/what-is-the-full-list-of-emoticons

vlc:
	uzbl -u https://wiki.videolan.org/Hotkeys_table/

uzbl-core:
	uzbl -u http://uzbl.org/keybindings.php
