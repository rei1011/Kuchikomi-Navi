class ExampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    p 'example job started'
  end
end
