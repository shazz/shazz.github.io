AUTHOR = "shazz"
SITENAME = "Retrovirology"
# SITEURL = "https://retrovirology.metaverse.fr"
THEME = "themes/pelican-chunk"

PLUGIN_PATHS = ["pelican-plugins"]
PLUGINS = ["readtime", "jinja2content", "photos"]
# PLUGINS = ["readtime", "jinja2content", "read_more_link", "summary"]

INDEX_SAVE_AS = "posts.html"

READERS = {"py": None, "png": None}
IGNORE_FILES = ["**/*.py", "**/*.png", "**/.*", "**/*.txt"]

PATH = "content"
ARTICLE_PATHS = ["blog"]
ARTICLE_SAVE_AS = "posts/{date:%Y}/{slug}.html"
ARTICLE_URL = "posts/{date:%Y}/{slug}.html"
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
    ("1. Gallery", "/"),
    ("2. Articles", "/posts.html"),
    ("3. Memory map", "/pages/AtariMemoryMap-en.html"),
    ("4. Vectors", "/pages/AtariVectors-en.html"),
    ("5. Boot", "/pages/HowAtariBoots-en.html"),
    ("6. Bootsectors?", "/pages/HowBootsectorsWork-en.html"),
    ("7. Resources", "/pages/resources-en.html"),
    ("8. Status", "/pages/Status-en.html"),
)
SORTED_LINKS = sorted(LINKS, key=lambda x: x[0], reverse=True)

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
EXTRA_PATH_METADATA = {
    "theme/favicon.ico": {"path": "favicon.ico"},
    "html/museum.html": {"path": "museum.html"},
    "html/museum_hall.html": {"path": "museum_hall.html"},
}

# PHOTOS plugin
PHOTO_LIBRARY = "gallery"
PHOTO_GALLERY = (1024, 768, 90, "png")
PHOTO_ARTICLE = (760, 506, 90, "png")
PHOTO_THUMB = (250, 210, 92, "png")
PHOTO_SQUARE_THUMB = False
PHOTO_RESIZE_JOBS = 5
PHOTO_WATERMARK = False
PHOTO_WATERMARK_TEXT = "retrovirology.metaverse.fr"
PHOTO_WATERMARK_IMG = ""
PHOTO_EXIF_KEEP = False
PHOTO_EXIF_REMOVE_GPS = True
PHOTO_EXIF_COPYRIGHT = "CC-BY-NC"
PHOTO_EXIF_COPYRIGHT_AUTHOR = "Shazz"
PHOTO_INLINE_GALLERY_ENABLED = False
PHOTO_INLINE_GALLERY_PATTERN = r"gallery::(?P[/{}\w_-]+)"
PHOTO_INLINE_GALLERY_TEMPLATE = "inline_gallery"
PHOTO_RESULT_IMAGE_AVERAGE_COLOR = False
PHOTO_PROFILING_ENABLED = False
PHOTO_FILE_EXTENSIONS = {"jpeg": "jpg", "webp": "webp", "png": "png"}

# custom variables
SHOW_EMULATOR = True
FOOTER_TEXT = "The Atari ST Malware Museum is powered by "
