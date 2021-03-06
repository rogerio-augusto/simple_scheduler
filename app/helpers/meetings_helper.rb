module MeetingsHelper
  def week_table_config
    { events: @meetings, 
      table: {
        class: "table table-hover calendar", 
        style: 'marging-bottom: 0'
      }, 
      header: {
        class: 'box-header'
      }, 
      start_date: @start_date.to_s,
      title: ->(start_date) { content_tag :h3, "#{I18n.t("date.month_names")[start_date.month]} #{start_date.year}", class: "box-title" }, 
      previous_link: ->(param, date_range) { link_to(icon('backward'), meetings_path({param => date_range.first - 1.day}), { class: 'pull-left previous-week-link has-spinner' }) }, 
      next_link: ->(param, date_range) { link_to(icon('forward'), meetings_path({param => (@start_date.next_week).to_s}), { class: 'next-week-link pull-left has-spinner' }) }
    } 
  end
end
