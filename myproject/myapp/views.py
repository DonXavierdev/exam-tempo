from django.shortcuts import render
from .models import Student
from .models import Notification
from .models import test
from django.core.serializers import serialize
from .models import Teacher
from .models import Users
from .models import StudentAllocation
from .models import RoomData
from .models import TeacherAllocation
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.http import JsonResponse
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login
import json
# def userreg(request):
#     return render(request,"userreg.html",{})
# def insertuser(request):
#     uname = request.POST['name']
#     uemail = request.POST['email']
#     unumber = request.POST['number']
#     us = User(name = uname , email = uemail , number = unumber)
#     us.save()
#     return render(request,'index.html',{'user':us})

def stud_data(request):
    students = Student.objects.all()
    stud_name = students[1].name
    stud_prn = students[1].prn
    stud_department = students[1].department
    notify = Notification.objects.all()
    stud_notify = notify[0].message
    return JsonResponse({'name': stud_name , 'prn' : stud_prn , 'department': stud_department, 'notification':stud_notify })

def teach_data(request):
    teachers = Teacher.objects.all()
    teach_name = teachers[0].name
    teach_prn = teachers[0].prn
    teach_department = teachers[0].department
    notify = Notification.objects.all()
    teach_notify = notify[1].message
    return JsonResponse({'name': teach_name , 'prn' : teach_prn, 'department': teach_department, 'notification':teach_notify })
@csrf_exempt 
def save_data(request):
    
    if request.method == 'POST':
        data = request.POST.get('data')
        tst = test(msg = data)
        tst.save()
        return JsonResponse({'message': 'Data saved successfully.'})
    else:
        return JsonResponse({'message': 'Invalid request method.'}, status=400)
@csrf_exempt 
def login_view(request):
    if request.method == 'POST':
        prn = request.POST.get('username')
        password = request.POST.get('password')        
        user = Users.objects.get(prn=prn)
        if user.password == password:
            user_type = user.type  
            if user_type == 'teacher':
                teacher = Teacher.objects.get(prn=user.prn)
                teach_name = teacher.name
                teach_dep = teacher.department
                teacher_notifies = Notification.objects.filter(prn=user.prn)
                teach_notify_msgs = [notify.message for notify in teacher_notifies]
                teacher_allocations = TeacherAllocation.objects.filter(prn=user.prn)
                student_data = StudentAllocation.objects.all()
                teacher_allocations_data = []

                for allocation in teacher_allocations:
                    room_name = allocation.room_name
                    date = allocation.date.strftime('%Y-%m-%d')
                    
                    # Filter student data based on room name and date
                    filtered_student_data = student_data.filter(room_name=room_name, date=date)
                    
                    # Extract student PRN for each matching record
                    student_prns = [student.prn for student in filtered_student_data]
    
                    allocation_data = {
                        'room_name': room_name,
                        'date': date,
                        'student_prns': student_prns
                    }
                    teacher_allocations_data.append(allocation_data)
                print(teacher_allocations_data)
                data = {
                    'name': teach_name,
                    'prn': user.prn,
                    'department': teach_dep,
                    'user_type': user_type,
                    'notification': teach_notify_msgs,
                    'teacher_allocations': teacher_allocations_data
                }
                
                return JsonResponse(data)

            elif user_type == 'student':
                student = Student.objects.get(prn=user.prn)
                stud_name = student.name
                stud_dep = student.department
                student_notifies = Notification.objects.filter(prn=user.prn)
                student_allocations = StudentAllocation.objects.filter(prn=user.prn)

                # Prepare student allocation data
                student_allocations_data = []

                for allocation in student_allocations:
                    room_data = RoomData.objects.get(room_name=allocation.room_name)
                    allocation_data = {
                        'course_code': allocation.course_code,
                        'room_name': allocation.room_name,
                        'date': allocation.date.strftime('%Y-%m-%d'),
                        'student_row': allocation.student_row,
                        'student_col': allocation.student_col,
                        'room_columns': room_data.columns,
                        'room_seats': room_data.seats,
                        'room_rows': room_data.rows,
                    }
                    student_allocations_data.append(allocation_data)


                student_notify_msgs = [notify.message for notify in student_notifies]
                
                
                data = {
                    'name': stud_name,
                    'prn': user.prn,
                    'department': stud_dep,
                    'user_type': user_type,
                    'notification': student_notify_msgs,
                    'student_allocations': student_allocations_data  
                }

                return JsonResponse(data)

        else:
            return JsonResponse({'error': 'Invalid username or password'}, status=400)
    else:
        return JsonResponse({'error': 'Method not allowed'}, status=405)


