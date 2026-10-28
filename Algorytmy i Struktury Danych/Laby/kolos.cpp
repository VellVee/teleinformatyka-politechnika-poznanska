#include <iostream>
#include <string>
using namespace std;

class Vehicle{                      //klasa pojazd
    private:
        float waga_;
        int ileKol_;
    public:
        float getWaga(){
            return waga_;
        }
        Vehicle(){
            waga_=0;
            ileKol_=0;
        }
        Vehicle(float w, int k) : waga_(w), ileKol_(k){}
        ~Vehicle(){}
};

class Car : public Vehicle{         //klasa samochod
    private:
        string label_;
        int moc_;
        int dlug_;
    public:
        int getMoc(){
            return moc_;
        }
        Car():Vehicle(){
            label_="";
            moc_=0;
            dlug_=0;
        }
        Car(string l, int m, int d, int w, int k) : Vehicle(w, k),
            label_(l), moc_(m), dlug_(d){}
        
};

bool operator < (Car c1, Car c2){       //operator porownania
    if(c1.getMoc() > c2.getMoc()){ //jesli ma wieksza moc to "caly" jest mniejszy
        return true;
    }else if(c1.getMoc() == c2.getMoc()){
        if(c1.getWaga() < c2.getWaga()){
            return true;
        }
    }else return false;
}

ostream & operator << (ostream & s, Car &c0){ //ostream przeladowany
    return s << c0.getMoc() <<" "<< c0.getWaga() <<" "; 
} 

class Katalog{  
    private:
        Car maluch[20];
        int licznik_;
        
    public:
        void dodaj(Car toAdd){
            if(licznik_<20){
                maluch[licznik_]=toAdd;
                licznik_++;
            }
        }
        
        void dispAll(){
            for (int i=0; i<licznik_; i++){
                cout<<maluch[i]<<" ";
            }
        }
        
        void sortuj(){
            for(int i=0; i<licznik_; i++){
                int index = i;
                for(int j=i+1; j<licznik_; j++){
                    if (maluch[j] < maluch[index]){
                        index = j;
                    }
                    swap(maluch[i], maluch[index]);
                }
            }
        }
        Katalog(){
            licznik_=0;
            for(int i=0; i<20; i++){
                maluch[i] = {Car()};
            }
        }
};





//-----------------------------------MAIN---------------------------------------
int main()
{
    int kola, moc, dlugosc;  
    float waga;
    string rejestracja;
    
    Katalog kot;
    
    cin>>waga>>kola>>rejestracja>>moc>>dlugosc;
    Car polonez1(rejestracja, moc, dlugosc, waga, kola);
    
    cin>>waga>>kola>>rejestracja>>moc>>dlugosc;
    Car polonez2(rejestracja, moc, dlugosc, waga, kola);
    
    cin>>waga>>kola>>rejestracja>>moc>>dlugosc;
    Car polonez3(rejestracja, moc, dlugosc, waga, kola);
    
    cin>>waga>>kola>>rejestracja>>moc>>dlugosc;
    Car polonez4(rejestracja, moc, dlugosc, waga, kola);
    
    cin>>waga>>kola>>rejestracja>>moc>>dlugosc;
    Car polonez5(rejestracja, moc, dlugosc, waga, kola);
    
    cin>>waga>>kola>>rejestracja>>moc>>dlugosc;
    Car polonez6(rejestracja, moc, dlugosc, waga, kola);
    
    kot.dispAll();
    
    
    return 0;
}