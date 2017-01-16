#include <iostream>
#include <cmath>
using namespace std;
 //Compiler version g++ 4.9

 int main()
 {
    double a, b;
    cin >> a >> b;
    int x = 1;
    while (x < 10000) {
        for (int y = 1; y < 10000; y++) {

            //cout << x << " " << y << " ";
            //cout << ((double) y)/((double) x) << endl;
            if(abs(((double) y)/((double) x) - (b/a)) <= 0.003) {
                cout << x << " " << y << endl;
                return 0;
            }
        }
        x++;
    }
    return 0;
}
