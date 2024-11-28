print ("Welcome to the Shop")

print ("Choose What Membership You have (Premium or Gold or Silver or NA)")

Membership = input().strip().lower()

print ("Enter the Price:")

Price = int(input())

if (Price > 2000) and (Membership == "premium"):
    print("You can get this at", round((Price*0.8 * 0.95),2))
elif (Price < 2000) and (Membership == "premium"):
    print("You can get this at", round((Price * 0.8),2))
elif (Price > 2000) and (Membership == "gold"):
    print("You can get this at ", round((Price * 0.85),2))
elif (Price < 2000) and (Membership == "gold"):
    print("You can get this at ", round((Price * 0.85*0.95),2))
elif (Price > 2000) and (Membership == "silver"):
    print("You can get this at ",round((Price * 0.9*0.95),2))
elif (Price < 2000) and (Membership == "silver"):
    print("You can get this at ", round((Price * 0.9),2))
elif(Price > 2000):
     print("You can get this at ", round((Price * 0.95)))
else:
    print("You can get this at",Price)