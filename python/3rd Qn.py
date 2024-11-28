
passport = input("Do you have a passport? (yes/no): ").strip().lower()
if passport == "yes":
    communication = input("How is your communication skill? (good/average/poor): ").strip().lower()
    if communication == "good":
        pass
    elif communication == "average":
        print("Proceeding, but please prepare well to improve communication.")
    else:
        print("Not Eligible for On-site: Communication not good.")
        exit()

    feedback = input("How is your training feedback? (good/average/poor): ").strip().lower()
    if feedback == "good":
        experience = int(input("How many years of experience do you have? (enter a number): ").strip())
        if experience >= 2:
            age = int(input("What is your age? (enter a number): ").strip())
            if age >= 23:
                print("Eligible for On-site")
            else:
                print("Not Eligible for On-site: Age less than 23.")
        else:
            print("Not Eligible for On-site: Less than 2 years of experience.")
    else:
        print("Not Eligible for On-site: Training feedback not good.")
else:
    print("Not Eligible for On-site: No passport.")



