import os

def rewrite_login():
    login_dir = "frontend/templates"
    login_file = os.path.join(login_dir, "login.html")
    
    if not os.path.exists(login_dir):
        os.makedirs(login_dir)
    
    with open(login_file, 'w') as file:
        file.write("""
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form method="post">
        {% csrf_token %}
        {{ form.as_p }}
        <button type="submit">Login</button>
    </form>
    <p>Don't have an account? <a href="{% url 'signup' %}">Sign up</a></p>
</body>
</html>
""")

def rewrite_signup():
    signup_dir = "frontend/templates"
    signup_file = os.path.join(signup_dir, "signup.html")
    
    if not os.path.exists(signup_dir):
        os.makedirs(signup_dir)

    with open(signup_file, 'w') as file:
        file.write("""
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
</head>
<body>
    <h2>Sign Up</h2>
    <form method="post">
        {% csrf_token %}
        {{ form.as_p }}
        <button type="submit">Sign Up</button>
    </form>
    <p>Already have an account? <a href="{% url 'login' %}">Login</a></p>
</body>
</html>
""")

if __name__ == "__main__":
    rewrite_login()
    rewrite_signup()
