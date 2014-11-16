def confirm_dialog
  page.driver.browser.switch_to.alert.accept
end

def cancel_dialog
  page.driver.browser.switch_to.alert.deny
end