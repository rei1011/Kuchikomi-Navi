class TestService # rubocop:disable Style/Documentation
  def self.test
    raise StandardError, 'error occured'
  end
end
