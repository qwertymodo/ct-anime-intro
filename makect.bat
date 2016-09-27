@echo off

rem ********** create temporary linker file
echo [objects] > ct_msu1.lnk
echo ct_msu1.o >> ct_msu1.lnk

rem ********** assemble ROM
wla-65816 -o ct_msu1.asm ct_msu1.o
wlalink -rs ct_msu1.lnk ct_msu1.sfc

rem ********** delete temporary files
del ct_msu1.lnk
del ct_msu1.o
del ct_msu1.sym

rem ********** fix ROM checksum
rem snestools -hi! -hc ct_msu1.sfc

rem ********** create BPS patch
beat -encode -delta -p ct_msu1.bps -t ct_msu1.sfc ct.sfc

pause
