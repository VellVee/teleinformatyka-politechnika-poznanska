#include <iostream>
#include <cassert>
#include <string>
using namespace std;

template <class T> class Link;

// ======================================================================
//                    Class Template List
// ======================================================================
template <class T>
class List {
protected:
    Link <T> *first;                // data field

public:
    List() : first(nullptr) {}      // default constructor
    List(const List &source);       // copy constructor
    virtual ~List() {};                // destructor

    virtual void add(T value);      // insert a new item
    virtual void deleteAll();
    T firstElement() const;        // access the first item
    virtual bool includes(T value) const;  // inclusion test
    bool isEmpty() const;
    virtual void removeFirst();
};
// ======================================================================
//                    Class Template Link
// ======================================================================
template <class T>
class Link {
private:
    T value;
    Link <T> *next;

    Link(T val, Link *ptr) : value(val), next(ptr) { }
public:
    Link <T> *insert(T value);      // after current Link

    friend class List <T>;
};

// ======================================================================
//                    Class Template DoubleEnded List
// ======================================================================

template <class T>
class DoubleEnded : public List<T> {
public:
    DoubleEnded() : last(nullptr) {}
    virtual void add(T value);      //override 3 functions
    virtual void deleteAll();
    virtual void removeFirst();
    void addToEnd(T value);     // new function
protected:
    Link <T> *last;
};

// ======================================================================
//                    Class Template Link - attributes
// ======================================================================
template <class T> Link <T> * Link <T> ::insert(T value)
{
    next = new Link <T>(value, next);
    return next;
}

// ======================================================================
//                    Class Template List - attributes
// ======================================================================
template <class T> void List <T> ::add(T value)
{
    first = new Link <T>(value, first);
}

template <class T> T List <T> ::firstElement() const
{
    assert(first != nullptr);
    return first->value;
}


template <class T> bool List <T> ::isEmpty() const
{
    return first == nullptr;
}


template <class T> bool List <T> ::includes(T value) const
{
    for (Link <T> *p = first; p; p = p->next)
        if (value == p->value)return true;
    return false;
}

template <class T> void List <T> ::removeFirst() {
    assert(first != nullptr);
    Link <T> *ptr = first;  // save pointer to the first item
    first = ptr->next;      // reassign the first node
    delete ptr;
}

template <class T> void List <T> ::deleteAll() {
    Link <T> *next;
    for (Link <T> *p = first; p; p = next) {
        next = p->next;
        delete p;
    }
    first = nullptr;
}

// ======================================================================
//                    Class Template DoubleEnded List - attributes
// ======================================================================

template <class T> void DoubleEnded <T> ::add(T value) {
    if (List<T>::isEmpty()) {
        List <T> ::add(value);
        last = this->first; // handling empty List
    }
    else List <T> ::add(value);
}

template <class T>
void DoubleEnded <T> ::addToEnd(T value) {
    if (last != nullptr)
        last = last->insert(value);
    else
        add(value);
}

template <class T> void DoubleEnded <T> ::deleteAll() {
    List <T> ::deleteAll();
    last = nullptr;
}

template <class T> void DoubleEnded <T> ::removeFirst() {
    List <T> ::removeFirst();
    if (List<T>::isEmpty()) last = nullptr;
}
// ======================================================================
//                          walidacja danych
// ======================================================================


bool isValidd(string a){
    
    
    //tu walidacja
    
    
    return true;
}
// ======================================================================
//                              main
// ======================================================================

int main()
{
    string wejscie;
    float spacje = 0.0;
    
    do
    {
        getline(cin, wejscie);
        wejscie=' '+wejscie+' ';
    }while (!isValidd(wejscie));
    
    List <double> stosik;
    double a=0.0;
    double b=0.0;
    string temp="";
    
    for(int i=0; i<wejscie.size(); i++)
    {
        if((wejscie[i]==' ') && (i!=wejscie.size()-1))
        {
            for(int j=i+1; wejscie[j]!=' '; j++)
            {
                temp+=wejscie[j]; 
            }
            cout<<temp<<endl;
            
            if(temp[0]=='+')
            {
                a=stosik.firstElement();
                stosik.removeFirst();
                b=stosik.firstElement();
                stosik.removeFirst();
                stosik.add(a+b);
                
            }else if(temp[0]=='-')
            {
                a=stosik.firstElement();
                stosik.removeFirst();
                b=stosik.firstElement();
                stosik.removeFirst();
                stosik.add(b-a);  
                
            }else if(temp[0]=='*')
            {
                a=stosik.firstElement();
                stosik.removeFirst();
                b=stosik.firstElement();
                stosik.removeFirst();
                stosik.add(a*b);  
                
            }else if(temp[0]=='/')
            {
                a=stosik.firstElement();
                stosik.removeFirst();
                b=stosik.firstElement();
                stosik.removeFirst();
                stosik.add(b/a);  
            
            }else
                {
                    a=stod(temp);
                    stosik.add(a);
                }
            
            temp="";
        }
    }
    
    cout<<"wynik: "<<stosik.firstElement();
return 1;
}