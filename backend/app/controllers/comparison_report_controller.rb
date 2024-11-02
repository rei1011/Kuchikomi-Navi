# frozen_string_literal: true

require 'json'

# 店舗間の比較レポートを取得する
class ComparisonReportController < ApplicationController
  def show
    query_params = Rack::Utils.parse_query(request.query_string)
    report = ReportService.find(query_params['stores'], query_params['compare_method'])
    render(json: { report: })
  end
end
