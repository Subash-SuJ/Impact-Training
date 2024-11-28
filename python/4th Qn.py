print("Enter the number of units used: ")
units = int(input().strip())

if units > 200 and units <= 500:
    print("You have to pay the amount", units*2,"Rupees")
elif units > 500 and units <= 1000:
    print("You have to pay the amount", units*5,"Rupees")
elif units > 1000:
    print("You have to pay the amount", units*10,"Rupees")
else:
    print("You have to pay the amount", units,"Rupees")
