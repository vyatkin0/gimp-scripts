@Echo Off

SET gimp_exe="C:\Program Files\GIMP 2\bin\gimp-2.8.exe"

FOR /D %%G in ("*") DO (
cd %%~nxG
if not exist "520" mkdir 520"
if not exist "cropped" mkdir cropped"
%gimp_exe% -i -b "(file-picture-make-size \"*.jpg\")" -b "(gimp-quit 0)"
cd ..
)