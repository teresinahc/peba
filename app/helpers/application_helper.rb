module ApplicationHelper
  def icon(name, options = {})
    default_options = { class: ['glyphicon', "glyphicon-#{name}"], 'aria-hidden' => 'true' }
    options         = default_options.merge(options)

    content_tag(:span, nil, options).html_safe
  end
end
