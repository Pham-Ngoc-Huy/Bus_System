### HOW TO USE 
## Install virtual environment
pip install virtualenv
## Create virtual environment
python3 -m .venv venv
## Activate the virtual environment
# Windows -> launch with powershell or in vscode (Crtl + shift + ~)
. /.venv/Scripts/Activate.ps1
# Windows -> command prompt
.venv\Scripts\activate
# Mac/Linux
source venv/bin/activate
## Installation package needed
pip install -r requirements.txt

## Run the main.py -> to host the website -> click on the url to access
python3 main.py or python main.py

## File structure and purposes:
dbsource: place of database 
---data.txt: datasource
static: file image and css file for html
---style.css
---regression_plot.png
templates: html and javascript inside work for the main website
---upload.html
uploads: all the file uploads will be stored here -> erase manually
--namefile.txt (just upload the file with structure: x,y)
app.py: settings app
regression.py: settings calculation and plotting regression
main.py: run as a package for all files
README.md: guidlines and tutorials
requirement.txt: all the libraries need to installed

## Function:
# Regression Calculation -> regression.py
- OOP structure for calculation a and b 
- plotting the regression line and save the image.png at folder:static
- save the result for html display

# App Starting -> app.py
- App settings and configuration
    - Settings the server Flask
    - Settings the calling rule for folder path or file path
    - Call the regression.py -> preparing for calculation
- Input data
    - Input the data field
    - Read and append the data into database source at folder: dbsource with file: data.txt (just simple strorage with txt file)
- Upload file:
    - Store file upload at folder: uploads
    - Read and append the data inside file.txt into database source at folder: dbsource with file: data.txt
- Clear the data 
    - Clear all the data in dbsource and plotting image
- Render result
    - Save the result to display on html

# HTML (javascript involved) and CSS (just for design)
- script parts: maked by javascript: (main using javascript here just about fetch the data -> to display on html only not further usage)

