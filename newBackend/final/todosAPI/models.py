from django.db import models
from phonenumber_field.modelfields import PhoneNumberField

# Create your models here.
class Course(models.Model):
    courseName = models.CharField(max_length=100)
    courseDescription = models.TextField()
    courseImagePath = models.CharField(max_length=250)
    coursePrice = models.IntegerField()
    instructorName = models.CharField(max_length=100)
    courseCategory = models.CharField(max_length=50)
    courseReleaseDate = models.DateTimeField()
    isEnrollable = models.BooleanField()
    isAvailable = models.BooleanField()

    def __str__(self):
        return self.courseName
    
    

class User(models.Model):
    default_profile_pic = "https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg"
    username = models.CharField(max_length=100)
    firstName = models.CharField(max_length=100)
    lastName = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=100)  # Consider using Django's built-in User model for authentication
    profileImage = models.URLField(max_length=250, default=default_profile_pic, null=True, blank=True)
    phoneNumber = PhoneNumberField()
    enrolledCourses = models.ManyToManyField('Course', through='Enrollment')

    def __str__(self):
        return self.username

class Lesson(models.Model):
    lessonTitle = models.CharField(max_length=100)
    lessonDescription = models.TextField()
    videoUrl = models.CharField(max_length=250)
    lessonReleaseDate = models.DateTimeField()
    isAvailable = models.BooleanField()
    course = models.ForeignKey('Course', on_delete=models.CASCADE)

    def __str__(self):
        return self.lessonTitle

class Discussion(models.Model):
    discussionTitle = models.CharField(max_length=100)
    discussionContent = models.TextField()
    authorName = models.CharField(max_length=100)
    postDate = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.discussionTitle


class Enrollment(models.Model):
    course = models.ForeignKey('Course', on_delete=models.CASCADE)
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    enrollmentDate = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'{self.user.username} enrolled in {self.course.courseName}'






