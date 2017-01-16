#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

// Ender opp med å måtte gjøre dritt på skolen
// Dette burde funke

int main() {
    int W, N;
    cin >> W >> N;

    vector<int> w(N, 0);
    vector<int> v(N, 0);
    for (int i = 0; i < N; i++)
    {
        cin >> w[i] >> v[i];
    }


    vector<vector<int> > m(N + 1, vector<int>(W + 1, 0));

    for (int i = 1; i <= N; i++) {
        for (int j = 1; j <= W; j++) {
            if (w[i-1] > j) {
                m[i][j] = m[i - 1][j];
            }
            else {
                m[i][j] = max(m[i - 1][j], m[i - 1][j - w[i-1]] + v[i-1]);
            }
        }
    }



    cout << m[N][W] << endl;
    return 0;
}
