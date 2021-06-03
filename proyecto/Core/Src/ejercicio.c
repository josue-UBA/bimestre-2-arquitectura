#include "ejercicio.h"

void ejercicio_c(uint16_t* vectorIn , uint16_t* vectorOut , uint16_t longitud , uint16_t escalar)
{
  int a0;
  for (uint16_t i = 0 ; i< longitud ; i++)
  {
    vectorOut[i] = escalar*vectorIn[i];
    a0 = vectorOut[i];
    if(vectorOut[i] > 4095)
    {
      vectorOut[i] = 4095;
    }
  }
}
