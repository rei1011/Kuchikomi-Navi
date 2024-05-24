# frozen_string_literal: true

# 標準出力とlogの両方を出力する
class KuchikomiLogger
  def self.error(error)
    p "#{error.class}: #{error}"
    p error.backtrace
    Rails.logger.error "#{error.class}: #{error}"
    Rails.logger.error error.backtrace
  end
end
