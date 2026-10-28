#include<iostream>
#include<string>
using namespace std;

enum gender {K, M};

class Person{
    private:
        string imie_;
        string nazwisko_;
        float waga_;
        float wzrost_;
        int wiek_;
    protected:
        gender plec_;
    public:
        Person(){}
        Person(string i, string n, float wa, float wz, int wi, gender p):
        imie_(i), nazwisko_(n), waga_(wa), wzrost_(wz), wiek_(wi), plec_(p) {}

        void displayPerson(){   //plec sie wyswietli jako 0 (K) lub 1 (M)
            cout<<imie_<<' '<<nazwisko_<<' '<<waga_<<' '<<wzrost_<<' '<<wiek_<<' '<<plec_<<endl;
        }
        float calcBMI(){
            return (waga_/((wzrost_/100)*(wzrost_/100)));
        }
        int getWiek(){
            return wiek_;
        }
        string getImie(){
            return imie_;
        }
        string getNazwisko(){
            return nazwisko_;
        }
};


class Student : public Person{
    private:
        string index_;
        int rok_;
        double oceny_[10];
    public:
        Student() : Person(){
            for(int i=0; i<10; i++){
                oceny_[i]=0;
            }
        }
        Student(string i, string n, float wa, float wz, int wi, gender p, string ix, int r, double o[10]):
        Person(i, n, wa, wz, wi, p){
            index_=ix;
            rok_=r;
            for(int i=0; i<10; i++){
                oceny_[i]=o[i];
            }
        }
        string getIndex(){
            return index_;
        }
        int getRok(){
            return rok_;
        }
        double srednia(){           //policz srednia ocen  studenta
            double sumaOcen=0;
            int ileOcen=0;
            for(int i=0; i<10; i++){
                if(oceny_[i]==0){ //Musisz to przerobiæ ¿eby te inne œrednie nie by³o -nan i wtedy powinno dzia³aæ
                    break;
                }
                sumaOcen+=oceny_[i];
                ileOcen++;

            }
            return (sumaOcen/ileOcen);
        }
};

class Worker : public Person{
    private:
        string nazwaFirmy_;
        string stanowisko_;
        float wynagrodzenie_;
        float staz_;
    public:
        float emerytura(){              //policz ile zostalo lat do emerytury
            if(plec_==K){
                return (60-getWiek());
            }else return (65-getWiek());
        }

        Worker(string i, string n, float wa, float wz, int wi, gender p, string nF, string stan, float wyn, float sta):
        Person(i, n, wa, wz, wi, p){
            nazwaFirmy_=nF;
            stanowisko_=stan;
            wynagrodzenie_=wyn;
            staz_=sta;
        }
};

bool operator< (Student& s1, Student& s2){      //przeladowanie operatora <
    if(s1.srednia()<s1.srednia()){
        return true;
    }else{
        return false;
    }
}

class Direction{
    private:
        string nazwa_;
        Student spis_[5][10];
        int ileStudentow_;
    public:
        void policzStudentow(){                      //ile studentow na kierunku
            ileStudentow_=0;
            for(int i=0; i<5; i++){
                for(int j=0; j<10; i++){
                    if(spis_[i][j].getImie()!=""){
                        ileStudentow_++;
                    }
                }
            }
        }

        bool dodajStudenta(Student toAdd){         //dodawanie studenta do listy
            for(int i=0; i<10; i++){
                if(spis_[toAdd.getRok()-1][i].getImie()==""){
                    spis_[toAdd.getRok()-1][i]=toAdd;
                    break;
                }
            }
            return true;
        }

        bool usunStudenta(Student toDelete){        //usuwanie studenta ze spisu
            for(int i=0; i<10; i++){
                if(spis_[toDelete.getRok()-1][i].getIndex()==toDelete.getIndex()){
                    for(int j=i; j<9; j++){
                        spis_[toDelete.getRok()-1][j]=spis_[toDelete.getRok()-1][j+1];
                    }
                    return true;
                }
            }
            return false;//false jesli nie znalezniono takiego studenta w spisie
        }

        void poka() {
            for(int i = 0; i < 5; i++) {
                for(int j = 0; j < 10; j++) {
                    cout<<spis_[i][j].srednia()<<" ";
                }
                cout<<endl;
            }
        }

        void sortujStudentow(int year){   //sortowanie studentow wedlug sredniej
            for(int i=0; i<10; i++){
                for(int j=0; i<9-j; j++){
                    if(spis_[year-1][j]<spis_[year-1][j+1]){
                        swap(spis_[year-1][j], spis_[year-1][j+1]);
                    }
                }
            }
        }

        void pokaz3best(int year){    //wyswietl 3 studentow z najlepsza srednia
            // sortujStudentow(year);

            for(int i=0; i<3; i++){
                if(spis_[year-1][i].srednia()==0){
                    break;
                }
                cout<<spis_[year-1][i].getIndex()<<" "<<spis_[year-1][i].getImie()
                <<" "<<spis_[year-1][i].getNazwisko()<<" ";
            }
        }

