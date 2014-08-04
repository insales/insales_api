module ApplicationHelper
  def flash_messages(options = {})
    messages = [:error, :notice, :alert].map { |key|
      message = flash[key]
      next if message.blank?
      content_tag :div, message, class: "alert alert-#{flash_class(key)}"
    }.compact
    flash.clear unless options[:keep]
    return if messages.empty?
    content = messages.join.html_safe
    content_tag(:div, content, class: 'messages messages-flash')
  end

  private
    def flash_class(level)
      case level
      when :error   then :danger
      when :notice  then :info
      when :alert   then :warning
      else level
      end
    end
end
