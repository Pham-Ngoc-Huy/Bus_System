from flask import Flask, request, render_template, jsonify, url_for
import os
import pandas as pd
from regression import Regression

class App:
    def __init__(self):
        self.app = Flask(__name__)
        self.app.config['UPLOAD_FOLDER'] = 'uploads'
        self.db_source = "dbsource/data.txt"
        os.makedirs(self.app.config['UPLOAD_FOLDER'], exist_ok=True)

        # Initialize Regression after ensuring db_source exists
        open(self.db_source, 'a').close()
        self.regression_instance = Regression(self.db_source)

        self.setup_routes()
    
    def setup_routes(self):
        self.app.add_url_rule("/", "upload_file", self.upload_file, methods=["GET", "POST"])
        self.app.add_url_rule("/add_point", "add_point", self.add_point, methods=["POST"])
        self.app.add_url_rule("/clear_data", "clear_data", self.clear_data, methods=["POST"])
    
    def perform_regression(self):
        self.regression_instance = Regression(self.db_source)
        self.regression_instance.read_file()
        self.regression_instance.data_type_config()
        self.regression_instance.preparing_calculation()
        self.regression_instance.a = self.regression_instance.creating_a()
        self.regression_instance.b = self.regression_instance.creating_b()
        self.regression_instance.plot_regression()

    def add_point(self):
        if request.method == "POST":
            try:
                x = float(request.form["x"])
                y = float(request.form["y"])
                
                with open(self.db_source, 'a') as file:
                    file.write(f"{x},{y}\n")

                self.perform_regression()
            except ValueError:
                return "Invalid input!", 400
        return self.render_results()


    def upload_file(self):
        if request.method == "POST":
            if "file" not in request.files:
                return "No file uploaded", 400
            file = request.files["file"]
            if file.filename == "":
                return "No selected file", 400

            file_path = os.path.join(self.app.config["UPLOAD_FOLDER"], file.filename)
            file.save(file_path)

            try:
                with open(file_path, 'r') as f:
                    lines = f.readlines()

                with open(self.db_source, 'a') as file:
                    for line in lines:
                        file.write(line.strip() + "\n")

                self.perform_regression()
            except Exception as e:
                return f"Error: {str(e)}", 500

        return self.render_results()

    def clear_data(self):
        open(self.db_source, 'w').close()
        plot_path = os.path.join("static", "regression_plot.png")
        if os.path.exists(plot_path):
            os.remove(plot_path)
        self.perform_regression()
        return self.render_results()
    
    def render_results(self):
        data_points = []
        try:
            with open(self.db_source, 'r') as file:
                data_points = [line.strip().split(',') for line in file.readlines()]
            
            df = pd.DataFrame(data_points, columns=['x', 'y'])
            data_dict = df.to_dict(orient="records")  
        except Exception:
            data_dict = []
            pass
        plot_path = "static/regression_plot.png"
        plot_url = url_for("static", filename="regression_plot.png") if os.path.exists(plot_path) else None
        return render_template(
            "upload.html",
            result_text=f"Coefficient a: {self.regression_instance.a}, Coefficient b: {self.regression_instance.b}",
            plot_url=plot_url,
            data_points=data_dict 
        )
    
    def run(self, debug=True):
        self.app.run(debug=debug)
