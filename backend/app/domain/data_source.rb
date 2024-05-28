# frozen_string_literal: true

# データの取得先
class DataSource
  FUJOHO = 0
  FUZOKU = 1
  UNKNOWN = nil
  STATUSES = [FUJOHO, FUZOKU, UNKNOWN].freeze
  attr_reader :value

  def initialize(data_source)
    raise ArgumentError, "Invalid data source data_source = #{data_source}" unless STATUSES.include?(data_source)

    @value = data_source
  end
end
