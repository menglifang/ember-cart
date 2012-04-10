module Capybara
  class Session
    def cookies
      @cookies ||= begin
                     secret = Rails.application.config.secret_token
                     cookies = ActionDispatch::Cookies::CookieJar.new(secret)
                     cookies.stub(:close!)
                     cookies
                   end
    end
  end
end

def mock_cookies
  request = ActionDispatch::Request.any_instance
  request.stub(:cookie_jar).and_return{ page.cookies }
  request.stub(:cookies).and_return{ page.cookies }
end
