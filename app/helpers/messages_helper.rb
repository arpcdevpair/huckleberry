module MessagesHelper
  # @param [Message] message
  def to_html(message)
    html = message.text

    message.message_senders.each { |user| html = html.gsub(/#{user.initials}\>/i, "#{profile_link user}&gt;") }
    message.message_recipients.each { |user| html = html.gsub(/\@#{user.initials}/i, "@#{profile_link user}") }
    message.channelMessages.map(&:channel).each { |channel| html = html.gsub(/\##{channel.name}/i, "\##{link_to channel.name.downcase, channel}") }
    html = html.gsub(/FB([\d]+)/, "<a href=\"#{FogbugzConfig.config[:url]}/default.asp?\\1\">\\0</a>")

    return html
  end

  # @param [User] user
  def profile_link(user)
    link_to user.name, user
  end
end
