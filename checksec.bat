@echo off
:: Missing:
::   StrongNames
::   Authenticode
::   Stack Cookies
:: Alternative tools:
::   https://pev.sourceforge.net (incomplete, binary)
::   https://github.com/NetSPI/PESecurity (complete, PS Script, downloads from the Internet)

if %1 == "" goto :help
if %1 == /h goto :help

echo %1
echo High Entropy:
dumpbin /NOLOGO /HEADERS %1 | findstr /C:"High Entropy Virtual Addresses"
echo Dynamic Base (ASLR):
dumpbin /NOLOGO /HEADERS %1 | findstr /C:"Dynamic base"
echo Non Executable Stack:
dumpbin /NOLOGO /HEADERS %1 | findstr /C:"NX compatible"
echo Control Flow Guard:
dumpbin /NOLOGO /HEADERS %1 | findstr /C:"Control Flow Guard"
echo Code Integrity:
dumpbin /NOLOGO /LOADCONFIG %1 | findstr /C:"Code Integrity Flags"
echo SAFESEH (x86 only):
dumpbin /NOLOGO /IMPORTS %1 | findstr /C:"seh_"
echo Debug:
dumpbin /NOLOGO /IMPORTS %1 | findstr /C:"IsDebuggerPresent"
echo.
goto :EOF

:help
echo Syntax: checksec.bat FILE
echo Shows secure compile option on windows binaries
echo Needs dumpbin from Visual Studio with its DLLs and other tools like link.exe
got :EOF

:: dumpbin /NOLOGO /HEADERS "$1" | egrep -A 10 'DLL characteristics' | \
::   grep -v 'DLL characteristics' | egrep -B10 '^[ \t]*[1-9]' | egrep -v '^[ \t]*[1-9]'
:: dumpbin /NOLOGO /LOADCONFIG "$1" | egrep 'Code Integrity Flags'
:: dumpbin /NOLOGO /IMPORTS "$1" | egrep 'IsDebuggerPresent'

