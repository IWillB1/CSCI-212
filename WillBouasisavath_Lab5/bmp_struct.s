.syntax unified
@ BMP OFFSETS           sizes
.equ HEADER_SIZE,   0x36@ bytes
@--------------------------
.equ BM_FILE_HEADER,0x0 @ 14 bytes
@--------------------------
.equ fTYPE,         0x0 @ u8
.equ fSIZE,         0x2 @ u32
.equ fRES1,         0x6 @ u16
.equ fRES2,         0x8 @ u16
.equ fOFFBITS,      0xa @ u32
@--------------------------
.equ BM_INFO_HEADER,0xe @ 40 bytes
@--------------------------
.equ iSIZE,         0xe @ u32
.equ iWIDTH,        0x12@ s32
.equ iHEIGHT,       0x16@ s32
.equ iPLANES,       0x1a@ u16
.equ iBITCOUNT,     0x1c@ u16
.equ iCOMPRESSION,  0x1e@ u32
.equ iSIZEIMG,      0x22@ u32
.equ iXPPM,         0x26@ s32
.equ iYPPM,         0x2a@ s32
.equ iCLRUSED,      0x2e@ u32
.equ iCLRIMPORTANT, 0x32@ u32
@--------------------------

