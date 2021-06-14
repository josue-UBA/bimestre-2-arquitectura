/** Ejemplo de archivo de assembler */

/* Copyright 2018, Facundo Larosa - Danilo Zecchin
 * All rights reserved.
 *
 * This file is part of arquitecturaDeMicroprocesadores.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 */

	/**
	 * Directiva al ensablador que permite indicar que se encarga de buscar
	 * la instruccion mas apropiada entre thumb y thumb2
	 */
	.syntax unified

	/**
	 * .text permite indicar una seccion de codigo.
	 */
	.text

	/**
	 * .global permite definir un simbolo exportable,
	 * es decir que podemos verlo desde otros modulos (equivalente a extern).
     * Definimos la rutina como global para que sea visible desde otros modulos.
     */
	.global ejercicio_s
//	.type asmSum function

#define vectorIn 			r0
#define vectorAux			r1
#define longitud 			r2
#define tam					r3

#define i 					r4
#define aux_1				r5
#define aux_2				r6
#define aux_3				r7



/*
#define indice_eco			r4
#define reg_D1_D2			r5
#define reg_eco_D1_D2		r6
*/


	/**
	 * Indicamos que la siguiente subrutina debe ser ensamblada en modo thumb,
	 * entonces en las direcciones en el ultimo bit tendran el 1 para que se reconozcan como en modo thumb.
	 * Siempre hay que ponerla antes de la primer instruccion.
	 */
	.thumb_func


/**
 *	prototipo de la funcion en C
 *
 *	uint32_t asmSum(uint32_t firstOperand, uint32_t secondOperand);
 *
 *	En r0 se cargara firstOperand y en r1 se carga secondOperand. Luego el valor devuelto estara en r0 (si son 32 bits).
 *	Si el resultado que retorna es en 64 bits, usa r0 y r1.
*/


/* mi intento */

ejercicio_s:
    push {r4-r6,lr}  /* guardamos la direccion de retorno en la pila */

    MOV 	i,0
    MOV		aux_1,0
    MOV		aux_2,0
    MOV		aux_3,0
loop1:
	LDR 	aux_1,[vectorIn ,i, LSL 1]
    STR		aux_1,[vectorAux,i, LSL 1]
	ADD 	i,1
	CMP 	i, longitud
	BNE 	loop1
	POP {r4-r7,pc}

/*
loop0:
    LDR 	reg_D1_D2,[vectorIn,indice_vector, LSL 2]
    STR		reg_D1_D2,[vectorOut,indice_vector, LSL 2]
    ADD		indice_vector, 1
    CMP		indice_eco,indice_vector
    BNE 	loop0
    MOV 	indice_vector,0
loop1:
    LDR 	reg_D1_D2,[vectorIn,indice_vector, LSL 2]
	MOV		reg_eco_D1_D2,0
	SHADD16	reg_D1_D2,reg_D1_D2,reg_eco_D1_D2
    LDR		reg_eco_D1_D2,[vectorIn,indice_eco, LSL 2]
	QADD16	reg_eco_D1_D2,reg_eco_D1_D2,reg_D1_D2
    STR		reg_eco_D1_D2,[vectorOut,indice_eco, LSL 2]
   	ADD		indice_vector, 1
   	ADD		indice_eco, 1
    CMP 	indice_eco,longitud
   	BNE 	loop1
	POP {r4-r6,pc}  */
