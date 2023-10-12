import os

config_template = """from django.apps import AppConfig

class {app_name}Config(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "{app_path}"
"""

apps_info = [
    ("core", "backend.core"),
    ("api", "backend.api"),
    ("utilities", "backend.utilities"),
    ("generic", "backend.generic"),
]

for app_name, app_path in apps_info:
    config_content = config_template.format(app_name=app_name, app_path=app_path)
    
    apps_py_path = os.path.join("backend", app_name, "apps.py")

    with open(apps_py_path, "w") as file:
        file.write(config_content)

    print(f"Updated {app_name}/apps.py")

print("AppConfig files updated successfully.")
