
//bss
int bssVaraible ;
static int staticBssVariable ;

//bss and .data
int bssDataVariable = 0 ; //don't do this

//rw data
int dataVariable = 5 ;
static int staticRWVariable = 10 ;

//ro
const int roVariable = 5 ;
const int roUnintVarable ; 

int main (){
    const int x = 10 ; //stack (auto varaible)
    static int statData = 20; //saved in project life time, .data
    static int statData2; //saved in project life time, .bss

    const static int constStateInit = 5 ;
    const static int constStateNonInit ;

    int notASymbolVaraible ;
    int notASymbolVaraibleInit = 5 ;

}
