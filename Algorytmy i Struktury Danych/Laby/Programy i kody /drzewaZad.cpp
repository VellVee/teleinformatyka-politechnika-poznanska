#include <iostream>
using namespace std;

template <class T> class Wezel{
public:
    Wezel <T> *leweDziecko;
    Wezel <T> *praweDziecko;
    T dane;
    Wezel(T inDane): dane(inDane), leweDziecko(nullptr), praweDziecko(nullptr){};
};

template <class T> class Drzewoklasa{
public:
    Wezel<T> *pierwyj;
    Drzewoklasa(): pierwyj(nullptr){};

    void add(T wartosc){
        if(pierwyj == nullptr){
            pierwyj = new Wezel<T>(wartosc);
        }
        else{
            Wezel <T> *aktualnykorzen = pierwyj;
            while(aktualnykorzen !=nullptr){
                if(wartosc >= aktualnykorzen->dane){
                    
                    if(aktualnykorzen->leweDziecko == nullptr){
                        aktualnykorzen->leweDziecko = new Wezel<T>(wartosc);
                        return;
                    }
                    aktualnykorzen = aktualnykorzen->leweDziecko;
                }
                else if(wartosc<aktualnykorzen->dane){
                    if(aktualnykorzen->praweDziecko == nullptr){
                        aktualnykorzen->praweDziecko = new Wezel<T>(wartosc);
                        return;
                    }
                    aktualnykorzen = aktualnykorzen->praweDziecko;
                }
            }
        }
    }

    int dlugaDroga(Wezel<T> *ptr){
        int wyzszy;
        if(ptr == nullptr){
            return -1;
        }
        int lewaCzesc = dlugaDroga(ptr->leweDziecko);
        int prawaCzesc = dlugaDroga(ptr->praweDziecko );
        

        if(lewaCzesc>prawaCzesc)wyzszy = lewaCzesc;
        else wyzszy = prawaCzesc;

        return wyzszy+1;
    }

    int krotkaDroga(Wezel<T> *ptr, int &najmniejszy=0, int aktualnaWys=0){
        if(ptr->leweDziecko){
            krotkaDroga(ptr->leweDziecko,najmniejszy, aktualnaWys+1);
        }
        
        if(ptr->praweDziecko)krotkaDroga(ptr->praweDziecko,najmniejszy, aktualnaWys+1);

        if(ptr->leweDziecko == nullptr and ptr->praweDziecko == nullptr){
            if(najmniejszy == 0)najmniejszy = aktualnaWys;
            else if(aktualnaWys < najmniejszy){
                najmniejszy = aktualnaWys;
            }
        }
    }

    bool szukajWystapien;

    Wezel<T> *znajdzmax(Wezel<T> *ptr){
        while(ptr->leweDziecko != nullptr)ptr = ptr->leweDziecko;
        return ptr;
    }

    Wezel<T>* remove(Wezel<T> *ptr, T wartosc){
        if(ptr == nullptr){
            szukajWystapien = false;
            return ptr;  
        }
        else if(wartosc > ptr->dane){
            ptr->leweDziecko = remove(ptr->leweDziecko, wartosc);
        }
        else if(wartosc < ptr->dane){
            ptr->praweDziecko = remove(ptr->praweDziecko, wartosc);
        }
        else if(wartosc == ptr->dane){
            
            if(ptr->leweDziecko == nullptr && ptr->praweDziecko == nullptr){
                delete ptr;
                ptr = nullptr;
            }

            else if(ptr->leweDziecko == nullptr){
                Wezel<T> *temp = ptr;
                ptr = ptr->praweDziecko;
                delete temp;
            }
            else if(ptr->praweDziecko == nullptr){
                Wezel<T> *temp = ptr;
                ptr = ptr->leweDziecko;
                delete temp;
            }
            //3: 2 dzieci
            else{
                //znajdowanie maksimum
                Wezel<T> *temp = znajdzmax(ptr->praweDziecko);
                ptr->dane = temp->dane;
                ptr->praweDziecko = remove(ptr->praweDziecko, temp->dane);
            }
        }
        return ptr;
    }

    Wezel<T>* usunPowtorki(Wezel<T> *ptr, T wartosc){

        szukajWystapien = true;
        while(szukajWystapien)remove(ptr, wartosc);	//usuwanie wystapien
    }

    void inorder(Wezel<T> *ptr){
        if(ptr){
            if(ptr->dane){
                inorder(ptr->leweDziecko);
                cout<<ptr->dane<<" ";
                inorder(ptr->praweDziecko);
            }
        }
    }

    void preorder(Wezel<T> *ptr){
        if(ptr){
            if(ptr -> dane){
                cout<<ptr->dane<<" ";
                preorder(ptr->leweDziecko);
                preorder(ptr->praweDziecko);
            }
        }
    }

    void postorder(Wezel<T> *ptr){
        if(ptr){
            if(ptr -> dane){
                postorder(ptr->leweDziecko);
                postorder(ptr->praweDziecko);
                cout<<ptr->dane<<" ";
            }
        }
    }
};

int main()
{

    Drzewoklasa<double> drzewko;
    int k, l;
    double number;

    cin>>k;
    for(int i=0; i<k; i++){
        cin>>number;
        drzewko.add(number);
    }

    Wezel<double> *root = drzewko.pierwyj;

    cin>>l;
    for(int i=0; i<l; i++){
        if(i>=k)break;//dodatek
        cin>>number;
        drzewko.usunPowtorki(root, number);
    }
	short int m=0;
    cin>>m;

    switch(m){
        case 0:
            drzewko.preorder(root);
            break;
        case 1:
            drzewko.inorder(root);
            break;
        case 2:
            drzewko.postorder(root);
            break;
        default:
            break;
    }

    cout<<drzewko.dlugaDroga(root); //longestPath
    int najmniejszy = 0;
    drzewko.krotkaDroga(root, najmniejszy);
    cout<<" "<<najmniejszy; //shortestPath:

    return 256;
}








