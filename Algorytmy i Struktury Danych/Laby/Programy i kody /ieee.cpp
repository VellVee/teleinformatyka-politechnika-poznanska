#include<iostream>
#include<math.h>
#include<string>
using namespace std;

class Ieee{
        bool znak_;
        int wykl_;
        float mant_;
        float wart_;
    public:
        
        float policzWart(){                     //liczy wartosc ze skladnikow
            if(znak_){
                return (-1*(pow(2, wykl_-127)*mant_));
            }else{
                return (pow(2, wykl_-127)*mant_);
            }    
        }        
        
        void wyznacz(float wart){       //wyznacza skladniki
            znak_=0;
            int licz = 0;
        
            if(wart_<0){        //ustawia odpowiedni znak
                znak_=1;
             wart=wart*(-1);
            }
            
            if(wart==0) {
                mant_=0;
                wykl_=127;
            }
            else if(wart<1){         //tu zawsze wart>0
                while(wart<1){
                   licz++;
                   wart=wart*2;
                }
                wykl_=127-licz;
                mant_=wart;
            }else{
                while(wart>2){
                       licz++;
                     wart=wart/2;
                    }
                wykl_=127+licz;
                mant_=wart;
            }           
        }
        
        float getWart(){
            return wart_;
        }
        float getMant(){
            return mant_;
        }
        float getWykl(){
            return wykl_;
        }
        float getZnak(){
            return znak_;
        }
        
        //operator +=
        void operator +=(const Ieee &obiekt){
            wart_ = wart_ + obiekt.wart_;
            wyznacz(wart_);
            return;
        }
        
        //operator -=
        void operator -=(Ieee const &obiekt){
            wart_ = wart_ - obiekt.wart_;
            wyznacz(wart_);
            return;
        }

        friend Ieee operator+(Ieee, Ieee);
        friend Ieee operator-(Ieee, Ieee);
        
        //konstruktory
        Ieee(bool, int, float);
        Ieee(float);
        Ieee(){}
        ~Ieee(){}
        
};  //-----------------------------KONIEC KLASY---------------------------------
    
    Ieee::Ieee(bool znak, int wykl, float mant):znak_(znak), wykl_(wykl), mant_(mant){
        wart_=policzWart();
    }
    
    Ieee::Ieee(float wart):wart_(wart){   
        wyznacz(wart);      //wyznacza skladniki
    }
    
    //operator <<
    ostream & operator<<(ostream & s, Ieee & toDisplay){
        return s << toDisplay.getWart();
    }
    
    //operator +
    Ieee operator+(Ieee a1, Ieee a2){
        Ieee suma;
        suma.wart_ = a1.wart_ + a2.wart_;
        suma.wyznacz(suma.wart_);
        return suma;
    }
    
    //operator -
    Ieee operator-(Ieee a1, Ieee a2){
        Ieee roznica;
        roznica.wart_ = a1.wart_ - a2.wart_;
        roznica.wyznacz(roznica.wart_);
        return roznica;
    }
    
bool getBool(){         //sprawdzanie poprawnosci wpisania boola
    string temp;
    
    while(true){
        cin>>temp;
        if(temp.size()==1){
            if(temp[0]=='-'){
              return 1;
            }else
            if(temp[0]=='+'){
                return 0;
            }
        }
    }
}
    
int getInt(){           //sprawdzanie poprawnosci wpisania inta
    string temp;
    int doInta;
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
        if(flaga == true){
            break;
        }
    }
        doInta = atoi(temp.c_str());
        return doInta;
}    
    
float getFloatR(){      //float jako mantysa
    string temp;
    bool flaga = true;
    float doMantysy;

    while(true){
        cin>>temp;
        flaga = true;
        for(int i=0; i<temp.size(); i++){
            if(!isdigit(temp[i]) && temp[i]!='.'){
                flaga = false;
                break;
            }
        }
        if(flaga == true){
            doMantysy = stof(temp);
            if(doMantysy<2 && doMantysy>=0){
                break;
            }
        }
    }
        return doMantysy;
}    

float getFloatF(){      //float jako wartosc calosci
    string temp;
    bool flaga = true;
    float doWartosci;
    
    while(true){
        cin>>temp;
        flaga = true;
        for(int i=0; i<temp.size(); i++){
            if(!isdigit(temp[i]) && temp[i]!='.'&& (temp[i]!='-') && (temp[i]!='+')){
                flaga = false;
                break;
            }
        }
        if(flaga == true){
            doWartosci = stof(temp);
            break;
        }
    }
        return doWartosci;
}    
//-------------------------------MAIN-------------------------------------------
int main(){
    bool inBool;
    int inInt;
    float inFloat;            

    //pobierz dwie liczby x0, x1 za pomoca znaku, wykladnika i mantysy
    inBool=getBool();
    inInt=getInt();
    inFloat=getFloatR();
    Ieee x0(inBool, inInt, inFloat);
    
    inBool=getBool();
    inInt=getInt();
    inFloat=getFloatR();
    Ieee x1(inBool, inInt, inFloat);
    
    //pobierz dwie liczby x2, x3 jako floaty
    inFloat=getFloatF();
    Ieee x2(inFloat);
    
    inFloat=getFloatF();
    Ieee x3(inFloat);
    
    //dodaj x1 do x0,   odejmij x2 od x3
    x0 += x1;
    x3 -= x2;
    
    //utworz     x4 = x1 + x3,      utworz   x5 = x4 - x2   
    Ieee x4;
    x4 = x1 + x3;
    Ieee x5;
    x5 = x4 - x2;
    
    //wyswietl x0 do x5 
    cout<<x0<<" "<<x1<<" "<<x2<<" "<<x3<<" "<<x4<<" "<<x5;
    
    return 0;
}