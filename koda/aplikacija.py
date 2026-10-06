from delo_s_podatki import nalozi_studente, zapisi_studente
from model import Student

def izpisi_studente(studenti):
    for student in studenti:
        print(student)

def najdi_studenta(studenti, ime):
    for student in studenti:
        if ime == ime:
            return student
    return "Napaka"

def prestej_po_letnikih(studenti):
    po_letnikih = {}
    for student in studenti:
        if student.program not in po_letnikih:
            po_letnikih[student.letnik] = 0
        po_letnikih[student.letnik] += 1
    return po_letnikih

def studenti_na_programu(studenti, program):
    izbrani = set()
    for student in studenti:
        if student.program == program:
            izbrani.add(student)
    return izbrani

def main():
    studenti = nalozi_studente("koda/studenti.csv")
    ime = input("Ime: ")
    program = input("Program: ")
    letnik = int(input("Letnik: "))
    stopnja = input("Stopnja: ")

    nov_student = Student(ime, program, letnik, stopnja)
    studenti.append(nov_student)

    print("Pozdravljen svet!")
    print()

    studenti_po_letnikih = prestej_po_letnikih(studenti)
    print("\n".join([f"- {letnik}: {studenti_po_letnikih}" for letnik in studenti_po_letnikih]))


    izpisi_studente(studenti)
    print(najdi_studenta(studenti, "Fani"))

    print(studenti_na_programu(studenti, "Aplikativna matematika"))




if __name__ == "__main__":
    main()