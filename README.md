# Instagram Plugin for Octopress
This  plugin is inspired [A Liquid tag for Jekyll sites that allows embedding image file on Instagram.](https://gist.github.com/niku4i/2134897).

## How to install

### Get instagram_tag.rb

    cd plugins
    wget https://raw.github.com/longkey1/octopress-instagram-plugin/master/instagram_tag.rb


or by git-submodule

    cd /path/to/octopress
    git submodule add git://github.com/longkey1/octopress-instagram-plugin.git plugins/instagram


### Configuring

    vi /path/to/octopress/_config.yml

    + # Instagram plugin
    + instagram_cache:         false # or true
    + instagram_cache_dir:     '.instagram-cache'      # default '.instagram-cache'


## Usage

### Syntax:

    {% instagram [class name(s)] http://instagram.com/p/BUG/ [width [height]] [title text] %}

### Examples:

    {% instagram left http://instagram.com/p/BUG/ 300 300 "sample text" %}
