class Student:
    def __init__(self, ime, program, letnik):
        self.ime = ime
        self.program = program
        self.letnik = letnik

    def __str__(self):
        return self.ime

    def opis(self):
        raise NotImplementedError