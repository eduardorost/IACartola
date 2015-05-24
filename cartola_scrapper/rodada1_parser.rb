require 'json'


class Rodada1Parser



  @@players = []

    File.readlines("data/rodada1.txt").each do |l|
      @@players.concat(JSON.parse(l)["atleta"])
    end

  File.open(("data/rodada1_parsed.txt"), 'w') do |f|
    f.puts(@@players.to_json)
  end
end