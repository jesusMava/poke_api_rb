# frozen_string_literal: true

require './test/test_helper'

class PokeApiRestful::BaseApiTest < MiniTest::Test
  def test_thread
    @class = PokeApiRestful::BaseApi.new
    VCR.use_cassette("synopsis") do
      assert_instance_of Array, @class.get_all_pokemons
    end
  end
end
