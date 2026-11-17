import json
import os
from pathlib import Path
from flask import Flask, render_template, jsonify

app = Flask(__name__)
from flask import Flask, render_template, jsonify
import os
from pathlib import Path
from flask import Flask, render_template, jsonify

app = Flask(__name__)

MSSV = os.getenv("MSSV", "2412111053")
DATA_FILE = Path(__file__).resolve().parent / "data" / "students.json"


def load_students():
    with open(DATA_FILE, "r", encoding="utf-8") as f:
        return json.load(f)


@app.route("/")
def index():
    students = load_students()
    return render_template(
        "index.html",
        students=students,
        ho_ten="Nguyễn Duy Trung",
        mssv=MSSV
    )

@app.route("/api/health", methods=["GET"])
def health():
    return jsonify({
        "status": "ok",
        "student": MSSV
    })
if __name__ == "__main__":
    port = int(os.getenv("PORT", "5000"))
    app.run(host="0.0.0.0", port=port)
