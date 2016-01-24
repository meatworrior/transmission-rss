module TransmissionRSS
  class Feed
    attr_reader :url, :regexp, :download_path

    def initialize(config = {})
      case config
      when Hash
        @url = URI.encode(config['url'] || config.keys.first)
        @regexp = config['regexp'].split(',').map! { |x| Regexp.new((x.strip + '\.E\d+\.\d{6}\.HDTV\.H264\.720p-WITH').force_encoding("utf-8"), Regexp::IGNORECASE | Regexp::FIXEDENCODING) } if config['regexp']
        @download_path = config['download_path']
      else
        @url = config.to_s
      end
    end

    def matches_regexp?(title)
      if @regexp.nil?
        return true
      end
      
      @regexp.each do |r|
        if (title =~ r) != nil
          return true
        end
      end
      
      return false
    end
  end
end
