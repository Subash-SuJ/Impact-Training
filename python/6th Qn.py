# 6. Accept a 5 digit decimal number as input and display the number in reverse order.
# (Example: if input is 12345, then output must be 54321)

number = int(input("Enter a 5-digit decimal number: "))

reversed_number = int(str(number)[::-1])

print(f"The reversed number is: {reversed_number}")
