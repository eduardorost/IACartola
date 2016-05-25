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
    break;

pprint(rodadas)