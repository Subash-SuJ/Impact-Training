class HospitalManagementSystem:
    def generate_invoice(self, patient, services):
        return f"Invoice for {patient.name}: {sum(services.values())}"

class Patient:
    def __init__(self, name):
        self.name = name

patient = Patient("Saran")

services = {"Consultation": 200, "X-ray": 150, "Blood Test": 100}

hms = HospitalManagementSystem()

invoice = hms.generate_invoice(patient, services)
print(invoice)