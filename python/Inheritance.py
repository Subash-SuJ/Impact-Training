class Patient:
    def __init__(self, name, age):
        self.name = name  # Initializing 'name' attribute
        self.age = age    # Initializing 'age' attribute

class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

class Doctor(Person):
    def prescribe_medicine(self, patient, medicine):
        print(f"Dr. {self.name} prescribed {medicine} to {patient.name}")

# Create objects
doctor = Doctor("Subash", 45)
patient = Patient("Harshith", 30)

# Doctor prescribing medicine
doctor.prescribe_medicine(patient, "Paracetamol")