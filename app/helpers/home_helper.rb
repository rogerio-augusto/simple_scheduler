module HomeHelper
  def week_table_config
    { events: @meetings, 
      table: {
        class: "table table-hover", 
        style: 'marging-bottom: 0'
      }, 
      header: {
        class: 'box-header'
      }, 
      start_date: @start_date,
      title: ->(start_date) { content_tag :h3, "#{I18n.t("date.month_names")[start_date.month]} #{start_date.year}", class: "box-title" }, 
      previous_link: ->(param, date_range) { link_to(raw("&laquo;"), {param => date_range.first - 1.day}, { class: 'pull-left previous-week-link' }) }, 
      next_link: ->(param, date_range) { link_to(raw("&raquo;"), {param => date_range.last + 1.day}, { class: 'next-week-link pull-left' }) }
    } 
  end
end
