__Stack_Size = 128;
PROVIDE ( _Stack_Size = __Stack_Size ) ;

__Stack_Init = _estack - __Stack_Size ;
PROVIDE ( _Stack_Init = __Stack_Init ) ;

MEMORY
{
  RAM  (rwx) : ORIGIN = 0x20000000, LENGTH = 1K
}

SECTIONS
{
    /* for Cortex devices, the beginning of the startup code is stored in the .isr_vector section, which goes to FLASH */
    .isr_vector :
    {
        . = ALIGN(4);
        KEEP(*(.isr_vector))            /* Startup code */
        . = ALIGN(4);
    } >RAM

    /* for some STRx devices, the beginning of the startup code is stored in the .flashtext section, which goes to FLASH */
    .flashtext :
    {
        . = ALIGN(4);
        *(.flashtext)            /* Startup code */
        . = ALIGN(4);
    } >RAM

    /* Exception handling sections. "contains index entries for section unwinding" */
    .ARM.exidx :
    {
        . = ALIGN(4);
        *(.ARM.exidx)
        . = ALIGN(4);
    } >RAM

    /* the program code is stored in the .text section, which goes to Flash */
    .text :
    {
        . = ALIGN(4);

        *(.text)                   /* remaining code */
        *(.text.*)                   /* remaining code */
        *(.rodata)                 /* read-only data (constants) */
        *(.rodata*)
        *(.constdata)                 /* read-only data (constants) */
        *(.constdata*)
        *(.glue_7)
        *(.glue_7t)
        *(i.*)

        . = ALIGN(4);
    } >RAM

    /* This is the initialized data section
    The program executes knowing that the data is in the RAM
    but the loader puts the initial values in the FLASH (inidata).
    It is one task of the startup to copy the initial values from FLASH to RAM. */
    .data  : {
        . = ALIGN(4);
        /* This is used by the startup in order to initialize the .data secion */
        __data_start = .;

        *(.data)
        *(.data.*)

        . = ALIGN(4);
        __data_end = .; /* This is used by the startup in order to initialize the .data secion */
    } >RAM
    __data_load_start = LOADADDR(.data);

    /* This is the uninitialized data section */
    .bss (NOLOAD) : {
        . = ALIGN(4);
        __bss_start = .; /* This is used by the startup in order to initialize the .bss secion */

        *(.bss)
        *(.bss.*)
        *(COMMON)

        . = ALIGN(4);
        __bss_end = .; /* This is used by the startup in order to initialize the .bss secion */
    } >RAM

    .stack (NOLOAD) : {
        . = ALIGN(8);
        _sstack = .;
        . = . + __Stack_Size;
        . = ALIGN(8);
        _estack = .;
    } >RAM

    /* after that it's only debugging information. */

    /* remove the debugging information from the standard libraries */
    DISCARD : {
        libc.a ( * )
        libm.a ( * )
        libgcc.a ( * )
    }

    /* Stabs debugging sections.  */
    .stab          0 : { *(.stab) }
    .stabstr       0 : { *(.stabstr) }
    .stab.excl     0 : { *(.stab.excl) }
    .stab.exclstr  0 : { *(.stab.exclstr) }
    .stab.index    0 : { *(.stab.index) }
    .stab.indexstr 0 : { *(.stab.indexstr) }
    .comment       0 : { *(.comment) }
    /* DWARF debug sections.
       Symbols in the DWARF debugging sections are relative to the beginning
       of the section so we begin them at 0.  */
    /* DWARF 1 */
    .debug          0 : { *(.debug) }
    .line           0 : { *(.line) }
    /* GNU DWARF 1 extensions */
    .debug_srcinfo  0 : { *(.debug_srcinfo) }
    .debug_sfnames  0 : { *(.debug_sfnames) }
    /* DWARF 1.1 and DWARF 2 */
    .debug_aranges  0 : { *(.debug_aranges) }
    .debug_pubnames 0 : { *(.debug_pubnames) }
    /* DWARF 2 */
    .debug_info     0 : { *(.debug_info .gnu.linkonce.wi.*) }
    .debug_abbrev   0 : { *(.debug_abbrev) }
    .debug_line     0 : { *(.debug_line) }
    .debug_frame    0 : { *(.debug_frame) }
    .debug_str      0 : { *(.debug_str) }
    .debug_loc      0 : { *(.debug_loc) }
    .debug_macinfo  0 : { *(.debug_macinfo) }
    /* SGI/MIPS DWARF 2 extensions */
    .debug_weaknames 0 : { *(.debug_weaknames) }
    .debug_funcnames 0 : { *(.debug_funcnames) }
    .debug_typenames 0 : { *(.debug_typenames) }
    .debug_varnames  0 : { *(.debug_varnames) }
}
