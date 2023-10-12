def rewrite_settings(app_name, urls_path):
    with open(urls_path, 'w') as file:
        file.write(
"""
from django.urls import path, include, reverse_lazy
from django.shortcuts import render, redirect

urlpatterns = [
    # Add URL patterns for your app as needed
]
""".format(app_name))

if __name__ == "__main__":
    apps = [
        ("api", "backend/api/urls.py"),
        ("core", "backend/core/urls.py"),
        ("utilities", "backend/utilities/urls.py"),
    ]

    for app_name, urls_path in apps:
        rewrite_settings(app_name, urls_path)
