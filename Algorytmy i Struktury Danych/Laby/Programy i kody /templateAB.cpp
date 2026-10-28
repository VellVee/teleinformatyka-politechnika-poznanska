#include <iostream>
#include <string>
using namespace std;
//-------------------------------klasa Animal-----------------------------------
class Animal{
        string name_;
        float weight_;
        int year_;
        string label_;
    public:
        Animal(string n, float w, int y, string l)
        :name_(n), weight_(w), year_(y), label_(l){
        }
        Animal(){}
        
        void display(){
            cout<<name_<<" "<<weight_<<" "<<year_<<" "<<label_<<" ";
        }
        
        int getAge(){
            return (2019-year_);
        }
        
        float getWeight(){
            return weight_;
        }
        
        void reset(){
            name_="";
            weight_=0;
            year_=0;
            label_="";
        }
};
//-------------------------------klasa Building---------------------------------
class Building{
        string name_;
        float xGPS_;
        float yGPS_;
        float height_;
    public:
        Building(string n, float x, float y, float h)
        :name_(n), xGPS_(x), yGPS_(y), height_(h){
        }
        
        void display(){
            cout<<name_<<" "<<xGPS_<<" "<<yGPS_<<" "<<height_<<" ";
        }
        
        float getGPS(){
            return (xGPS_ + yGPS_);
        }
        
        void reset(){
            name_="";
            xGPS_=0;
            yGPS_=0;
            height_=0;
        }
        Building(){}
};
//----------------------------Wzorzec klasy Umbrella----------------------------
template <class Item> class Umbrella{
        Item array_[6];
        int counter_;
    public:
        bool addItem(Item toAdd){
            if(counter_<6){
                array_[counter_]=toAdd;
                counter_++;
                return true; //true jesli doda
            }
            return false; //false jesli nie doda
        }
        
        bool deleteItem(int x){     //funkcja usuwajaca obiekt
            if(counter_==0){
                return false;               //false jesli tablica pusta
            }else{
                array_[x]=array_[counter_-1];
                array_[counter_-1].reset();
            }
            counter_--;
            return true;                    //true po usunieciu obiektu
        }
    
        Umbrella(){ 
            counter_=0;
        }  
        
        void zadanie6Ani(){ //sortuje i wyswietla zwierzeta rosnaco wiekiem (waga if equal) 
            int ilosc = counter_;
            int indexMax = 0;
            
            for(int i=0; i<ilosc-1; i++){
                indexMax = i;
                for(int j=i+1; j<ilosc; j++){
                    if(array_[j].getAge() > array_[indexMax].getAge()){
                        indexMax = j;
                    }else if(array_[j].getAge() == array_[indexMax].getAge()){
                                if(array_[j].getWeight() > array_[indexMax].getWeight()){
                                    indexMax = j;
                                }
                        }
                    swap(array_[indexMax], array_[i]);
                }
            }
            
            for(int i=(ilosc-1); i>=0; i--){     
                array_[i].display();
            }
        }
        
        void zadanie6Bui(){     //sortuje i wyswietla budynki rosnaco x+y
            int ilosc = counter_;
            int indexMax = 0;
            
            for(int i=0; i<ilosc-1; i++){
                indexMax = i;
                for(int j=i+1; j<ilosc; j++){
                    if(array_[j].getGPS() > array_[indexMax].getGPS()){
                        indexMax = j;
                    }
                    swap(array_[indexMax], array_[i]);
                }
            }
            for(int i=(ilosc-1); i>=0; i--){     
                array_[i].display();
            }
        }
};
//-----------------------------WALIDACJA_DANYCH---------------------------------
int getInt(){
    string temp;
    bool flaga = true;
    while(true){
        cin>>temp;
        for(int i=0; i<temp.size(); i++){
            flaga = true;
            if(!isdigit(temp[i])){
                flaga = false;
                break;
            }
        }
        if(flaga == true && stoi(temp)>=0){
            break;
        }
    }
        return stoi(temp);
}

float getFloat(){
    string temp;
    bool flaga = true;
    while(true){
        cin>>temp;
        for(int i=0; i<temp.size(); i++){
            flaga = true;
            if(!isdigit(temp[i]) && temp[i]!='.' && temp[i]!='-'){
                flaga = false;
                break;
            }
        }
        if(flaga == true){
            break;
        }
    }
    return stof(temp);
}

string getString(){
    string temp;
    bool flaga;
    while(true){
        cin>>temp;
        for(int i=0; i<temp.size(); i++){
            flaga = true;
            if(temp[i]==' '){
                flaga = false;
                break;
            }
        }
        if(flaga == true){
            break;
        }
    }
    return temp;
}
//----------------------------------MAIN----------------------------------------
int main(){
    
    Umbrella <Animal> zwierzaki;        //tworzenie pojemikow
    Umbrella <Building> domy;
    
    string s1;
    string s2;
    float f1;
    float f2;
    float f3;
    int i1;
    
    s1=getString();                     //tworzenie obiektow klasy Animal
    f1=getFloat();
    i1=getInt();
    s2=getString();
    Animal a1(s1, f1, i1, s2);
    
    s1=getString();
    f1=getFloat();
    i1=getInt();
    s2=getString();
    Animal a2(s1, f1, i1, s2);
    
    s1=getString();
    f1=getFloat();
    i1=getInt();
    s2=getString();
    Animal a3(s1, f1, i1, s2);
    
    s1=getString();
    f1=getFloat();
    i1=getInt();
    s2=getString();
    Animal a4(s1, f1, i1, s2);
    
    s1=getString();                     //tworzenie obiektow klasy Building
    f1=getFloat();
    f2=getFloat();
    f3=getFloat();
    Building b1(s1, f1, f2, f3);
    
    s1=getString();
    f1=getFloat();
    f2=getFloat();
    f3=getFloat();
    Building b2(s1, f1, f2, f3);
    
    s1=getString();
    f1=getFloat();
    f2=getFloat();
    f3=getFloat();
    Building b3(s1, f1, f2, f3);
    
    s1=getString();
    f1=getFloat();
    f2=getFloat();
    f3=getFloat();
    Building b4(s1, f1, f2, f3);
    
    zwierzaki.addItem(a1);              //dodawanie obiektow do pojemnika
    zwierzaki.addItem(a2);
    zwierzaki.addItem(a3);
    zwierzaki.addItem(a4);
    
    domy.addItem(b1);              
    domy.addItem(b2);
    domy.addItem(b3);
    domy.addItem(b4);
    
    while(true){                    
        i1 = getInt();
        if(i1<6 && i1>=0){
            break;
        }
    }
    zwierzaki.deleteItem(i1);       //usuwanie obiektu klasy Animal z pojemnika
    
    zwierzaki.zadanie6Ani();        //sortowanie + wyswietlenie
    domy.zadanie6Bui(); 

    return 0;
}