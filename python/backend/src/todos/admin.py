from django.contrib import admin

from .models import Person, Todo

# Register your models here.
admin.site.register(Person)


@admin.register(Todo)
class TodoAdmin(admin.ModelAdmin):
    list_display = ("title", "importance", "deadline", "done")
    search_fields = ("title",)
    list_filter = ("importance", "deadline")
