@echo off
setlocal EnableDelayedExpansion
SET makedir=mkdir
SET makedirArgs=
SET removedir=rmdir
SET removedirArgs=/S /Q
SET clean=del
SET cleanArgs=/F /Q 
SET buildPath=build
SET build=c64-devkit.prg
SET sourcePath=source
for %%F in (%sourcePath%\*.asm) do call SET sources=%%sources%% "%%F"
SET compilerPath=compiler
SET compiler=acme.exe
SET compilerReport=buildreport
SET compilerSymbols=symbols
SET compilerArgs=-r %buildPath%\%compilerReport% --vicelabels %buildPath%\%compilerSymbols% --msvc --color --format cbm -v3 --outfile
SET cruncherPath=cruncher
SET cruncher=pucrunch.exe
SET cruncherArgs=-x$0801 -c64 -g55 -fshort
SET emulatorPath=emulator
SET emulator=x64.exe
SET emulatorArgs=
SET genosinePath=genosine
SET genosine=genosine.exe
SET tablesPath=tables
SET table1=sin1.dat
SET table1Args=256 63 81 0 720 80 3 0
SET table2=sin2.dat
SET table2Args=256 0 255 0 180 20 3 1
SET table3=sin3.dat
SET table3Args=256 80 255 0 360 60 2 1
SET table4=sin4.dat
SET table4Args=256 90 255 0 720 80 1 0

IF NOT EXIST %buildPath% %makedir% %makedirArgs% %buildPath%
IF NOT EXIST %tablesPath% %makedir% %makedirArgs% %tablesPath%

%clean% %cleanArgs% %buildPath%\*.*
%clean% %cleanArgs% %tablesPath%\*.*

%genosinePath%\%genosine% %table1Args% > %tablesPath%\%table1%
%genosinePath%\%genosine% %table2Args% > %tablesPath%\%table2%
%genosinePath%\%genosine% %table3Args% > %tablesPath%\%table3%
%genosinePath%\%genosine% %table4Args% > %tablesPath%\%table4%
%compilerPath%\%compiler% %compilerArgs% %buildPath%\%build% %sources%
%cruncherPath%\%cruncher% %cruncherArgs% %buildPath%\%build% %buildPath%\%build%
%emulatorPath%\%emulator% %emulatorArgs% %buildPath%\%build%