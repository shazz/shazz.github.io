Read More Link
===

**NOTE:** [This plugin has been moved to its own repository](https://github.com/pelican-plugins/read-more). 
Please file any issues/PRs there. Once all plugins have been migrated to the 
[new Pelican Plugins organization](https://github.com/pelican-plugins>), 
this monolithic repository will be archived.

**Author**: Vuong Nguyen (http://vuongnguyen.com)

This plugin inserts an inline "read more" or "continue" link into the last html element of the object summary.

For more information, please visit: http://vuongnguyen.com/creating-inline-read-more-link-python-pelican-lxml.html

Requirements
---

    lxml - for parsing html elements

Settings
---
    # This settings indicates that you want to create summary at a certain length
    SUMMARY_MAX_LENGTH = 50

    # This indicates what goes inside the read more link
    READ_MORE_LINK = None (ex: '<span>continue</span>')

    # This is the format of the read more link
    READ_MORE_LINK_FORMAT = '<a class="read-more" href="/{url}">{text}</a>'


