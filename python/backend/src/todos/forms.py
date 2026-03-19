from django import forms

from .models import Todo


class PersonForm(forms.Form):
    name = forms.CharField(max_length=100, required=True, label="Please enter name")
    age = forms.IntegerField(label="Please enter age")
    job = forms.CharField(max_length=100, required=False, label="Please enter job")


class TodoForm(forms.ModelForm):
    class Meta:
        model = Todo
        fields = ["title", "description", "done", "deadline", "priority"]
        widgets = {
            "deadline": forms.DateInput(attrs={"type": "date"}),
        }
