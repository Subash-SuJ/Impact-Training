num1 = int(input("Enter the starting number: "))
num2 = int(input("Enter the ending number: "))

for i in range(num1, num2 + 1):
    if i > 1:  # Prime numbers are greater than 1
        for j in range(2, int(i ** 0.5) + 1):
            if i % j == 0:  # If divisible, it's not a prime
                break
        else:
            print(i)  # Executes only if the loop didn't encounter a `break`
