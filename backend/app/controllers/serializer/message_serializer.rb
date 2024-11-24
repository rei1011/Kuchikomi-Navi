# frozen_string_literal: true

class MessageSerializer < Blueprinter::Base # rubocop:disable Style/Documentation
  identifier :id
  fields :value, :role
end
