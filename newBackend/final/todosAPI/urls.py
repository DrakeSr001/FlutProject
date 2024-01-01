from django.urls import path
from .views import GetCourse, AddCourse, SingleCourse, UpdateCourse, GetUser,AddUser, SingleUser, UpdateUser, GetLesson, AddLesson, SingleLesson, UpdateLesson
from .views import GetDiscussion, AddDiscussion, SingleDiscussion, UpdateDiscussion, GetEnrollment, AddEnrollment, SingleEnrollment, UpdateEnrollment

urlpatterns = [
    path("GetCourse", GetCourse.as_view()),
    path("AddCourse", AddCourse.as_view()),
    path("SingleCourse/<int:pk>", SingleCourse.as_view()),
    path("UpdateCourse/<int:pk>/update/", UpdateCourse.as_view()),
    
    
    path("GetUser", GetUser.as_view()),
    path("AddUser", AddUser.as_view()),
    path("SingleUser/<int:pk>", SingleUser.as_view()),
    path("UpdateUser/<int:pk>/update/", UpdateUser.as_view()),
    
    
    path("GetLesson", GetLesson.as_view()),
    path("AddLesson", AddLesson.as_view()),
    path("SingleLesson/<int:pk>", SingleLesson.as_view()),
    path("UpdateLesson/<int:pk>/update/", UpdateLesson.as_view()),
    
    
    path("GetEnrollment", GetEnrollment.as_view()),
    path("AddEnrollment", AddEnrollment.as_view()),
    path("SingleEnrollment/<int:pk>", SingleEnrollment.as_view()),
    path("UpdateEnrollment/<int:pk>/update/", UpdateEnrollment.as_view()),
    
    
    path("GetDiscussion", GetDiscussion.as_view()),
    path("AddDiscussion", AddDiscussion.as_view()),
    path("SingleDiscussion/<int:pk>", SingleDiscussion.as_view()),
    path("UpdateDiscussion/<int:pk>/update/", UpdateDiscussion.as_view()),
    
]