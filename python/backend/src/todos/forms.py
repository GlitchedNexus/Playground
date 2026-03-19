from django import forms

from .models import Person, Todo


class PersonForm(forms.ModelForm):
    class Meta:
        model = Person
        fields = ["name", "age"]


class TodoForm(forms.ModelForm):
    class Meta:
        model = Todo
        fields = ["title", "description", "done", "deadline", "priority"]
        widgets = {
            "deadline": forms.DateInput(attrs={"type": "date"}),
        }
