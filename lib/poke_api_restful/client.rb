# frozen_string_literal: true

require 'net/http'
require 'json'

class Error < StandardError; end

class ClientError < Error; end

class ServerError < Error; end

class Client
  URL_BASE = 'https://pokeapi.co/api/v2/pokemon/'

  def get_pokemon(pokemon)
    request(pokemon) do |uri|
      Net::HTTP::Get.new(uri)
    end
  end

  # def post_pokemon(params)
  #   request(params) do |uri|
  #     Net::HTTP::Post.new(uri)
  #   end
  # end

  # def delete_pokemon(params)
  #   request(params) do |uri|
  #     Net::HTTP::Delete.new(uri)
  #   end
  # end

  # def put_pokemon(params)
  #   request(params) do |uri|
  #     Net::HTTP::Delete.new(uri)
  #   end
  # end

  private

  def request(pokemon)
    uri = URI.join(URL_BASE, pokemon)

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = yield(uri)
      handle(http.request(request))
    end
  end

  def handle(response)
    case response
    when Net::HTTPSuccess
      parse_json(response.body)
    when Net::HTTPClientError
      raise ClientError, "[#{response.code}]#{response.class}"
    when Net::HTTPServerError
      raise ServerError, "[#{response.code}]#{response.class}"
    end
  end

  def parse_json(response)
    JSON.parse(response, symbolize_names: true)
  rescue JSON::ParserError
    nil
  end
end
