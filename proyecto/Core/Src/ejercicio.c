#include "ejercicio.h"

void CprodEsc32(uint32_t* vectorIn , uint32_t* vectorOut , uint32_t longitud , uint32_t escalar)
{
	for(uint8_t i = 0 ; i < longitud ; i++)
	{
		vectorOut[i] = vectorIn[i]*escalar;
	}
}
