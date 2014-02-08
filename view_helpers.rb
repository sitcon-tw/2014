module ViewHelpers
  def load_yaml(file)
    YAML.load_file(File.join(File.dirname(__FILE__), file))
  end
  def config
    data ||= load_yaml("config.yml")
    data
  end

  def sessions
    data ||= load_yaml("sessions.yml")
    data
  end

  def speakers
    data ||= load_yaml("speakers.yml")
    data
  end

  def enable_analytics?
    config['analytics']['enabled']
  end

  def analytics_code
    config['analytics']['code']
  end

  def bower_tag(path)
    content_tag :script, "", :src => "bower_components/#{path}.js"
  end

  # Relative version image tag
  def image_tag(src, html_options = {})
    src = "#{Compass.configuration.images_dir}/#{src}" unless src =~ /^(https?:|\/)/
    tag(:img, html_options.merge(:src=>src))
  end

  def avatar_image(avatar_url, size = 150)
    avatar_url = "http://www.gravatar.com/avatar/?d=mm&s=#{size}" if avatar_url.nil?
    avatar_url = "http://www.gravatar.com/avatar/#{avatar_url[2..-1]}?d=mm&s=#{size}" if avatar_url =~ /^(g:)/
    image_tag(avatar_url)
  end
end
