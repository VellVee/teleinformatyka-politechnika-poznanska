#include<iostream>
#include<string>
#include<stdio.h>
#include<stdlib.h>

using namespace std;

class Car{
    string plate_;
    int moc_;
    double waga_;
    char silnik_;
    
    public:
        
    string getPlate(){
        return plate_;
    }
        
    int getMoc(){           
        return moc_;        
    }
    
    void modPlate(){
        while(true){
//            cout<<"podaj rejestr"<<endl;                                       //to
            cin>>plate_;
                if(plate_.size()==4){                        
                    if(isalpha(plate_[0]) || isdigit(plate_[0])){
                        if(isalpha(plate_[1]) || isdigit(plate_[1])){
                            if(isalpha(plate_[2]) || isdigit(plate_[2])){
                                if(isalpha(plate_[3]) || isdigit(plate_[3])){
                                    break;  //jesli warunki spelnione to konczy funkcje
//                                    cout<<"wpisao platea: "<<plate_<<endl;  //to
                                }
                            }
                        } 
                    }
                }
            }
      }   //koniec funkcji
        
    void modMoc(){
        
        string temp;
        bool flaga=true;
        
        while(true){
//            cout<<"podaj moc"<<endl;                            //to
            cin>>temp;
            for(int i=0; i<temp.size(); i++){
                flaga=true;
                if(!isdigit(temp[i])){
                    flaga=false;
                    break;
                }
            }
            if(flaga==true){
                break;
            }
        }
        moc_ = atoi(temp.c_str());
//        cout<<"wpisano moc:"<<moc_<<endl;                           //to
    }
        
    void modWaga(){
        string temp;
        bool flaga=true;
        while(true){
//            cout<<"podaj wage"<<endl;                           //to
            cin>>temp;
            for(int i=0; i<temp.size(); i++){
                flaga=true;
                if(!isdigit(temp[i]) && temp[i]!='.'){
                    flaga=false;
                    break;
                }
            }
            if(flaga==true){                    
                break;
            }
        }
        waga_ = stod(temp);
//        cout<<"wpisano wage:"<<waga_<<endl;                         //to
    }   
        
    void modSilnik(){
        string temp;
        while(true){
//            cout<<"jaki mamy silnik?"<<endl;                         //to
            cin>>temp;
            if(temp.size()==1){
                if(temp=="B" || temp=="D" || temp=="E" || temp=="H"){
                    silnik_=temp[0];
                    break;
//                    cout<<"mamy silnik: "<<silnik_<<endl;                //to
                }   
            }
        }
    }    
    
    Car(){}
    Car(string, int, double, char);
    ~Car(){}
};

    Car::Car(string plate, int moc, double waga, char silnik)
    :plate_(plate), moc_(moc), waga_(waga), silnik_(silnik){}

///////////////////////////koniec klasy samochodowej////////////////////////////

class Catalog{
    int licznik_;
    int element_;
    
    public:
        static const int HEAP_MAX_=6;
        Car Cat_[HEAP_MAX_+1];
        Car CatSrodek_[HEAP_MAX_+1];
        Car CatKoniec_[HEAP_MAX_+1];
        
        Car min(){
            return CatKoniec_[1];
        } 
        
        bool dodajDoCat(Car doDodania);
        bool wklad(Car doDodania);
        
        int minChild(int parent);
        void remove();
        void heapSort();
        void wyswietlCat();
        
        
        Catalog(){
            element_=0;
            licznik_=0;
        }
        ~Catalog(){}
    
};

    bool Catalog::dodajDoCat(Car doDodania){
        if(element_<HEAP_MAX_){
            Cat_[element_]=doDodania;
            element_++;
            return true;
        }else{
            return false;
        }
    }

    bool Catalog::wklad(Car doDodania){
        licznik_++;
        int child = licznik_;
        int parent = child/2;
        
        while(parent && CatSrodek_[parent].getMoc() > doDodania.getMoc()){
            CatSrodek_[child] = CatSrodek_[parent];
            child = parent;
            parent = child/2;
        }
        CatSrodek_[child]=doDodania;
    }

    int Catalog::minChild(int parent){
        int leftChild = parent << 1;
        int rightChild = leftChild+1;
        
        if(leftChild>licznik_){
            return 0;
        }
        
        if((rightChild > licznik_) || (CatSrodek_[leftChild].getMoc()) < CatSrodek_[rightChild].getMoc()){
            return leftChild;
        }
        return rightChild;
    }
    
    void Catalog::remove(){
        Car last = CatSrodek_[licznik_--];
        int i=1;
        int j= minChild(1);
        
        while(j && (CatSrodek_[j].getMoc() < last.getMoc())){
            CatSrodek_[i] = CatSrodek_[j];
            i = j;
            j = minChild(j);
        }
        CatSrodek_[i] = last;
    }
    
    void Catalog::heapSort(){
        for(int i=0; i<element_; i++){
            wklad(Cat_[i]);
        }
        for(int i=1; i<=element_; i++){
            CatKoniec_[i] = min();
            remove();
        }
    }
    
    void Catalog::wyswietlCat(){
        heapSort();
        for(int i = 1; i <= element_; i++){
            cout<<CatKoniec_[i].getPlate()<<" "<<CatKoniec_[i].getMoc()<<" ";
        }
    }
    

///////////////////////////////MAIN///////////////////////////////////
int main()
{
    
    Car vehicle[6];
    Catalog katalog;
    
    for(int i=0; i<6; i++){     //tablica, moc, waga, silnik
        vehicle[i].modPlate();
        vehicle[i].modMoc();
        vehicle[i].modWaga();
        vehicle[i].modSilnik();
        
 /*       cout<<" samochod o nr: "<<i+1<<endl;                         
        cout<<" rejestracja: "<<vehicle[i].getPlate();
        cout<<" oto moc: "<<vehicle[i].getMoc();
        cout<<" oto waga: "<<vehicle[i].getWaga();
        cout<<" oto silnik: "<<vehicle[i].getSilnik()<<endl;             */
    }
    
    for(int i=0; i<6; i++){
        katalog.dodajDoCat(vehicle[i]);
    }
    
    katalog.wyswietlCat();
    
    return 0;
}