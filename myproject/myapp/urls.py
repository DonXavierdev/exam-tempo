
from django.contrib import admin
from django.urls import path
from . import views


urlpatterns = [
    path('stud_data/', views.stud_data, name='stud_data'),
    path('teach_data/', views.teach_data, name='teach_data'),
    path('save/', views.save_data, name='save_data'),
    path('login/', views.login_view, name='login'),
]
