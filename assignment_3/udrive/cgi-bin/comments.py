#!/C:/Users/Huy.PhamN1/Desktop/.venv/Scripts/Activate.ps1

from flask import Flask, request, render_template_string

app = Flask(__name__)

# HTML template
HTML_TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>Your Comment</title>
</head>
<body bgcolor="#E0E0E0">
    <h1>Your Comment</h1>
    <form action="/" method="post">
        <p>Name:<br><input type="text" name="UserName" size="40" maxlength="40"></p>
        <p>Text:<br><textarea rows="5" cols="50" name="CommentText"></textarea></p>
        <p><input type="submit" value="Submit"></p>
    </form>
</body>
</html>
"""

SUCCESS_TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>Comment Submitted</title>
</head>
<body bgcolor="#E0E0E0">
    <h1>Thank You!</h1>
    <p>Your comment has been recorded.</p>
    <a href="/">Back to home</a>
    <h2>Feedback</h2>
    <ul>
        <li><b>Name:</b> {{ name }}</li>
        <li><b>Comment:</b> {{ comment }}</li>
    </ul>
</body>
</html>
"""

@app.route("/", methods=["GET", "POST"])
def comment():
    if request.method == "POST":
        username = request.form.get("UserName", "Anonymous")
        comment_text = request.form.get("CommentText", "")

        # Ghi vào file data.txt
        with open("data.txt", "a", encoding="utf-8") as file:
            file.write(f"Name: {username}\nComment: {comment_text}\n------------------------\n")

        return render_template_string(SUCCESS_TEMPLATE, name=username, comment=comment_text)

    return render_template_string(HTML_TEMPLATE)

if __name__ == "__main__":
    app.run(debug=True)
