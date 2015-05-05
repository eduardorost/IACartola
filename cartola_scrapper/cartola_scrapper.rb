require 'net/http'
require 'json'

class CartolaScrapper

  @@uri =  URI("http://cartolafc.globo.com/mercado/filtrar.json")

  @@players = []

  def self.get_total_pages
    JSON.parse(Net::HTTP.get(@@uri))["page"]["total"]
  end

  def self.get_rodada
    JSON.parse(Net::HTTP.get(@@uri))["rodada_id"]
  end

  for i in 1..get_total_pages.to_i
    params = { :page => i }
    @@uri.query = URI.encode_www_form(params)
    p JSON.parse(Net::HTTP.get_response(@@uri))
    @@players.concat(JSON.parse(Net::HTTP.get_response(@@uri))["atletas"])
    p @@players.size
  end

end



