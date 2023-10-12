import os

# Define the configuration template
config_template = """from django.apps import AppConfig

class {app_name}Config(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "{app_path}"
"""

# List of app names and their corresponding paths
apps_info = [
    ("core", "backend.core"),
    ("api", "backend.api"),
    ("utilities", "backend.utilities"),
    ("generic", "backend.generic"),
]

# Iterate over each app and update its AppConfig
for app_name, app_path in apps_info:
    # Create the AppConfig content
    config_content = config_template.format(app_name=app_name, app_path=app_path)
    
    # Determine the path to the apps.py file
    apps_py_path = os.path.join("backend", app_name, "apps.py")

    # Write the AppConfig content to the apps.py file
    with open(apps_py_path, "w") as file:
        file.write(config_content)

    print(f"Updated {app_name}/apps.py")

print("AppConfig files updated successfully.")
