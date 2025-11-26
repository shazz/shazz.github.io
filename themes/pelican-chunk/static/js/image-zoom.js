// Mobile-only simple image zoom/lightbox for article images.
// Minimal, dependency-free, supports tap to open/close and ESC to close.
(function () {
    if (typeof window === 'undefined') return;
    if (window.matchMedia && !window.matchMedia('(max-width: 767px)').matches) return;

    // Create overlay
    var overlay = document.createElement('div');
    overlay.className = 'img-zoom-overlay';
    overlay.setAttribute('aria-hidden', 'true');

    // Container for image + optional caption
    var imgEl = document.createElement('img');
    imgEl.alt = '';
    overlay.appendChild(imgEl);

    var caption = document.createElement('div');
    caption.className = 'img-zoom-caption';
    overlay.appendChild(caption);

    document.body.appendChild(overlay);

    // Helper: open overlay with src and optional alt/text
    function open(src, altText) {
        imgEl.src = src;
        imgEl.alt = altText || '';
        caption.textContent = altText || '';
        overlay.classList.add('active');
        overlay.setAttribute('aria-hidden', 'false');
        // prevent body scroll when open
        document.documentElement.style.overflow = 'hidden';
        document.body.style.overflow = 'hidden';
    }

    function close() {
        overlay.classList.remove('active');
        overlay.setAttribute('aria-hidden', 'true');
        imgEl.src = '';
        document.documentElement.style.overflow = '';
        document.body.style.overflow = '';
    }

    // Click handlers: close if click outside or on image
    overlay.addEventListener('click', function (e) {
        // if click on overlay or image: close
        close();
    });

    // Prevent clicks inside image from propagating? we want tap to close so no stopPropagation.

    // ESC to close
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') close();
    });

    // Attach to all images inside article content
    // Adjust selector to match your theme container (.article-content, .post-content, etc.)
    var selector = '.article-content img, .post-content img';
    var imgs = document.querySelectorAll(selector);
    imgs.forEach(function (i) {
        // Only attach to images with a source (skip icons, sprites)
        if (!i.src) return;
        // Optional: skip very small images (thumbnails)
        var rect = i.getBoundingClientRect();
        if (rect.width < 40 || rect.height < 40) return;

        i.style.touchAction = 'manipulation';
        i.addEventListener('click', function (ev) {
            ev.preventDefault();
            open(i.src, i.alt || '');
        });
    });

})();