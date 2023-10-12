def rewrite_settings():
    settings_path = "backend/generic/urls.py"

    with open(settings_path, 'w') as file:
        file.write("""
from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.CustomLoginView.as_view(), name='login'),
    path('signup/', views.signup_view, name='signup'),
]
""")

if __name__ == "__main__":

    rewrite_settings()
