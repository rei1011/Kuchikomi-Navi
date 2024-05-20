# frozen_string_literal: true

# 住所を表現するドメイン
class Address
  attr_reader :prefecture, :municipality

  def initialize(prefecture:, municipality:)
    @prefecture = prefecture
    @municipality = municipality
  end
end
