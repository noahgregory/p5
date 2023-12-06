#include "monthly-stats.hpp"
#include <iostream>
#include <cassert>

using namespace std;

bool isClose(double value1, double value2, double epsilon = 1e-4) {
  return abs(value1 - value2) < epsilon;
}

int main() {
  cout << "Start testing the MonthlyStats class ...\n";
  string line1 = "6/23/2021 78.48 77.92 74.83 74.27 73.44 71.16 78.21 77.95 76.12 72.21 71.19 78.46 72.54 77.73 78.86 77.54 73.39 78.43 73.51 71.11 70.77 73.10 70.63 79.91";
  MonthlyStats ms;
  assert(ms.getDays() == 0);
  ms.addDay(line1);
  assert(ms.getDays() == 1);
  assert(ms.avgTempOnDate("6/2/2021") < 0);  // date not found
  assert(ms.avgTempOnDate("6/23/2021") > 0);  // date found
  assert(ms.dateWithMaxTemp() == "6/23/2021");
  cout << "All test passed!\n";

  return EXIT_SUCCESS;
}




