module ViewHelpers
  def config
    data ||= YAML.load_file(File.join(File.dirname(__FILE__), "config.yml"))
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
end
