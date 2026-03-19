from django.db import models


class Person(models.Model):
    name = models.CharField(max_length=100)
    age = models.IntegerField()

    def __str__(self):
        return f"{self.id} - {self.name}"


class ImportanceChoices(models.TextChoices):
    LOW = "Low"
    MEDIUM = "Medium"
    HIGH = "High"


class Todo(models.Model):
    title = models.CharField(max_length=100)
    description = models.CharField(max_length=500)
    done = models.BooleanField(default=False)
    deadline = models.DateField(null=True, blank=True)
    importance = models.CharField(
        choices=ImportanceChoices.choices, null=True, blank=True
    )

    owner = models.ForeignKey(
        Person, on_delete=models.CASCADE, related_name="todos", blank=True, null=True
    )

    def __str__(self):
        return f"{self.id} - {self.title}"
