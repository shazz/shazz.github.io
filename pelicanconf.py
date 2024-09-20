AUTHOR = "shazz"
SITENAME = "Retrovirology"
SITEURL = "https://retrovirology.metaverse.fr"
THEME = "themes/pelican-chunk"

PLUGIN_PATHS = ["pelican-plugins"]
PLUGINS = ["readtime", "jinja2content", "read_more_link"]

PATH = "content"
ARTICLE_PATHS = ["blog"]
ARTICLE_SAVE_AS = "{date:%Y}/{slug}.html"
ARTICLE_URL = "{date:%Y}/{slug}.html"
STATIC_PATHS = ["pages", "images", "html"]
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
    ("ST/TT/Falcon Memory map", "/pages/AtariMemoryMap-en.html"),
    ("Important vectors", "/pages/AtariVectors-en.html"),
    ("ATARI Boot process", "/pages/HowAtariBoots-en.html"),
    ("Bootsectors?", "/pages/HowBootsectorsWork-en.html"),
    ("Resources", "/pages/resources-en.html"),
    ("Status", "/pages/MuseumStatus-en.html"),
    # ("Virus Museum", "/museum.html"),
)

# Social widget
SOCIAL = (
    ("You can add links in your config file", "#"),
    ("Another social link", "#"),
)

DEFAULT_PAGINATION = 5
SUMMARY_MAX_PARAGRAPHS = 2
SUMMARY_MAX_LENGTH = 100
SUMMARY_END_SUFFIX = "..."
DISPLAY_PAGES_ON_MENU = False
DISPLAY_CATEGORIES_ON_MENU = False

# Uncomment following line if you want document-relative URLs when developing
# RELATIVE_URLS = True
PAGE_PATHS = ["pages"]
EXTRA_PATH_METADATA = {"html/museum.html": {"path": "museum.html"}, "html/museum_hall.html": {"path": "museum_hall.html"}}
