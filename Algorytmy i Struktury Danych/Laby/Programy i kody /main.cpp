#include<iostream>

using namespace std;

enum Plec{K, M};

class Osoba {
    private:
        string imie_;
        string nazwisko_;
        float waga_;
        float wzrost_;
        int wiek_;
    protected:
        Plec plec_;
    public:
        Osoba() {}
        Osoba(string, string, float, float, int, Plec);
        ~Osoba() {};
        void wyswietlOsoba() {
            cout<<imie_<<" "<<nazwisko_<<" "<<waga_<<" "<<wzrost_<<" "<<wiek_<<" "<<plec_;
        }

        string getImie() {
            return imie_;
        }

        string getNazwisko() {
            return nazwisko_;
        }

        int getWiek() {
            return wiek_;
        }

        float BMI() {
            float pomWzrost = 0;
            if(wzrost_ > 100) {
                pomWzrost = wzrost_ * 0.01;
            }
            return waga_/(pomWzrost*pomWzrost);
        }
};

Osoba::Osoba(string imie, string nazwisko, float waga, float wzrost, int wiek, Plec plec) {
    imie_ = imie;
    nazwisko_ = nazwisko;
    waga_ = waga;
    wzrost_ = wzrost;
    wiek_ = wiek;
    plec_ = plec;
}

class Student : public Osoba {
    private:
        string nrIndex_;
        int rok_;
        double oceny_[10];
    public:
        Student() : Osoba(){
            for(int i = 0; i < 10; i++) {
                oceny_[i] = 0;
            }
        }
        Student(string, string, float, float, int, Plec, string, int, double[10]);
        ~Student() {};
        float srArm() {
            float sr = 0;
            for(int i = 0; i < 10; i++) {
                sr += oceny_[i];
            }
            sr = sr / 5;
            return sr;
        }
        int getRok() {
            return rok_;
        }

        string getNrIndex() {
            return nrIndex_;
        }


};

bool operator < (Student& a, Student& b) {
    if(a.srArm() < b.srArm()) {
        return true;
    } else {
        return false;
    }
}

Student::Student(string imie, string nazwisko, float waga, float wzrost, int wiek, Plec plec, string nrIndex, int rok, double oceny[10]): Osoba(imie, nazwisko, waga, wzrost, wiek, plec) {
    nrIndex_ = nrIndex;
    rok_ = rok;
    for(int i = 0; i < 10; i++) {
        oceny_[i] = oceny[i];
    }
}

class Pracownik : public Osoba {
    private:
        string nazFirm_;
        string stanowisko_;
        float pensja_;
        float staPrac_;
    public:
        Pracownik(string, string, float, float, int, Plec, string, string, float, float);
        ~Pracownik() {};
        float ileEmer() {
            if(plec_ == 1) {
                return 65 - getWiek();
            } else {
                return 60 - getWiek();
            }
        }
};

Pracownik::Pracownik(string imie, string nazwisko, float waga, float wzrost, int wiek, Plec plec, string nazFirm, string stanowisko, float pensja, float staPrac): Osoba(imie, nazwisko, waga, wzrost, wiek, plec) {
    nazFirm_ = nazFirm;
    stanowisko_ = stanowisko;
    pensja_ = pensja;
    staPrac_ = staPrac;
}


class Kierunek {
    private:
        string nazwa_;
        Student studenci_[5][10];
        int calcStudent_;
    public:
        Kierunek(string);

        int calcIlosc() {
            calcStudent_ = 0;
            for(int i = 0; i < 5; i++) {
                for(int j = 0; j < 10; j++) {
                    if(studenci_[i][j].getImie() != "") {
                        calcStudent_++;
                    }
                }
            }
            return calcStudent_;
        }

        void wyswietlNajlepszych(int rok) {
            for(int j = 0; j < 3; j++) {
                if(studenci_[rok - 1][j].srArm() == 0) {
                    break;
                }
                cout<<studenci_[rok - 1][j].getNrIndex()<<" "<<studenci_[rok - 1][j].getImie()<<" "<<studenci_[rok - 1][j].getNazwisko()<<" ";
            }
        }

        void usunStudenta(Student usun) {
            for(int i = 0 ; i < 10; i++) {
                if(studenci_[usun.getRok()-1][i].getNrIndex() == usun.getNrIndex()) {
                    for(int j = i; j < 9; j++) {
                        studenci_[usun.getRok()-1][j] = studenci_[usun.getRok()-1][j + 1];
                    }
                    break;
                }
            }
        }

        void sortuj(int rok) {
            for(int j = 0; j < 10; j++) {
                for(int k = 0; k < 9 - j ; k++) {
                    if(studenci_[rok-1][k] < studenci_[rok-1][k + 1]) {
                        swap(studenci_[rok-1][k], studenci_[rok-1][k + 1]);
                    }
                }
            }
        }

