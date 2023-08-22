module ArticlesHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def format_date(date)
    day = date.day
    suffix = case day
             when 1, 21, 31
               '<sup>st</sup>'
             when 2, 22
               '<sup>nd</sup>'
             when 3, 23
               '<sup>rd</sup>'
             else
               '<sup>th</sup>'
             end
  
    "#{date.strftime('%b')} #{day}#{suffix}, #{date.year}".html_safe
  end
end
