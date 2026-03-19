from django.urls import path

from . import views

urlpatterns = [
    path("hello", views.hello_world_view, name="hello_world"),
    path("health", views.health_view, name="health"),
    path("hello_page", views.hello_html_view, name="hello_page"),
    path("helloname/<str:name>", views.hello_path, name="hello_name"),
    path("helloquery", views.hello_query, name="hello_query"),
    path("hello_redirect", views.special_view, name="hello_redict"),
    path("hello_post", views.post_example, name="hello_post"),
    path("submit_endpoint", views.submit_example, name="submit_example"),
    path("submit_django", views.submit_django_form, name="submit_django"),
    path("templating", views.template_view, name="templating"),
    path("todos", views.todos_view, name="todos"),
    path("register", views.register_view, name="register"),
    path("person_details/<int:person_id>", views.person_details, name="person_details"),
    path("delete_todo/<int:todo_id>", views.delete_todo, name="person_details"),
    path("toggle_todo/<int:todo_id>", views.toggle_todo, name="toggle_todo"),
]
