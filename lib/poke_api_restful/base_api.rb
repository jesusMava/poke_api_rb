# frozen_string_literal: true

module PokeApiRestful
  class BaseApi
    def initialize
      @client = Client.new
    end

    def get_all_pokemons
      pokemons = client.get_pokemon('') do |uri|
        Net::HTTP::Get.new(uri)
      end

      list_pokemon = pokemons[:results].map { |e| e[:name] }
      list_pokemon.map do |pokemon|
        Thread.new do
          client.get_pokemon(pokemon)
        end
      end
    end

    def count
      get_all_pokemons.count
    end

    private

    attr_reader :client
  end
end
