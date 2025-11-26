// Mobile-only simple image zoom/lightbox for article images.
// Minimal, dependency-free, supports tap to open/close and ESC to close.
(function () {
    if (typeof window === 'undefined') return;

    // Only run on small viewports OR on devices that support touch input.
    // Some phones may report larger screen widths in some orientations so we
    // also check for touch capability to be robust for phones.
    var isSmall = window.matchMedia ? window.matchMedia('(max-width: 767px)').matches : false;
    var hasTouch = ('ontouchstart' in window) || (navigator.maxTouchPoints && navigator.maxTouchPoints > 0) || (navigator.msMaxTouchPoints && navigator.msMaxTouchPoints > 0);
    
    console.log('image-zoom: DEBUG init - isSmall=' + isSmall + ', hasTouch=' + hasTouch + ', innerWidth=' + window.innerWidth + ', maxTouchPoints=' + navigator.maxTouchPoints);
    
    if (!isSmall && !hasTouch) {
        console.log('image-zoom: not initializing - neither small viewport nor touch device');
        return;
    }
    
    console.log('image-zoom: initializing...');

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
    // Adjust selector to match your theme container (.entry-content used by this theme)
    // Use event delegation so images are handled even if dynamically added, and
    // to avoid sizing/timing issues that can prevent handlers from attaching.
    var selector = '.entry-content img, .article-content img, .post-content img, #contents img';

    if (window && window.console && window.console.debug) {
        console.debug('image-zoom: delegation enabled for:', selector);
    }

    // minimal size to skip true tiny icons (in px)
    var MIN_DIM = 16;

    // avoid double-handling when touch events synthesize clicks
    var lastTouchOpen = 0;

    function getImageSrc(img) {
        // support lazy-loading attributes
        return img.currentSrc || img.src || img.getAttribute('data-src') || img.getAttribute('data-original') || '';
    }

    function handleOpenEvent(el, ev) {
        // find if the click/tap was on an img that matches our selector context
        if (!el || el.tagName !== 'IMG') {
            console.log('image-zoom: click/tap not on IMG - tagName=' + (el ? el.tagName : 'null'));
            return false;
        }

        var containerMatch = el.closest('.entry-content') || el.closest('.article-content') || el.closest('.post-content') || el.closest('#contents');
        if (!containerMatch) {
            console.log('image-zoom: IMG not in matching container');
            return false;
        }

        var src = getImageSrc(el);
        if (!src) {
            console.log('image-zoom: no image src found');
            return false;
        }

        // skip very tiny images (icons)
        try {
            var rect = el.getBoundingClientRect();
            if (rect.width < MIN_DIM || rect.height < MIN_DIM) {
                console.log('image-zoom: image too small - ' + rect.width + 'x' + rect.height);
                return false;
            }
        } catch (e) {}

        console.log('image-zoom: opening image - src=' + src + ', alt=' + (el.alt || 'none'));

        // stop link navigation if image is nested inside anchor
        if (ev && ev.preventDefault) ev.preventDefault();
        if (ev && ev.stopPropagation) ev.stopPropagation();

        // remember that we opened via touch so the synthesized click won't reopen
        lastTouchOpen = Date.now();
        open(src, el.alt || '');
        return true;
    }

    // Handle click events
    document.addEventListener('click', function (ev) {
        // ignore clicks that immediately follow a touch-based open
        if (Date.now() - lastTouchOpen < 450) return;
        var el = ev.target;
        console.log('image-zoom: click received - target=' + (el.tagName || 'unknown'));
        handleOpenEvent(el, ev);
    }, false);

    // Pointer-based devices: listen for pointerup with pointerType='touch'
    if (window.PointerEvent) {
        document.addEventListener('pointerup', function (ev) {
            if (ev.pointerType !== 'touch') return;
            console.log('image-zoom: pointerup touch event received');
            // element under pointer
            var el = ev.target || document.elementFromPoint(ev.clientX, ev.clientY);
            if (!el) return;
            handleOpenEvent(el, ev);
        }, {passive: false});
    }

    // fallback: touchend for older browsers
    document.addEventListener('touchend', function (ev) {
        console.log('image-zoom: touchend event received');
        // find the changed touch and its target
        if (!ev.changedTouches || ev.changedTouches.length === 0) return;
        var t = ev.changedTouches[0];
        var el = t.target || document.elementFromPoint(t.clientX, t.clientY);
        if (!el) return;
        // if our touch handling opened the overlay, prevent the synthetic click from navigating
        var opened = handleOpenEvent(el, ev);
        if (opened) {
            // stop the upcoming click
            ev.preventDefault();
        }
    }, {passive: false});

})();