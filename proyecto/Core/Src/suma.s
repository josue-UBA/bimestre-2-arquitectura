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



#define vecIn		r0
#define vecOut		r1
#define length		r2

#define aux_1		r4
#define aux_2		r5
#define aux_3		r6
#define i			r7
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
    push {r4-r7,lr}  /* guardamos la direccion de retorno en la pila */
    MOV aux_1, 0		/* se inicializa con 0 */
    MOV aux_2, 0		/* se inicializa con 0 */
    MOV i, 0			/* se inicializa con 0 */

for_1:
	CMP	i, length		/* se compara con la longitud del arreglo */
	IT	LT				/* de acuerdo a si es menor o mayor e igual... */
	BLT comp_1_1		/* salta a comp_1_1 o... */
	BGE comp_1_2		/* salta a comp_1_2 */
comp_1_1:
	LDRB aux_2,[vecIn,i,LSL 0]	/* se carga 8 bits desde la direccion base vecIn con desfase i*2 */
	ADD aux_1, aux_1, aux_2		/* se suma aux_1 mas aux_2 y se pone en registro aux_1 */
	ADD i,i,1
	B for_1
comp_1_2:
	UDIV aux_1, aux_1, length	/* se hace division sin signo con la longitud del arreglo */
	MOV i,0
for_2:
	CMP	i, length
	IT	LT
	BLT comp_2_1
	BGE comp_2_2
comp_2_1:
	LDRB aux_2,[vecIn,i,LSL 0]
	MOV aux_3, aux_2
	UQSUB8 aux_3, aux_3, aux_1
	STRB aux_3,[vecOut,i,LSL 0]
	ADD i,i,1
	B for_2
comp_2_2:
	POP {r4-r7,pc}
