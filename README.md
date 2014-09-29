# Instagram Plugin for Jekyll
This  plugin is inspired [A Liquid tag for Jekyll sites that allows embedding image file on Instagram.](https://gist.github.com/niku4i/2134897).

## How to install

### Get instagram_tag.rb

    cd path/to/plugins
    wget https://raw.github.com/longkey1/jekyll-instagram-plugin/master/instagram_tag.rb


or by git-submodule

    cd /path/to/jekyll
    git submodule add git://github.com/longkey1/jekyll-instagram-plugin.git _plugins/instagram


### Configuring

    vi /path/to/jekyll/_config.yml

    + # Instagram plugin
    + instagram_cache:         false # or true
    + instagram_cache_dir:     '.instagram-cache'      # default '.instagram-cache'


## Usage

### Syntax:

    {% instagram [class name(s)] http://instagram.com/p/BUG/ [width [height]] [title text] %}

### Examples:

    {% instagram left http://instagram.com/p/BUG/ 300 300 "sample text" %}
