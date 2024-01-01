from django.contrib import admin
from .models import Course, Enrollment, Discussion, User, Lesson

# Register your models here.
admin.site.register(Course)
admin.site.register(Enrollment)
admin.site.register(Discussion)
admin.site.register(User)
admin.site.register(Lesson)