AUTHOR = "shazz"
SITENAME = "Retrovirology"
SITEURL = ""
THEME = "themes/pelican-chunk"

PLUGIN_PATHS = ["pelican-plugins"]
PLUGINS = ["readtime"]

PATH = "content"

TIMEZONE = "America/New_York"

DEFAULT_LANG = "English"

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
LINKS = (
    ("UVK Book", "https://st-news.com/uvk-book"),
    ("Metacodes", "https://www.metacodes.pro/blog/computer_archeology_exploring_the_anatomy_of_an_ms_dos_virus/"),
    ("Memory map", "the-atari-stttfalcon-memory-map-en.html"),    
)

# Social widget
SOCIAL = (
    ("You can add links in your config file", "#"),
    ("Another social link", "#"),
)

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
# RELATIVE_URLS = True
