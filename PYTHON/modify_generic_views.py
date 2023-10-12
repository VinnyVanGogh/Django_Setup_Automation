def rewrite_settings():
    settings_path = "backend/generic/views.py"

    with open(settings_path, 'w') as file:
        file.write("""
from django.contrib.auth.views import LoginView
from django.urls import reverse_lazy
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth import login
from django.shortcuts import render, redirect

class CustomLoginView(LoginView):
    template_name = 'login.html'  # As long as the template is in the templates folder, Django will find it.
    
def signup_view(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            return redirect('success_redirect')  
    else:
        form = UserCreationForm()
    return render(request, 'signup.html', {'form': form})
""")

if __name__ == "__main__":
    rewrite_settings()
