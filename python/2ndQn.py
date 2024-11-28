print("Welcome to Janani Pet Shop")

print("Enter when you want the pet (Urgent or Not Urgent):")

priority = input().strip().lower()

print("Weight of the Pet you want:")

Weight = int(input())

print("Enter the distance you want to dispatch: ")

Distance = int(input())

if (priority == "not urgent") & (Weight <= 5):
    print("You can take it with you in bike")
elif (priority == "not urgent") & (5 < Weight > 50) & (50 < Distance <= 250):
    print("You can avail the lorry")
elif (priority == "urgent") & (Distance < 50) & (Weight < 100):
    print("You can take the pet in Van")
else:
    print("We can despatch to this in the train")