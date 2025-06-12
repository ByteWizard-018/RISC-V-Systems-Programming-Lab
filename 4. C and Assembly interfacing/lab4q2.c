#include <stdio.h>
extern int reverse(char* string_1);
extern char* reverse_str[50];

int main()
{
    char* string_1 = "Hello";

    int length = reverse(string_1);
    printf("input string: %s, reverse_string: %s, length = %d\n",string_1,reverse_str,length);
}