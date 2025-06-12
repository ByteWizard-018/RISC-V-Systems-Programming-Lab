#include <stdio.h>

char* course_name = "CS2610";

 
 
char* getcourse()
{
    return course_name;
}


void displayStudentProfile(char* first_name, char* last_name, char* coursename)
{
    printf("First Name: %s, Last Name: %s, Course: %s\n",first_name,last_name,coursename);
}
