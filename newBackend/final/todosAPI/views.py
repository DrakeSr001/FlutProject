from .serializers import CourseSerializer, UserSerializer, LessonSerializer, DiscussionSerializer, EnrollmentSerializer
from django.shortcuts import render
from rest_framework import generics
from .models import Course, User, Lesson, Discussion, Enrollment



#Course                                         ###################################################################    

class GetCourse(generics.ListAPIView): #Get all tasks
    queryset = Course.objects.all()
    serializer_class = CourseSerializer

class AddCourse(generics.CreateAPIView): #Add task
    serializer_class = CourseSerializer

class SingleCourse(generics.RetrieveAPIView): # Read Task
    queryset = Course.objects.all()
    serializer_class = CourseSerializer
    
class UpdateCourse(generics.UpdateAPIView): # Update Task
    queryset = Course.objects.all()    
    serializer_class = CourseSerializer
    
    
    
    
    
#User                                         ###################################################################    
class GetUser(generics.ListAPIView): #Get all users
    queryset = User.objects.all()
    serializer_class = UserSerializer

class AddUser(generics.CreateAPIView): #Add Task
    serializer_class = UserSerializer

class SingleUser(generics.RetrieveAPIView): # Read Task
    queryset = User.objects.all()
    serializer_class = UserSerializer
    
class UpdateUser(generics.UpdateAPIView): # Update Task
    queryset = User.objects.all()    
    serializer_class = UserSerializer
    
    
    
    
#Lesson                                         ###################################################################    
class GetLesson(generics.ListAPIView): #Get all tasks
    queryset = Lesson.objects.all()
    serializer_class = LessonSerializer

class AddLesson(generics.CreateAPIView): #Add task
    serializer_class = LessonSerializer

class SingleLesson(generics.RetrieveAPIView): # Read Task
    queryset = Lesson.objects.all()
    serializer_class = LessonSerializer
    
class UpdateLesson(generics.UpdateAPIView): # Update Task
    queryset = Lesson.objects.all()    
    serializer_class = LessonSerializer
    
    
    
    
    
#Enrollment                                         ###################################################################    
class GetEnrollment(generics.ListAPIView): #Get All tasks
    queryset = Enrollment.objects.all()
    serializer_class = EnrollmentSerializer

class AddEnrollment(generics.CreateAPIView): #Add Task
    serializer_class = EnrollmentSerializer

class SingleEnrollment(generics.RetrieveAPIView): # Read Task
    queryset = Enrollment.objects.all()
    serializer_class = EnrollmentSerializer
    
class UpdateEnrollment(generics.UpdateAPIView): # Update Task
    queryset = Enrollment.objects.all()    
    serializer_class = EnrollmentSerializer
    
    
    
#Discussion                                         ###################################################################    
class GetDiscussion(generics.ListAPIView): #Get All tasks
    queryset = Discussion.objects.all()
    serializer_class = DiscussionSerializer

class AddDiscussion(generics.CreateAPIView): #Add Task
    serializer_class = DiscussionSerializer

class SingleDiscussion(generics.RetrieveAPIView): # Read Task
    queryset = Discussion.objects.all()
    serializer_class = DiscussionSerializer
    
class UpdateDiscussion(generics.UpdateAPIView): # Update Task
    queryset = Discussion.objects.all()    
    serializer_class = DiscussionSerializer