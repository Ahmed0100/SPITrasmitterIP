#include "spiControlIPDriver.h"
#include "xparameters.h"

int main()
{
	spiControlIP mySPI;
	initSPIControlIP(&mySPI,XPAR_SPICONTROLIP_0_S00_AXI_BASEADDR);
	printStringToSPI(&mySPI, "hello");
}
