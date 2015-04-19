module ApplicationHelper
  def icon(name, options = {})
    default_options = { class: ['glyphicon', "glyphicon-#{name}"], 'aria-hidden' => 'true' }
    options         = default_options.merge(options)

    content_tag(:span, nil, options).html_safe
  end

  def app_description
    'O Peba é um sistema que indexa em fonte única informações relacionadas às despesas de vários entidades ' <<
    'governamentais com suporte para filtros e buscas avançadas.'
  end
end
