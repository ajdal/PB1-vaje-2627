class Student:
    def __init__(self, ime, program, letnik, stopnja):
        self.ime = ime
        self.program = program
        self.letnik = letnik
        self.stopnja = stopnja

    def __str__(self):
        return self.ime

    def opis(self):
        raise NotImplementedError