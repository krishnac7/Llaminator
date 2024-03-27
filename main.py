from flask import Flask, request, jsonify, abort, render_template
import os
import ollama

app = Flask(__name__)
port = int(os.getenv('PORT', 8080))

@app.route('/')
def home():
    return render_template("home.html")

@app.route('/api/resource', methods=['POST'])
def get_resource():
    data = request.get_json()
    query = data.get('query') if data else None

    if not query:
        return jsonify({'error': 'No query provided'}), 400

    try:
        q_formatted = "<s>[INST] <<SYS>>do not give any comments or no repetition. keep it simple and concise.<</SYS>> {}[/INST]".format(query)
        generated_response = {"response": ollama.generate(model='llama2', prompt=q_formatted)['response']}
        return jsonify(generated_response), 200
    except Exception as e:
        return jsonify({'error': 'Failed to generate response', 'details': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=port)
