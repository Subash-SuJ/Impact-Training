class Patient:
    def __init__(self, name, age):
        self.name = name
        self.age = age
        self.__medical_history = []  # Private attribute

    def add_medical_record(self, record):
        self.__medical_history.append(record)

    def get_medical_history(self):
        return self.__medical_history

patient1 = Patient("Subash", 30)

patient1.add_medical_record("Diagnosed with Hypertension")

print(patient1.get_medical_history())

# print(patient1.__medical_history)  # Raises an AttributeError
