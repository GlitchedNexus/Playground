from django import forms


class PersonForm(forms.Form):
    name = forms.CharField(max_length=100, required=True, label="Please enter name")
    age = forms.IntegerField(label="Please enter age")
    job = forms.CharField(max_length=100, required=False, label="Please enter job")
