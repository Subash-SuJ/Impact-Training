class Patient:
    def get_details(self):
        return "Patient Details: Name, Age, Medical History"

class Doctor:
    def get_details(self):
        return "Doctor Details: Name, Age, Specialization"

def print_details(person):
    print(person.get_details())

patient = Patient()

doctor = Doctor()

print_details(patient)
print_details(doctor)