        Direction(string na){
            nazwa_=na;
            ileStudentow_=0;
        }
};

int main(){
    string name;
    string surname;
    string company;
    string job;
    string index;
    string fieldOfStudy;

    float weight;
    float height;
    float salary;
    float seniority;

    int age;
    int year;

    gender gen;
    char znakP;

    double grades[10] = {0};

    cin>>fieldOfStudy;
    Direction kierunek(fieldOfStudy);


//---------------------tworzenie obietkow klasy Student-------------------------
    cin>>name>>surname>>weight>>height>>age>>znakP>>index>>year;
    if (znakP=='K') {gen = K;} else {gen = M;}
    for(int i=0; i<5; i++){
        cin>>grades[i];
    }
    Student x0(name, surname, weight, height, age, gen, index, year, grades);

    cin>>name>>surname>>weight>>height>>age>>znakP>>index>>year;
    if (znakP=='K') {gen = K;} else {gen = M;}
    for(int i=0; i<5; i++){
        cin>>grades[i];
    }
    Student x1(name, surname, weight, height, age, gen, index, year, grades);

    cin>>name>>surname>>weight>>height>>age>>znakP>>index>>year;
    if (znakP=='K') {gen = K;} else {gen = M;}
    for(int i=0; i<5; i++){
        cin>>grades[i];
    }
    Student x2(name, surname, weight, height, age, gen, index, year, grades);

    cin>>name>>surname>>weight>>height>>age>>znakP>>index>>year;
    if (znakP=='K') {gen = K;} else {gen = M;}
    for(int i=0; i<5; i++){
        cin>>grades[i];
    }
    Student x3(name, surname, weight, height, age, gen, index, year, grades);

    cin>>name>>surname>>weight>>height>>age>>znakP>>index>>year;
    if (znakP=='K') {gen = K;} else {gen = M;}
    for(int i=0; i<5; i++){
        cin>>grades[i];
    }
    Student x4(name, surname, weight, height, age, gen, index, year, grades);

    cin>>name>>surname>>weight>>height>>age>>znakP>>index>>year;
    if (znakP=='K') {gen = K;} else {gen = M;}
    for(int i=0; i<5; i++){
        cin>>grades[i];
    }
    Student x5(name, surname, weight, height, age, gen, index, year, grades);

    cin>>name>>surname>>weight>>height>>age>>znakP>>index>>year;
    if (znakP=='K') {gen = K;} else {gen = M;}
    for(int i=0; i<5; i++){
        cin>>grades[i];
    }
    Student x6(name, surname, weight, height, age, gen, index, year, grades);

    cin>>name>>surname>>weight>>height>>age>>znakP>>index>>year;
    if (znakP=='K') {gen = K;} else {gen = M;}
    for(int i=0; i<5; i++){
        cin>>grades[i];
    }
    Student x7(name, surname, weight, height, age, gen, index, year, grades);

    cin>>name>>surname>>weight>>height>>age>>znakP>>index>>year;
    if (znakP=='K') {gen = K;} else {gen = M;}
    for(int i=0; i<5; i++){
        cin>>grades[i];
    }
    Student x8(name, surname, weight, height, age, gen, index, year, grades);

    cin>>name>>surname>>weight>>height>>age>>znakP>>index>>year;
    if (znakP=='K') {gen = K;} else {gen = M;}
    for(int i=0; i<5; i++){
        cin>>grades[i];
    }
    Student x9(name, surname, weight, height, age, gen, index, year, grades);
//----------------------koniec tworzenia obiektow klasy Student-----------------

    cin>>year;

//--------------------------tworzenie obiektow klasy Worker---------------------
    cin>>name>>surname>>weight>>height>>age>>znakP>>company>>job>>salary>>seniority;
    if (znakP=='K') {gen = K;} else {gen = M;}
    Worker z1(name, surname, weight, height, age, gen, company, job, salary, seniority);

    cin>>name>>surname>>weight>>height>>age>>znakP>>company>>job>>salary>>seniority;
    if (znakP=='K') {gen = K;} else {gen = M;}
    Worker z2(name, surname, weight, height, age, gen, company, job, salary, seniority);
//----------------------koniec tworzenia obiektow klasy Worker------------------

    kierunek.dodajStudenta(x0);
    kierunek.dodajStudenta(x1);
    kierunek.dodajStudenta(x2);
    kierunek.dodajStudenta(x3);
    kierunek.dodajStudenta(x4);
    kierunek.dodajStudenta(x5);
    kierunek.dodajStudenta(x6);
    kierunek.dodajStudenta(x7);
    kierunek.dodajStudenta(x8);
    kierunek.dodajStudenta(x9);

    //cout<<"dodales studentow, teraz sortowanie:"<<endl;

    kierunek.sortujStudentow(year);

    kierunek.poka();

    //cout<<"posortowani"<<endl;

    kierunek.pokaz3best(year);

    cout<<z1.emerytura()<<" "<<z2.emerytura();

    return 0;
}
