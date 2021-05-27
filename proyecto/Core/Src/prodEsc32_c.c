/*
 * suma.c
 *
 *  Created on: 15 sep. 2018
 *      Author: fsl
 */
#include "prodEsc32.h"

void CprodEsc32(uint32_t* vectorIn , uint32_t* vectorOut , uint32_t longitud , uint32_t escalar)
{
	for(uint8_t i = 0 ; i < longitud ; i++)
	{
		vectorOut[i] = vectorIn[i]*escalar;
	}
}


