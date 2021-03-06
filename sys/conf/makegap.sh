#!/bin/sh -

PADBYTE=$1

cat << __EOF__
#include <machine/asm.h>
#include <machine/param.h>

	.text
	.align	PAGE_SIZE, $PADBYTE
	.space	$RANDOM, $PADBYTE
	.align	PAGE_SIZE, $PADBYTE

	.globl	endboot
_C_LABEL(endboot):
	.space	PAGE_SIZE, $PADBYTE
	.space	$RANDOM % PAGE_SIZE,  $PADBYTE
	.align	16, $PADBYTE

	/*
	 * Randomly bias future data, bss, and rodata objects,
	 * does not help for objects in locore.S though
	  */
	.data
	.space	$RANDOM % PAGE_SIZE, $PADBYTE

	.bss
	.space	$RANDOM % PAGE_SIZE, $PADBYTE

	.section .rodata
	.space	$RANDOM % PAGE_SIZE, $PADBYTE
__EOF__
