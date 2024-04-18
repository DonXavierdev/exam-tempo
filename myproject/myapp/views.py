from django.shortcuts import render
from django.db import connection
from django.core.serializers import serialize
from datetime import datetime
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.http import JsonResponse
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login
import json

def get_all_data(query, db_alias='default'):
    with connection.cursor() as cursor:
        cursor.execute(query)
        rows = cursor.fetchall()
    return rows


@csrf_exempt 
def login_view(request):
    if request.method == 'POST':
        user_id = request.POST.get('username')
        password = request.POST.get('password')    
        query = f"SELECT * FROM users WHERE user_id = '{user_id}'"    
        rows = get_all_data(query)
        if rows[0][1] == password:
            user_type = rows[0][2]  
            if user_type == 'Teacher':
                query = f"SELECT * FROM teachers WHERE teacher_id = '{user_id}'"
                teacher = get_all_data(query)
                teach_name = teacher[0][1]
                teach_dep = teacher[0][2]
                query = f"SELECT content FROM teacher_notifications WHERE teacher_id = '{user_id}'"
                teacher_notifies = get_all_data(query)            
                query = f"SELECT * FROM teacher_allocations WHERE teacher_id = '{user_id}'"
                teacher_allocations = get_all_data(query)
                
                # student_data = StudentAllocation.objects.all()
                teacher_allocations_data = []
                
                
                for allocation in teacher_allocations:
                    query = f"SELECT * FROM rooms WHERE room_id = '{allocation[4]}'"
                    room_data = get_all_data(query)                    
                    
                    # Filter student data based on room name and date
                    # filtered_student_data = student_data.filter(room_name=room_name, date=date)
                    
                    # Extract student PRN for each matching record
                    # student_prns = [student.prn for student in filtered_student_data]
    
                    allocation_data = {
                        'room_name': room_data[0][1],
                        'date': datetime.strptime(allocation[2], "%d/%m/%Y").strftime("%Y-%m-%d"),
                        'student_prns': ['210021027643','210021027641','210021027642','210021027640','210021027639','210021027637','210021027635','210021027636','210021027638']
                    }
                    teacher_allocations_data.append(allocation_data)
                teacher_notify_msgs = [notify[0] for notify in teacher_notifies]
                data = {
                    'name': teach_name,
                    'prn': user_id,
                    'department': teach_dep,
                    'user_type': user_type,
                    'notification': teacher_notify_msgs,
                    'teacher_allocations': teacher_allocations_data
                }
                print(data)
                return JsonResponse(data)

            elif user_type == 'Student':
    
                query = f"SELECT * FROM students WHERE prn = '{user_id}'"
                student = get_all_data(query)
                stud_name = student[0][1]
                stud_dep = student[0][3]
                query = f"SELECT content FROM student_notifications WHERE prn = '{user_id}'"
                student_notifies = get_all_data(query)
                query = f"SELECT * FROM student_allocations WHERE prn = '{user_id}'"
                student_allocations = get_all_data(query)
                student_allocations_data = []

                for allocation in student_allocations:
                    query = f"SELECT * FROM rooms WHERE room_id = '{allocation[6]}'"
                    room_data = get_all_data(query)
                    query = f"SELECT * FROM room_classes WHERE room_class_id = '{room_data[0][2]}'"
                    class_data = get_all_data(query)
                    
                    allocation_data = {
                        'course_code': allocation[3],
                        'room_name': room_data[0][1],
                        'date': datetime.strptime(allocation[2], "%d/%m/%Y").strftime("%Y-%m-%d"),
                        'student_row': allocation[7],
                        'student_col': allocation[8],
                        'room_columns': class_data[0][3],
                        'room_seats': class_data[0][2],
                        'room_rows': class_data[0][4],
                    }
                    student_allocations_data.append(allocation_data)
                student_notify_msgs = [notify[0] for notify in student_notifies]
                data = {
                    'name': stud_name,
                    'prn': user_id,
                    'department': stud_dep,
                    'user_type': user_type,
                    'notification': student_notify_msgs,
                    'student_allocations':student_allocations_data
                }
                print(data)
                return JsonResponse(data)

        else:
            return JsonResponse({'error': 'Invalid username or password'}, status=400)
    else:
        return JsonResponse({'error': 'Method not allowed'}, status=405)


