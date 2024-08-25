AUTHOR = "shazz"
SITENAME = "Retrovirology"
SITEURL = ""
THEME = "themes/pelican-chunk"

PLUGIN_PATHS = ["pelican-plugins"]
PLUGINS = ["readtime"]

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
    ("Resources", "/pages/resources-en.html"),
    ("Virus Museum", "/museum.html"),
    ("UVK Book", "https://st-news.com/uvk-book"),
    ("ST/TT/Falcon Memory map", "/the-atari-stttfalcon-memory-map-en.html"),
)

# Social widget
SOCIAL = (
    ("You can add links in your config file", "#"),
    ("Another social link", "#"),
)

DEFAULT_PAGINATION = 10
SUMMARY_MAX_LENGTH = 50
SUMMARY_END_SUFFIX = "…"
SUMMARY_MAX_PARAGRAPHS = None

# Uncomment following line if you want document-relative URLs when developing
# RELATIVE_URLS = True

DISPLAY_PAGES_ON_MENU = True
PAGE_PATHS = ["pages"]

EXTRA_PATH_METADATA = {"html/museum.html": {"path": "museum.html"}}
