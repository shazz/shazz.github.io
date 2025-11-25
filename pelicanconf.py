AUTHOR = "shazz"
SITENAME = "Retrovirology"
# SITEURL = "https://www.retrovirology.ca"
THEME = "themes/pelican-chunk"

PLUGIN_PATHS = ["pelican-plugins"]
PLUGINS = ["readtime", "jinja2content", "photos", "sitemap", "article_of_the_day", "minify"]
# PLUGINS = ["readtime", "jinja2content", "read_more_link", "summary"]

INDEX_SAVE_AS = "posts.html"

READERS = {"py": None, "png": None}
IGNORE_FILES = ["**/*.py", "**/*.png", "**/.*", "**/*.txt"]

PATH = "content"
ARTICLE_PATHS = ["blog"]
ARTICLE_SAVE_AS = "posts/{date:%Y}/{slug}.html"
ARTICLE_URL = "posts/{date:%Y}/{slug}.html"
STATIC_PATHS = ["pages", "images", "html", "extra/robots.txt", "extra/google875fd96c00484b92.html", "extra/llms.txt"]
TIMEZONE = "America/New_York"
DEFAULT_LANG = "en-us"

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
MY_LINKS = (
    ("1. Viruses", "/viruses_gallery.html"),
    ("2. Antiviruses", "/antiviruses_gallery.html"),
    ("3. Vaccines", "/vaccines_gallery.html"),
    ("4. Articles", "/posts.html"),
    ("5. Status", "/pages/Status-en.html"),
    ("6. Resources", "/pages/resources-en.html"),
    ("7. Memory map", "/pages/AtariMemoryMap-en.html"),
    ("8. Vectors", "/pages/AtariVectors-en.html"),
    ("9. TOS", "/pages/HowAtariBoots-en.html"),
    ("10. Bootsectors?", "/pages/HowBootsectorsWork-en.html"),
)
links_list = list(MY_LINKS)
sorted_links = sorted(links_list, key=lambda x: int(x[0].split(".")[0]), reverse=True)
sorted_links = [(title.split(". ", 1)[1], url) for title, url in sorted_links]
LINKS = tuple(sorted_links)

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
    "html/hatari/hatari.html": {"path": "museum/hatari.html"},
    "html/hatari/hatari.wasm": {"path": "museum/hatari.wasm"},
    "html/hatari/hatari.js": {"path": "museum/hatari.js"},
    "html/hatari/hatari.data": {"path": "museum/hatari.data"},
    "extra/robots.txt": {"path": "robots.txt"},
}

# PHOTOS plugin
PHOTO_LIBRARY = "gallery"
PHOTO_GALLERY = (1024, 768, 90, "png")
PHOTO_ARTICLE = (760, 506, 90, "png")
# PHOTO_THUMB = (250, 210, 92, "png")
PHOTO_THUMB = (400, 250, 92, "png")
PHOTO_SQUARE_THUMB = False
PHOTO_RESIZE_JOBS = 5
PHOTO_WATERMARK = False
PHOTO_WATERMARK_TEXT = "www.retrovirology.ca"
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

# minifiy
CSS_MIN = True
JS_MIN = True
HTML_MIN = True
INLINE_CSS_MIN = True
INLINE_JS_MIN = True
