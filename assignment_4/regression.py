import pandas as pd
import logging
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import os
class Regression:
    def __init__(self, file_path):
        self.file_path = file_path
        self.df = None
        self.N = None
        self.a = None
        self.b = None
        self.header = ['x', 'y']
        self.setup_logging()
        
        if self.read_file():
            self.data_type_config()
            self.preparing_calculation()
            self.a = self.creating_a()
            self.b = self.creating_b()

    def setup_logging(self):
        logging.basicConfig(
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s'
        )

    def read_file(self):
        try:
            logging.info(f"Reading file: {self.file_path}")
            with open(self.file_path, 'r') as file:
                content = file.read().strip().split('\n')
            
            self.df = pd.DataFrame([row.split(',') for row in content], columns=self.header)
            logging.info("File read successfully")
            return True
        except Exception as e:
            logging.error(f"Error reading file: {e}")
            return False

    def data_type_config(self):
        try:
            logging.info("Converting data types")
            for col in self.df.columns:
                self.df[col] = pd.to_numeric(self.df[col], errors='coerce')
            logging.info("Data type conversion complete")
            return True
        except Exception as e:
            logging.error(f"Error in data type conversion: {e}")
            return False

    def preparing_calculation(self):
        try:
            logging.info("Preparing regression calculations")
            self.N = len(self.df)
            self.sum_x = self.df['x'].sum()
            self.sum_y = self.df['y'].sum()
            self.sum_xy = (self.df['x'] * self.df['y']).sum()
            self.sum_x2 = (self.df['x'] ** 2).sum()
            self.sum_x_squared = self.sum_x ** 2
            logging.info("Regression calculations prepared")
        except Exception as e:
            logging.error(f"Error in regression calculations: {e}")

    def creating_a(self):
        try:
            logging.info("Calculating coefficient a")
            return (self.sum_y * self.sum_x2 - self.sum_x * self.sum_xy) / (self.N * self.sum_x2 - self.sum_x_squared)
        except Exception as e:
            logging.error(f"Error calculating a: {e}")
            return None

    def creating_b(self):
        try:
            logging.info("Calculating coefficient b")
            return (self.N * self.sum_xy - self.sum_x * self.sum_y) / (self.N * self.sum_x2 - self.sum_x_squared)
        except Exception as e:
            logging.error(f"Error calculating b: {e}")
            return None

    def plot_regression(self):
        try:
            logging.info("Plotting regression line")
            plt.figure(figsize=(6, 4))
            plt.scatter(self.df['x'], self.df['y'], color='blue', label='Data Points')
            y_pred = self.a + self.b * self.df['x']
            plt.plot(self.df['x'], y_pred, color='red', label='Regression Line')
            plt.xlabel("X values")
            plt.ylabel("Y values")
            plt.title("Linear Regression")
            plt.legend()

            plot_path = os.path.join("static", "regression_plot.png")
            plt.savefig(plot_path)
            plt.close()
            
            return plot_path
        except Exception as e:
            logging.error(f"Error plotting regression: {e}")

    def get_results(self):
        return {"a": self.a, "b": self.b}
    

    
