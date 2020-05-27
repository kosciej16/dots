c.url.searchengines = {
    'DEFAULT': 'https://www.google.com/search?q={}',
    'y': 'https://www.youtube.com/results?search_query={}',
    'g': 'https://github.com/search?q={}',
    'a': 'https://wiki.archlinux.org/?search={}',
    'b': 'https://pl.bab.la/slownik/angielski-polski/{}',
    's': 'https://sjp.pl/{}',
    'q': 'https://google.com/search?q=qutebrowser%20{}',
    'p': 'https://google.com/search?q=python%20{}',
    'gm': 'https://www.google.com/maps/place/{}',
    'an': 'https://google.com/search?q=ansible%20{}',
    'c': 'https://royaldutchshell.atlassian.net/wiki/search?text={}',
    'tpb': 'http://thepiratebay.org/search/{}',
    'bgg': 'https://boardgamegeek.com/geeksearch.php?action=search&objecttype=boardgame&q={}',
    'isz': 'https://i-szop.pl/szukaj2/1/{}',
    'w': 'https://pl.wikipedia.org/w/index.php?search={}',
}
c.zoom.default = '125%'
c.url.default_page = 'https://www.google.com/'

c.hints.uppercase = True

c.content.notifications = False
c.completion.shrink = True
c.hints.auto_follow = 'always'

c.completion.show = 'always'

c.auto_save.session = True
c.completion.cmd_history_max_items = -1

c.content.cookies.accept = 'all'
c.content.pdfjs = True
c.completion.quick = True
c.hints.next_regexes = ['\\bnext\\b', '\\bmore\\b', '\\bnewer\\b', '\\b[>→≫]\\b', '\\b(>>|»)\\b', '\\bcontinue\\b', '\\b>\\b', 'Następna']
c.hints.next_regexes.append('Następna')

c.content.geolocation = True
c.content.media_capture = True
c.downloads.open_dispatcher = 'evince'

c.new_instance_open_target = 'tab'
c.aliases = {'w': 'session-save', 'q': 'quit', 'wq': 'quit --save', 'h': 'help'}
c.tabs.mode_on_change = 'restore'


config.unbind('<Ctrl-w>')
config.bind('<Ctrl-C>', 'leave-mode', mode='insert')

config.bind('<z><l>', 'spawn --userscript qute-pass')
config.bind('<z><u><l>', 'spawn --userscript qute-pass --username-only')
config.bind('<z><p><l>', 'spawn --userscript qute-pass --password-only')
config.bind('<z><o><l>', 'spawn --userscript qute-pass --otp-only')
config.bind('h', 'scroll-px -30 0')
config.bind('j', 'scroll-px 0 30')
config.bind('k', 'scroll-px 0 -30')
config.bind('l', 'scroll-px 30 0')

config.bind('K', 'tab-next')
config.bind('J', 'tab-prev')
config.bind('<Ctrl-W>', 'spawn Backspace', mode='insert')
config.bind('<Ctrl-C>', 'leave-mode', mode='command')
config.bind('<Ctrl-M>', 'Return', mode='command')
config.bind(';q', 'hint inputs')

config.bind('<Alt-1>', 'tab-focus 1', 'insert')
config.bind('<Alt-1>', 'tab-focus 1', 'caret')
config.bind('<Alt-1>', 'tab-focus 1', 'command')
config.bind('<Alt-2>', 'tab-focus 2', 'insert')
config.bind('<Alt-2>', 'tab-focus 2', 'caret')
config.bind('<Alt-2>', 'tab-focus 2', 'command')
config.bind('<Alt-3>', 'tab-focus 3', 'insert')
config.bind('<Alt-3>', 'tab-focus 3', 'caret')
config.bind('<Alt-3>', 'tab-focus 3', 'command')
config.bind('<Alt-4>', 'tab-focus 4', 'insert')
config.bind('<Alt-4>', 'tab-focus 4', 'caret')
config.bind('<Alt-4>', 'tab-focus 4', 'command')
config.bind('<Alt-5>', 'tab-focus 5', 'insert')
config.bind('<Alt-5>', 'tab-focus 5', 'caret')
config.bind('<Alt-5>', 'tab-focus 5', 'command')
config.bind('<Alt-6>', 'tab-focus 6', 'insert')
config.bind('<Alt-6>', 'tab-focus 6', 'caret')
config.bind('<Alt-6>', 'tab-focus 6', 'command')
config.bind('<Alt-7>', 'tab-focus 7', 'insert')
config.bind('<Alt-7>', 'tab-focus 7', 'caret')
config.bind('<Alt-7>', 'tab-focus 7', 'command')
config.bind('<Alt-8>', 'tab-focus 8', 'insert')
config.bind('<Alt-8>', 'tab-focus 8', 'caret')
config.bind('<Alt-8>', 'tab-focus 8', 'command')
config.bind('<Alt-9>', 'tab-focus 9', 'insert')
config.bind('<Alt-9>', 'tab-focus 9', 'caret')
config.bind('<Alt-9>', 'tab-focus 9', 'command')

config.bind(',m', 'spawn mpv {url}')
config.bind(',M', 'hint links spawn mpv {hint-url}')

config.bind('<Ctrl-a>', 'fake-key <Home>', 'insert')
config.bind('<Ctrl-e>', 'fake-key <End>', 'insert')
config.bind('<Ctrl-n>', 'fake-key <Down>', 'insert')
config.bind('<Ctrl-p>', 'fake-key <Up>', 'insert')
config.bind('<Ctrl-h>', 'fake-key <Backspace>', 'insert')
#  config.bind('<Backspace>', 'message-info "Use Ctrl-H!"', 'insert')
config.bind('<Ctrl-k>', 'fake-key <Shift-End> ;; fake-key <Delete>', 'insert')
config.bind('<Ctrl-w>', 'fake-key <Ctrl-backspace>', 'insert')
config.bind('<Ctrl-u>', 'fake-key <Shift-Home> ;; fake-key <Delete>', 'insert')
config.bind('<Alt-b>', 'fake-key <Ctrl-left>', 'insert')
config.bind('<Alt-f>', 'fake-key <Ctrl-right>', 'insert')
