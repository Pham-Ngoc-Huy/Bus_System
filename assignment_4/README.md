### HOW TO USE

## 1️⃣ Install Virtual Environment
```bash
pip install virtualenv
```

## 2️⃣ Create Virtual Environment
```bash
python3 -m venv .venv
```

## 3️⃣ Activate the Virtual Environment
### Windows
- **PowerShell (or VS Code terminal: `Ctrl + Shift + ~`)**
  ```powershell
  .\.venv\Scripts\Activate.ps1
  ```
- **Command Prompt (cmd.exe)**
  ```cmd
  .venv\Scripts\activate
  ```
### Mac/Linux
```bash
source .venv/bin/activate
```

## 4️⃣ Install Required Packages
```bash
pip install -r requirements.txt
```

## 5️⃣ Run the Application
To host the website, run:
```bash
python3 main.py  # or python main.py
```
Click on the generated URL to access the web application.

---
## 📁 File Structure & Purpose
```
project_folder/
│── dbsource/          # Stores database source files
│   ├── data.txt       # Data source file
│
│── static/            # Stores static files (CSS & images)
│   ├── style.css      # CSS for HTML design
│   ├── regression_plot.png  # Regression plot image
│
│── templates/         # HTML and JavaScript files for the website
│   ├── upload.html    # Upload page
│
│── uploads/           # Directory for uploaded files (must be cleared manually)
│   ├── namefile.txt   # Example file structure: x,y
│
│── app.py             # Flask app settings & configuration
│── regression.py      # Handles regression calculations & plotting
│── main.py            # Main entry point to run the app
│── README.md          # Guidelines & tutorials
│── requirements.txt   # List of dependencies
```

---
## 🔧 Functionality

### 1️⃣ Regression Calculation (`regression.py`)
- Implements an **OOP-based** approach for calculating regression coefficients (`a`, `b`).
- Plots the regression line and saves the image (`static/regression_plot.png`).
- Stores calculation results for HTML display.

### 2️⃣ App Configuration (`app.py`)
- **Flask server settings**
- Defines URL routing and folder paths
- Calls `regression.py` for regression calculations

### 3️⃣ Data Input
- Accepts data manually through input fields
- Saves data in `dbsource/data.txt` (simple text-based storage)

### 4️⃣ File Upload
- Stores uploaded files in `uploads/`
- Reads & appends content from uploaded files into `dbsource/data.txt`

### 5️⃣ Data Clearing
- Clears stored data in `dbsource/`
- Deletes existing regression plot

### 6️⃣ Render Results
- Saves results for HTML display

---
## 🎨 Frontend (HTML, JavaScript & CSS)
- **JavaScript**: Handles fetching and displaying data on HTML.
- **CSS**: Used for styling and improving UI aesthetics.

---
### ✅ Now you're ready to run and use the application!

