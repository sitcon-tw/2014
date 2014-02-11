module ViewHelpers
  def load_yaml(file)
    YAML.load_file(File.join(File.dirname(__FILE__), file))
  end

  def load_json(file)
    JSON.parse(IO.read(File.join(File.dirname(__FILE__), file)))
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

  def sponsors
    data ||= load_yaml("sponsors.yml")
    data
  end

  def team
    data ||= load_json("team.json")
    data
  end

  def schedule
    data ||= load_json("schedule.json")
    data["schedule"]
  end

  # Schedule
  def render_sessions(item)
    result = ""
    case item["type"]
      when "event"
        content_for :event, item["event"]
        result = render :partial => "schedule/event"
      when "break"
        result = render :partial => "schedule/break"
      when "session"

       item["sessions"].each do |session_id|
         content_for :session_id, session_id
         content_for :session, sessions[session_id]
         result += render :partial => "schedule/session"
       end
    end

    # Clear Content For
    content_for :event, nil
    content_for :session_id, nil
    content_for :session, nil

    result
  end

  def schedule_tag(tag)
    case tag
    when "Lounge"
      return "交誼廳"
    when "Lightning-Talk"
      return "Lightning Talk"
    when "Short-Talk"
      return "Short Talk"
    when "Panel"
      return "座談會"
    when "R1"
      return "第一會議室"
    when "R2"
      return "第二會議室"
    when "R0"
      return "國際會議廳"
    end

    tag
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

  def javascript_include_tag(src, html_options = {})
    src = "#{Compass.configuration.javascripts_dir}/#{src}.js" unless src =~ /^(https?:|\/)/
    content_tag :script, "", html_options.merge(:src => src)
  end

  def avatar_image(avatar_url, size = 150, html_options = {})
    avatar_url = "speakers/default.png" if avatar_url.nil?
    avatar_url = "http://www.gravatar.com/avatar/#{avatar_url[2..-1]}?d=mm&s=#{size}" if avatar_url =~ /^(g:)/
    image_tag(avatar_url, html_options)
  end

  def link_to_talk(talk_id, html_options = {})
    link_to sessions[talk_id]["title"], "##{talk_id}", html_options
  end
end
