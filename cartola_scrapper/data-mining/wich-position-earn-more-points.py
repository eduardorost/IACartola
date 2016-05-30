import json
from pprint import pprint
from os import listdir
from os.path import isfile, join

mypath = '2015/'
filesrodada = [f for f in listdir(mypath) if isfile(join(mypath, f))]

rodadas = []

for file in filesrodada:
    with open(mypath + file) as data_file: data = json.load(data_file)
    rodadas.append(data)

posicoesQtd = {}
posicoesTotal = {}
posicoesFinal = {}    
    
for rodada in rodadas:
    for jogador in rodada:
        posicao = str(jogador['posicao']['abreviacao'])
        posicoesTotal[posicao] = posicoesTotal.get(posicao, 0) + float(jogador['pontos'])
        if float(jogador['pontos']) > 0:
            posicoesQtd[posicao] = posicoesQtd.get(posicao, 0) + 1 

for key, value in posicoesTotal.iteritems():
    posicoesFinal[key] = value / posicoesQtd[key]

pprint('ANALISADOS')
pprint(posicoesQtd)
pprint('TOTAL DE PONTOS')
pprint(posicoesTotal)
pprint('MEDIA')
pprint(posicoesFinal)

    