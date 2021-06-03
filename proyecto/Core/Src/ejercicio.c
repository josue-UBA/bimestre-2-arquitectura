#include "ejercicio.h"

void CprodEsc12(uint16_t* vectorIn , uint16_t* vectorOut , uint16_t longitud , uint16_t escalar)
{
	for (uint16_t i = 0 ; i< longitud ; i++)
	{
		vectorOut[i]=escalar*vectorIn[i];

		if(vectorOut[i]>4095)	vectorOut[i]=4095;

	}
}
