# frozen_string_literal: true

require './test/test_helper'

class ClientTest < MiniTest::Test
  def client
    Client.new
  end

  def test_that_can_pokemon
    get_pokemon = client.get_pokemon('ditto')
    assert_instance_of Hash, get_pokemon, 'should get a pokemon'
  end

  # def test_post_request
  #   assert_raises ClientError do
  #     client.post_pokemon('id/1')
  #   end
  # end

  # def test_delete_request
  #   assert_raises ClientError do
  #     client.delete_pokemon('id/1')
  #   end
  # end

  # def test_put_request
  #   assert_raises ClientError do
  #     client.put_pokemon('id/1')
  #   end
  # end
end
