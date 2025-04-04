config.load_autoconfig(False)

c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "y": "https://www.youtube.com/results?search_query={}",
    "g": "https://github.com/search?q={}",
    "a": "https://wiki.archlinux.org/?search={}",
    "b": "https://pl.bab.la/slownik/angielski-polski/{}",
    "s": "https://sjp.pl/{}",
    "q": "https://google.com/search?q=qutebrowser%20{}",
    "sql": "https://google.com/search?q=sqlalchemy%20{}",
    "p": "https://google.com/search?q=python%20{}",
    "gm": "https://www.google.com/maps/place/{}",
    "an": "https://google.com/search?q=ansible%20{}",
    "c": "https://revolut.atlassian.net/wiki/search?text={}",
    "tpb": "http://thepiratebay.org/search/{}",
    "bgg": "https://boardgamegeek.com/geeksearch.php?action=search&objecttype=boardgame&q={}",
    "isz": "https://i-szop.pl/szukaj2/1/{}",
    "w": "https://pl.wikipedia.org/w/index.php?search={}",
    "S": "https://starfishstorage.atlassian.net/browse/STAR-{}",
}
c.zoom.default = "125%"
c.url.default_page = "https://www.google.com/"

c.hints.uppercase = True

c.content.notifications.enabled = False
c.completion.shrink = True
c.hints.auto_follow = "always"

c.completion.show = "always"

c.auto_save.session = True
c.completion.cmd_history_max_items = -1

c.content.cookies.accept = "all"
c.content.pdfjs = False
c.completion.quick = True
c.hints.next_regexes = [
    "\\bnext\\b",
    "\\bmore\\b",
    "\\bnewer\\b",
    "\\b[>→≫]\\b",
    "\\b(>>|»)\\b",
    "\\bcontinue\\b",
    "\\b>\\b",
    "Następna",
]
c.hints.next_regexes.append("Następna")

c.content.geolocation = True
# c.downloads.open_dispatcher = "evince"

c.new_instance_open_target = "tab"
c.aliases = {"w": "session-save", "q": "quit", "wq": "quit --save", "h": "help"}
c.tabs.mode_on_change = "restore"

config.unbind("<Ctrl-w>")

config.bind("<z><t>", "spawn --userscript test")
config.bind("<z><l>", "spawn --userscript qute-pass")
config.bind("<z><u><l>", "spawn --userscript qute-pass --username-only")
config.bind("<z><p><l>", "spawn --userscript qute-pass --password-only")
config.bind("<z><o><l>", "spawn --userscript qute-pass --otp-only")
config.bind("<z><c><l>", "spawn --userscript qute-pass --card")
config.bind("<z><c><n>", "spawn --userscript qute-pass --card --with_card_name")
config.bind("h", "scroll-px -30 0")
config.bind("j", "scroll-px 0 30")
config.bind("k", "scroll-px 0 -30")
config.bind("l", "scroll-px 30 0")

config.bind("K", "tab-next")
config.bind("J", "tab-prev")
config.bind("gk", "tab-next")
config.bind("gj", "tab-prev")

config.bind("<Ctrl-Shift-c>", "fake-key <Ctrl+c>")
config.bind("<Ctrl-Shift-c>", "completion-item-yank", "command")
config.bind("<Ctrl-C>", "mode-leave", mode="insert")
config.bind("<Ctrl-C>", "mode-leave", mode="caret")
config.bind("<Ctrl-C>", "mode-leave", mode="command")
config.bind("<Ctrl-C>", "mode-leave", mode="passthrough")
config.bind("<Ctrl-C>", "mode-leave", "hint")
config.bind("<Ctrl-m>", "command-accept", mode="command")
config.bind("<Ctrl-m>", "fake-key <return>", mode="insert")
config.bind(";q", "hint inputs")

for i in range(1, 10):
    for mode in ["caret", "normal"]:
        config.bind(str(i), f"tab-focus {i}", mode)

config.bind(",m", "spawn mpv {url}")
config.bind(",M", "hint links spawn mpv {hint-url}")

# config.bind("<Ctrl-y>", "fake-key <Ctrl-Home> ;; fake-key <Ctrl-Shift-End>", "insert")
config.bind("<Ctrl-y>", "fake-key <Meta-up> ;; fake-key <Shift-Meta-down>", "insert")
config.bind("<Ctrl-a>", "fake-key <Home>", "insert")
config.bind("<Ctrl-Shift-a>", "fake-key <Ctrl+a>", "insert")
config.bind("<Ctrl-e>", "fake-key <End>", "insert")
config.bind("<Ctrl-n>", "fake-key <Down>", "insert")
config.bind("<Ctrl-p>", "fake-key <Up>", "insert")
config.bind("<Ctrl-h>", "fake-key <Backspace>", "insert")
#  config.bind('<Backspace>', 'message-info "Use Ctrl-H!"', 'insert')
# config.bind("<Ctrl-k>", "fake-key <Shift-End> ;; fake-key <Delete>", "insert")
# MACOS
# config.bind('<Ctrl-w>', 'fake-key <alt-backspace>', 'insert')
# LINUX
config.bind("<Ctrl-w>", "fake-key <Ctrl-backspace>", "insert")
config.bind("<Ctrl-u>", "fake-key <Shift-Home> ;; fake-key <Delete>", "insert")
config.bind("<Alt-b>", "fake-key <alt-left>", "insert")
config.bind("<Alt-f>", "fake-key <alt-right>", "insert")

config.bind("ss", "cmd-set-text -s :session-save -o", "normal")
config.bind("sl", "cmd-set-text -s :session-load", "normal")

config.bind(";;", "fake-key <esc>", "normal")
c.downloads.location.directory = "~/Downloads"

# config.bind("<Ctrl-c>", "completion-item-yank")
# config.bind("<Ctrl-Shift-c>", "completion-item-yank")
config.bind("<Ctrl-v>", "insert-text -- {clipboard}", mode="insert")
config.bind("<Ctrl-v>", "cmd-set-text -a {clipboard}", mode="command")

config.bind("es", "config-source")

config.bind(";f", "hint links tab-bg")
config.bind(",b", "cmd-set-text -s :tab-select")
config.bind(",d", "download-open")

c.editor.command = ["vim", "-f", "{file}"]

c.qt.workarounds.remove_service_workers = True


zmienna = """Hi, This is a copy-pasted message what I apologize for. I tried to treat everyoe personally but with """
config.bind("<Ctrl-q>", "insert-text -- " + zmienna, mode="insert")

c.input.insert_mode.leave_on_load = False

# config.bind(';ww', 'set downloads.location.directory ~/pictures/wallpapers/general ;; hint images download ;; set downloads.location.prompt false ;; bind e hint images download')

config.unbind("l")
config.unbind("h")
config.bind("l", "forward")
config.bind("h", "back")

c.content.javascript.clipboard = "access-paste"

c.qt.args = ["proxy-pac-url=file://" + str(config.configdir / "proxy.pac")]
