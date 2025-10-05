from flask import Flask, request, jsonify
import mysql.connector
import os

app = Flask(__name__)

def get_db_connection():
    return mysql.connector.connect(
        host=os.environ.get("DB_HOST", "mysql"),
        user=os.environ.get("DB_USER", "root"),
        password=os.environ.get("DB_PASS", "password"),
        database=os.environ.get("DB_NAME", "school")
    )

@app.route('/api/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE username=%s AND password=%s", (username, password))
    user = cursor.fetchone()
    conn.close()

    if user:
        return jsonify({"message": "Login successful"}), 200
    else:
        return jsonify({"message": "Invalid credentials"}), 401

@app.route('/api/marks', methods=['POST'])
def submit_marks():
    data = request.get_json()
    username = data.get('username')
    physics = data.get('physics')
    chemistry = data.get('chemistry')
    maths = data.get('maths')

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("INSERT INTO marks (username, physics, chemistry, maths) VALUES (%s, %s, %s, %s)",
                   (username, physics, chemistry, maths))
    conn.commit()
    conn.close()

    return jsonify({"message": "Marks stored successfully"}), 201

@app.route('/api/health')
def health():
    return "OK", 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

