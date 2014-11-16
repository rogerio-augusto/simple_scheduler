module ApplicationHelper  
  def icon(name, text = "", options = {})
    text = "#{text}" unless text.present?
    if options.has_key?(:class)
      options[:class] << " fa fa-#{name.to_s}"
    else
      options.reverse_merge! :class => " fa fa-#{name.to_s}"
    end
    span_tag = content_tag(:span, text.html_safe)
    content_tag(:i, span_tag, options).html_safe
  end
  
  def edit_link(path, options = {})
    link_to icon('pencil-square-o'), path, options
  end
  
  def delete_link(path, options = {})
    opts = { data: { confirm: t('warnings.confirm_destroy') }, :method => :delete }.merge(options)

    link_to icon('trash-o'), path, opts
  end
end
