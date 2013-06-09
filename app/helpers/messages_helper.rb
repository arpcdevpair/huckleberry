module MessagesHelper
  def to_html message
    html = message.text
    
    message.senders.map(&:user).each { |user| html = html.gsub(/#{user.initials}\>/i, "#{profile_link user}&gt;") }
    message.recipients.map(&:user).each { |user| html = html.gsub(/\@#{user.initials}/i, "@#{profile_link user}") }
    message.channelMessages.map(&:channel).each { |channel| html = html.gsub(/\##{channel.name}/i, "\##{link_to channel.name.downcase, channel}") }
    html = html.gsub(/FB([\d]+)/, "<a href=\"#{FogbugzConfig.config[:url]}/default.asp?\\1\">\\0</a>")

    return html
  end
  
  def profile_link user
    "#{link_to user.name, user}"
  end
end
