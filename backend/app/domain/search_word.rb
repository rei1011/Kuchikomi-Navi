# frozen_string_literal: true

# 検索文字列
class SearchWord
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def empty
    return true if @value.nil? || @value == ''

    false
  end
end
