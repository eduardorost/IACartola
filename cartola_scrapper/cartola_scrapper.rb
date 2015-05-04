require 'net/http'
require 'json'

class Jogador

end

class CartolaScrapper
  uri = URI('http://cartolafc.globo.com/mercado/filtrar.json')
  j =  JSON.parse(Net::HTTP.get(uri))
  p j
end

