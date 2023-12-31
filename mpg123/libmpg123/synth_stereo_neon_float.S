/*
	synth_stereo_neon_float: ARM NEON optimized synth (stereo specific, float output version)

	copyright 1995-2010 by the mpg123 project - free software under the terms of the LGPL 2.1
	see COPYING and AUTHORS files in distribution or http://mpg123.org
	initially written by Taihei Monma
*/

#include "mangle.h"

#define WINDOW r0
#define B0L r1
#define B0R r2
#define SAMPLES r3

/*
	int synth_1to1_real_s_neon_asm(real *window, real *b0l, real *b0r, real *samples, int bo1);
	return value: number of clipped samples (0)
*/

#ifndef _M_ARM
	.code 32
#endif
#ifndef __APPLE__
	.fpu neon
#endif

	.text
	GLOBAL_SYMBOL ASM_NAME(INT123_synth_1to1_real_s_neon_asm)
#ifdef __ELF__
	.type ASM_NAME(INT123_synth_1to1_real_s_neon_asm), %function
#endif
	ALIGN4
ASM_NAME(INT123_synth_1to1_real_s_neon_asm):
	push		{r4-r6, lr}
	vpush		{q4-q7}

	ldr			r4, [sp, #80]
	add			WINDOW, WINDOW, #64
	sub			WINDOW, WINDOW, r4, lsl #2

	mov			r4, #4
	mov			r5, #128
	mov			r6, #64
1:
	vld1.32		{q0,q1}, [WINDOW], r5
	vld1.32		{q2,q3}, [WINDOW]
	vld1.32		{q4,q5}, [B0L, :128], r6
	vld1.32		{q6,q7}, [B0R, :128], r6
	vld1.32		{q8,q9}, [B0L, :128]
	vld1.32		{q10,q11}, [B0R, :128]
	vmul.f32	q12, q0, q4
	vmul.f32	q13, q0, q6
	vmul.f32	q14, q2, q8
	vmul.f32	q15, q2, q10
	vmla.f32	q12, q1, q5
	vmla.f32	q13, q1, q7
	vmla.f32	q14, q3, q9
	vmla.f32	q15, q3, q11
	sub			WINDOW, WINDOW, #96
	sub			B0L, B0L, #32
	sub			B0R, B0R, #32
	vld1.32		{q0,q1}, [WINDOW], r5
	vld1.32		{q2,q3}, [WINDOW]
	vld1.32		{q4,q5}, [B0L, :128], r6
	vld1.32		{q6,q7}, [B0R, :128], r6
	vld1.32		{q8,q9}, [B0L, :128]!
	vld1.32		{q10,q11}, [B0R, :128]!
	vmla.f32	q12, q0, q4
	vmla.f32	q13, q0, q6
	vmla.f32	q14, q2, q8
	vmla.f32	q15, q2, q10
	add			WINDOW, WINDOW, #96
	vmla.f32	q12, q1, q5
	vmla.f32	q13, q1, q7
	vmla.f32	q14, q3, q9
	vmla.f32	q15, q3, q11

	vld1.32		{q0,q1}, [WINDOW], r5
	vld1.32		{q2,q3}, [WINDOW]
	vld1.32		{q4,q5}, [B0L, :128], r6
	vld1.32		{q6,q7}, [B0R, :128], r6
	vld1.32		{q8,q9}, [B0L, :128]
	vld1.32		{q10,q11}, [B0R, :128]
	vpadd.f32	d24, d24, d25
	vpadd.f32	d25, d26, d27
	vpadd.f32	d26, d28, d29
	vpadd.f32	d27, d30, d31
	vmov.i32	q14, #0x38000000
	vpadd.f32	d24, d24, d25
	vpadd.f32	d25, d26, d27
	vmul.f32	q15, q12, q14
	vmul.f32	q12, q0, q4
	vmul.f32	q13, q0, q6
	vmul.f32	q14, q2, q8
	vst1.32		{q15}, [SAMPLES]!
	vmul.f32	q15, q2, q10
	vmla.f32	q12, q1, q5
	vmla.f32	q13, q1, q7
	vmla.f32	q14, q3, q9
	vmla.f32	q15, q3, q11
	sub			WINDOW, WINDOW, #96
	sub			B0L, B0L, #32
	sub			B0R, B0R, #32
	vld1.32		{q0,q1}, [WINDOW], r5
	vld1.32		{q2,q3}, [WINDOW]
	vld1.32		{q4,q5}, [B0L, :128], r6
	vld1.32		{q6,q7}, [B0R, :128], r6
	vld1.32		{q8,q9}, [B0L, :128]!
	vld1.32		{q10,q11}, [B0R, :128]!
	vmla.f32	q12, q0, q4
	vmla.f32	q13, q0, q6
	vmla.f32	q14, q2, q8
	vmla.f32	q15, q2, q10
	add			WINDOW, WINDOW, #96
	vmla.f32	q12, q1, q5
	vmla.f32	q13, q1, q7
	vmla.f32	q14, q3, q9
	vmla.f32	q15, q3, q11
	vpadd.f32	d24, d24, d25
	vpadd.f32	d25, d26, d27
	vpadd.f32	d26, d28, d29
	vpadd.f32	d27, d30, d31
	vmov.i32	q14, #0x38000000
	vpadd.f32	d24, d24, d25
	vpadd.f32	d25, d26, d27
	vmul.f32	q12, q12, q14
	vst1.32		{q12}, [SAMPLES]!

	subs		r4, r4, #1
	bne			1b

	mov			r4, #4
	mov			r6, #-64
1:
	vld1.32		{q0,q1}, [WINDOW], r5
	vld1.32		{q2,q3}, [WINDOW]
	vld1.32		{q4,q5}, [B0L, :128], r6
	vld1.32		{q6,q7}, [B0R, :128], r6
	vld1.32		{q8,q9}, [B0L, :128]
	vld1.32		{q10,q11}, [B0R, :128]
	vmul.f32	q12, q0, q4
	vmul.f32	q13, q0, q6
	vmul.f32	q14, q2, q8
	vmul.f32	q15, q2, q10
	vmla.f32	q12, q1, q5
	vmla.f32	q13, q1, q7
	vmla.f32	q14, q3, q9
	vmla.f32	q15, q3, q11
	sub			WINDOW, WINDOW, #96
	add			B0L, B0L, #96
	add			B0R, B0R, #96
	vld1.32		{q0,q1}, [WINDOW], r5
	vld1.32		{q2,q3}, [WINDOW]
	vld1.32		{q4,q5}, [B0L, :128], r6
	vld1.32		{q6,q7}, [B0R, :128], r6
	vld1.32		{q8,q9}, [B0L, :128]
	vld1.32		{q10,q11}, [B0R, :128]
	vmla.f32	q12, q0, q4
	vmla.f32	q13, q0, q6
	vmla.f32	q14, q2, q8
	vmla.f32	q15, q2, q10
	add			WINDOW, WINDOW, #96
	sub			B0L, B0L, #96
	sub			B0R, B0R, #96
	vmla.f32	q12, q1, q5
	vmla.f32	q13, q1, q7
	vmla.f32	q14, q3, q9
	vmla.f32	q15, q3, q11

	vld1.32		{q0,q1}, [WINDOW], r5
	vld1.32		{q2,q3}, [WINDOW]
	vld1.32		{q4,q5}, [B0L, :128], r6
	vld1.32		{q6,q7}, [B0R, :128], r6
	vld1.32		{q8,q9}, [B0L, :128]
	vld1.32		{q10,q11}, [B0R, :128]
	vpadd.f32	d24, d24, d25
	vpadd.f32	d25, d26, d27
	vpadd.f32	d26, d28, d29
	vpadd.f32	d27, d30, d31
	vmov.i32	q14, #0x38000000
	vpadd.f32	d24, d24, d25
	vpadd.f32	d25, d26, d27
	vmul.f32	q15, q12, q14
	vmul.f32	q12, q0, q4
	vmul.f32	q13, q0, q6
	vmul.f32	q14, q2, q8
	vst1.32		{q15}, [SAMPLES]!
	vmul.f32	q15, q2, q10
	vmla.f32	q12, q1, q5
	vmla.f32	q13, q1, q7
	vmla.f32	q14, q3, q9
	vmla.f32	q15, q3, q11
	sub			WINDOW, WINDOW, #96
	add			B0L, B0L, #96
	add			B0R, B0R, #96
	vld1.32		{q0,q1}, [WINDOW], r5
	vld1.32		{q2,q3}, [WINDOW]
	vld1.32		{q4,q5}, [B0L, :128], r6
	vld1.32		{q6,q7}, [B0R, :128], r6
	vld1.32		{q8,q9}, [B0L, :128]
	vld1.32		{q10,q11}, [B0R, :128]
	vmla.f32	q12, q0, q4
	vmla.f32	q13, q0, q6
	vmla.f32	q14, q2, q8
	vmla.f32	q15, q2, q10
	add			WINDOW, WINDOW, #96
	sub			B0L, B0L, #96
	sub			B0R, B0R, #96
	vmla.f32	q12, q1, q5
	vmla.f32	q13, q1, q7
	vmla.f32	q14, q3, q9
	vmla.f32	q15, q3, q11
	vpadd.f32	d24, d24, d25
	vpadd.f32	d25, d26, d27
	vpadd.f32	d26, d28, d29
	vpadd.f32	d27, d30, d31
	vmov.i32	q14, #0x38000000
	vpadd.f32	d24, d24, d25
	vpadd.f32	d25, d26, d27
	vmul.f32	q12, q12, q14
	vst1.32		{q12}, [SAMPLES]!

	subs		r4, r4, #1
	bne			1b

	mov			r0, #0

	vpop		{q4-q7}
	pop			{r4-r6, pc}

NONEXEC_STACK
