#ifndef SPI_CONTROL
#define SPI_CONTROL
#include "xil_types.h"
#include "xil_io.h"
typedef struct spiControlIP
{
	u32 baseAddr;
} spiControlIP;

int initSPIControlIP(spiControlIP* mySPI,u32 baseAddr);
void writeCharToSPI(spiControlIP *mySPI,char myChar);
void printStringToSPI(spiControlIP* mySPI,char* str);
#endif
