#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

bool inLine(pair<long long, long long> a, pair<long long, long long> b) {
    return a.first == b.first || a.second == b.second || abs(a.first - b.first) == abs(a.second - b.second);
}


// Dette er en stor skuffelse
// Dette burde faen meg være innenfor
int main() {
    long long s;
    int n;
    cin >> s >> n;

    vector<pair<long long, long long> > ds(n, { 0,0 });
    vector<bool> isTruet(n, false);

    int truet = 0;

    for (int i = 0; i < n; i++) {
        cin >> ds[i].first >> ds[i].second;
    }

    for (int i = 0; i < n; i++) {
        for (int j = i+1; j < n; j++) {
            if (inLine(ds[i], ds[j])) {
                if (!isTruet[i]) {
                    truet++;
                    isTruet[i] = true;
                }
                if (!isTruet[j]) {
                    truet++;
                    isTruet[j] = true;
                }
            }
        }
    }

    cout << truet << endl;
    return 0;
}
