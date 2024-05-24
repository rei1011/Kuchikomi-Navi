require 'mechanize'

class TestService # rubocop:disable Style/Documentation
  def self.test
    raise Mechanize::ResponseCodeError, 'Mechanize error occured'
    # raise StandardError, 'error occured'
  end
end
