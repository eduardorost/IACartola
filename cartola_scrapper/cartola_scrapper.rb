require 'net/http'
require 'json'
require 'mechanize'
require 'pry'

class CartolaScrapper

  BASE_URI = URI("http://cartolafc.globo.com/mercado/filtrar.json")

  @@players = []

  AGENT = Mechanize.new
  AGENT.user_agent_alias = 'Mac Safari'
  #AGENT.agent.http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  def self.get_info
    info = JSON.parse(AGENT.get(BASE_URI).body)
    {total_pages: info["page"]["total"].to_i, rodada: info["rodada_id"].to_i}
  end

  def self.get_response(params)
    url = BASE_URI
    url.query=URI.encode_www_form params
    res = AGENT.get(url.to_s)
    res.body
  end

  def self.login
      AGENT.get('https://loginfree.globo.com/login/438') do |page|
        form_login = page.form
        form_login.fields.first.value = 'user '
        form_login.fields.last.value = 'senha '
        form_login.submit
      end
  end

  login
  total_pages, rodada = get_info.values


  for i in 1..total_pages
    params = { :page => i }
    p i
    @@players.concat(JSON.parse(get_response(params))["atleta"])
    sleep 0.1
  end

  File.open(("data/rodada" + rodada.to_s + ".json"), 'w') do |f|
    p @@players.size
    f.puts(@@players.to_json)
  end

end



