require 'open-uri'
require 'json'

module Jekyll

  class InstagramResultCache

    def initialize
      @result_cache = {}

      @cache = false
      @cache_dir = ".instagram-cache/"
    end

    @@instance = InstagramResultCache.new

    def self.instance
      @@instance
    end

    def setup(context)
      site = context.registers[:site]

      #cache_dir
      @cache = site.config['instagram_cache'] if site.config['instagram_cache']
      @cache_dir = site.config['instagram_cache_dir'].gsub(/\/$/, '') + '/' if site.config['instagram_cache_dir']
      Dir::mkdir(@cache_dir) if File.exists?(@cache_dir) == false
    end

    def get_instagram_by_url(url)
      code = get_code_by_url(url)
      return @result_cache[code] if @result_cache.has_key?(code)
      return @result_cache[code] = JSON.parse(File.read(@cache_dir + code)) if @cache && File.exist?(@cache_dir + code)

      url = 'https://api.instagram.com/oembed?url=' + url
      data = JSON.parse(open(url).read)
      @result_cache[code] = data
      open(@cache_dir + code, "w"){|f| f.write(JSON.generate(data))} if @cache

      return @result_cache[code]
    end

    def get_code_by_url(url)
      if url =~ %r|http://instagram.com/p/(\w+)/?|
        $1
      else
        raise "parametor error for instagram tag"
      end
    end

    private_class_method :new
  end

  class InstagramTag < Liquid::Tag

    def initialize(name, params, token)
      super
      @params = params
    end

    def render(context)
      attributes = ['class', 'src', 'width', 'height', 'title']
      img = nil

      if @params =~ /(?<class>\S.*\s+)?(?<src>https?:\/\/\S+)(?:\s+(?<width>\d+))?(?:\s+(?<height>\d+))?(?<title>\s+.+)?/i
        img = attributes.reduce({}) { |tmp, attr|
          tmp[attr] = $~[attr].strip if $~[attr];
          tmp
        }

        InstagramResultCache.instance.setup(context)
        instagram = InstagramResultCache.instance.get_instagram_by_url(img['src'])
        img['src'] = instagram.fetch('thumbnail_url', nil)

        if img['title']
          img['alt'] = img['title'].gsub!(/"/, '')
        elsif instagram['title']
          img['title'] = instagram['title']
          img['alt']   = instagram['title']
        end
        img['class'].gsub!(/"/, '') if img['class']
      end

      if img
        "<img #{img.map {|property,value| "#{property}=\"#{value}\"" if value}.join(" ")}>"
      else
        ""
      end
    end
  end

end

Liquid::Template.register_tag('instagram', Jekyll::InstagramTag)
