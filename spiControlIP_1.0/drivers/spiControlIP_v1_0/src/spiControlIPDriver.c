#include "spiControlIPDriver.h"

int initSPIControlIP(spiControlIP* mySPI,u32 baseAddr)
{
	mySPI->baseAddr = baseAddr;
	return 0;
}
void writeCharToSPI(spiControlIP *mySPI,char myChar)
{
	Xil_Out32(mySPI->baseAddr+8,myChar);
	Xil_Out32(mySPI->baseAddr,0x1);
	u32 status=0;
	while(!status)
	{
		status = Xil_In32(mySPI->baseAddr+4); //polling mode
	}
	Xil_Out32(mySPI->baseAddr+4,0x0);
}

void printStringToSPI(spiControlIP* mySPI,char* str)
{
	while(*str !=0)
	{
		writeCharToSPI(mySPI,*str);
		str++;
	}
}
