module Helper
  def use_browser_locale(locale)
    Capybara.current_session.driver.header 'Accept-Language', "#{locale},*"
  end

  def screenshot(filename)
    page.driver.render(Rails.root.join('tmp', 'screenshots', "#{filename}.png"))
  end
end
