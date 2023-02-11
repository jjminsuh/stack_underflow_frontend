from flask import Flask, request, jsonify

import googletrans
from googletrans import Translator

app = Flask(__name__)

@app.route('/api', methods=['GET'])

def translate():
    Query = str(request.args['Query'])
    
    info_list = []
    temp = ''
    for i in Query:
        print(i)
        if i == '|':
            info_list += [temp]
            temp = ''
        else:
            temp += i
    print(info_list)
    
    init = info_list[0]
    text = info_list[1]
    fin = info_list[2]
    
    translator = Translator()

    translation = translator.translate(text, src= init, dest= fin)
    print(f"{translation.origin} ({translation.src}) --> {translation.text} ({translation.dest})")
    
    d = {}
    d['Query'] = str(translation.text)
    
    return jsonify(d)
    #return translation.text