        bool dodajStudenta( Student dodaj) {
            for(int i = 0; i < 10; i++) {
                if(studenci_[dodaj.getRok()-1][i].getImie() == "") {
                    studenci_[dodaj.getRok()-1][i] = dodaj;
                    break;
                }
            }
            return true;
        }
};



Kierunek::Kierunek(string nazwa) {
    nazwa_ = nazwa;
    calcStudent_ = 0;
}

int main()
{
    string kierunek;
    cin>>kierunek;
    Kierunek kier(kierunek);

    string imie;
    string nazwisko;
    float waga;
    float wzrost;
    int wiek;
    char plecPom;
    Plec plec;
    string nrIndex;
    int rok;
    double oceny[10] = {0};
    int jakiRok = 0;

    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom == 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nrIndex;
    cin>>rok;

    for(int i = 0; i < 5; i++) {
        cin>>oceny[i];
    }

    Student one(imie, nazwisko, waga, wzrost, wiek, plec, nrIndex, rok, oceny);

    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom == 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nrIndex;
    cin>>rok;

    for(int i = 0; i < 5; i++) {
        cin>>oceny[i];
    }

    Student two(imie, nazwisko, waga, wzrost, wiek, plec, nrIndex, rok, oceny);

    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom == 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nrIndex;
    cin>>rok;

    for(int i = 0; i < 5; i++) {
        cin>>oceny[i];
    }

    Student three(imie, nazwisko, waga, wzrost, wiek, plec, nrIndex, rok, oceny);

    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom = 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nrIndex;
    cin>>rok;

    for(int i = 0; i < 5; i++) {
        cin>>oceny[i];
    }

    Student four(imie, nazwisko, waga, wzrost, wiek, plec, nrIndex, rok, oceny);

    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom == 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nrIndex;
    cin>>rok;

    for(int i = 0; i < 5; i++) {
        cin>>oceny[i];
    }

    Student five(imie, nazwisko, waga, wzrost, wiek, plec, nrIndex, rok, oceny);

    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom == 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nrIndex;
    cin>>rok;

    for(int i = 0; i < 5; i++) {
        cin>>oceny[i];
    }

    Student six(imie, nazwisko, waga, wzrost, wiek, plec, nrIndex, rok, oceny);

    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom == 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nrIndex;
    cin>>rok;

    for(int i = 0; i < 5; i++) {
        cin>>oceny[i];
    }

    Student seven(imie, nazwisko, waga, wzrost, wiek, plec, nrIndex, rok, oceny);

    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom == 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nrIndex;
    cin>>rok;

    for(int i = 0; i < 5; i++) {
        cin>>oceny[i];
    }

    Student eight(imie, nazwisko, waga, wzrost, wiek, plec, nrIndex, rok, oceny);

    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom == 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nrIndex;
    cin>>rok;

    for(int i = 0; i < 5; i++) {
        cin>>oceny[i];
    }

    Student nine(imie, nazwisko, waga, wzrost, wiek, plec, nrIndex, rok, oceny);

    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom = 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nrIndex;
    cin>>rok;

    for(int i = 0; i < 5; i++) {
        cin>>oceny[i];
    }

    Student ten(imie, nazwisko, waga, wzrost, wiek, plec, nrIndex, rok, oceny);


    cin>>jakiRok;

    string nazwaFirmy;
    string stanowisko;
    float pensja;
    float stazPrac;

    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom == 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nazwaFirmy;
    cin>>stanowisko;
    cin>>pensja;
    cin>>stazPrac;

    Pracownik a(imie, nazwisko, waga, wzrost, wiek, plec, nazwaFirmy, stanowisko, pensja, stazPrac);


    cin>>imie;
    cin>>nazwisko;
    cin>>waga;
    cin>>wzrost;
    cin>>wiek;

    cin>>plecPom;

    if(plecPom == 'K') {
        plec = K;
    } else {
        plec = M;
    }

    cin>>nazwaFirmy;
    cin>>stanowisko;
    cin>>pensja;
    cin>>stazPrac;

     Pracownik b(imie, nazwisko, waga, wzrost, wiek, plec, nazwaFirmy, stanowisko, pensja, stazPrac);

    kier.dodajStudenta(one);
    kier.dodajStudenta(two);
    kier.dodajStudenta(three);
    kier.dodajStudenta(four);
    kier.dodajStudenta(five);
    kier.dodajStudenta(six);
    kier.dodajStudenta(seven);
    kier.dodajStudenta(eight);
    kier.dodajStudenta(nine);
    kier.dodajStudenta(ten);



    kier.sortuj(jakiRok);
    kier.wyswietlNajlepszych(jakiRok);
    cout<<a.ileEmer()<<" "<<b.ileEmer();
    return 0;
}




















