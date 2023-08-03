#define MAX_SIM 100
#include <math.h>
void set_random(Vtop *dut, vluint64_t sim_unit) {
  int x = pow(2,4);
  dut->rst_ni = 1;
  dut->a_i = rand()%x;
  dut->b_i = rand()%x;
}
