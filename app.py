from flask import Flask, jsonify
import os

app = Flask(__name__)

# Версія застосунку — зручно для демонстрації оновлень через GitOps
VERSION = os.getenv("APP_VERSION", "1.0.0")

@app.route("/")
def index():
    return jsonify(
        message="Secure GitOps Deployment Demo",
        version=VERSION,
        status="running"
    )

@app.route("/health")
def health():
    # Ендпоінт для перевірки життєздатності (liveness/readiness probes у Kubernetes)
    return jsonify(status="healthy"), 200

if __name__ == "__main__":
    # Слухаємо на всіх інтерфейсах, порт 8080
    app.run(host="0.0.0.0", port=8080)
