/**
 * @file - startup.S
 * @author - Harlan James <root@aboyandhisgnu.org>
 * @description - Startup script used to set up memory, initialize the program,
 * etc.
 */

.syntax  unified
.cpu     cortex-m4
.fpu     softvfp
.thumb

.section .vector_table, "a", %progbits
.type    vector_table, %object

/*
 * The vector table contains the reset value of the stack pointer and the start
 * address for all exception handlers
 */
vector_table:
	.word    _estack            /* initial SP value  */       
	.word    reset_handler      /* system reset      */
	.word    nmi_handler        /* nmi               */
	.word    hardfault_handler  /* hardfault handler */
	.word    default_handler    /* memory mgmt fault */
	.word    busfault_handler   /* bus fault         */
	.word    usagefault_handler /* useage fault      */
	.word    0                  /* reserved          */
	.word    0                  /* reserved          */
	.word    0                  /* reserved          */
	.word    0                  /* reserved          */
	.word    default_handler    /* SVC               */
	.word    default_handler    /* Debug             */
	.word    0                  /* reserved          */
	.word    default_handler    /* PendSV            */
	.word    default_handler    /* Systick           */
    
	.size    vector_table, . - vector_table

/*
 * @reset_handler - Called on system restart
 */
.section .text.reset_handler
	.weak reset_handler
	.type reset_handler, %function

reset_handler:
	bl main
	bx lr

    .size   reset_handler, . - reset_handler

/*
 * Exception handlers
 */
.section .text.default_handler
	.weak default_handler
	.type default_handler, %function

default_handler:
	b .

	.size   default_handler, . - default_handler

/*
 * Create weak aliases for each exception handler to the default handler.
 * Any function with the same name will override these aliases.
 */
.weak      hardfault_handler
.thumb_set hardfault_handler, default_handler

.weak      busfault_handler
.thumb_set busfault_handler, default_handler

.weak      usagefault_handler
.thumb_set usagefault_handler, default_handler

.weak      nmi_handler
.thumb_set nmi_handler, default_handler
