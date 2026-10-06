from csv import DictReader, DictWriter
from model import Student

def nalozi_studente(pot):
    studenti = []
    with open(pot, encoding="utf-8") as file:
        bralec = DictReader(file)

        for vrstica in bralec:
            student = Student(
                vrstica["Ime"],
                vrstica["Program"],
                int(vrstica["Letnik"]),
                vrstica["Stopnja"],
            )
            studenti.append(student)

    return studenti


def zapisi_studente(pot, studenti):
    studenti = []
    with open(pot, "w", encoding="utf-8") as file:
        pisec = DictWriter(file, fieldnames=["Ime", "Program", "Letnik", "Stopnja"])

        pisec.writeheader()
        for student in studenti:
            pisec.writerow({"Ime": student.ime, "Program": student.program, "Letnik": student.letnik, "Stopnja": student.stopnja})

    return studenti