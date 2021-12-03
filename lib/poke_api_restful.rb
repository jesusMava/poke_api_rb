# frozen_string_literal: true

require_relative 'poke_api_restful/version'
require_relative 'poke_api_restful/client'

module PokeApiRestful
  class Error < StandardError; end
  client = Client.new
  print '---- my pokemon----'
  p client.get_pokemon('ditto')
end
