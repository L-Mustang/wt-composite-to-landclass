::By LordMustang

@echo off& setlocal EnableDelayedExpansion
set _file="%~1"
set _filename="%~nx1"
set _name=%_filename:.composit=_objects%
set _newfile= %_name%
set _finalfile= %_name%
set _temp= %_name%.tmp1
set _temp2= %_name%.tmp2

echo %_name%

type %_file% | findstr /v type | findstr /v className> %_newfile%

type %_newfile%  | call jrepl "\bnode\b" "object" | call jrepl "\btm\b" "matrix" >%_temp2%

more +4 %_temp2%  > %_temp%
copy /Y %_temp% %_newfile%
del %_temp%
del %_temp2%


@echo colliders{                               >>%_temp%
@echo   use:t="HeightMap"                      >>%_temp%
@echo   use:t="(srv) Prefab entities"          >>%_temp%
@echo   use:t="(filter) Generated by spline"   >>%_temp%
@echo   use:t="LoftGeom"                       >>%_temp%
@echo   use:t="SGeometry"                      >>%_temp%
@echo }                                        >>%_temp%
@echo.	                                       >>%_temp%
@echo placeAboveHt:r=100                       >>%_temp%
@echo.                                         >>%_temp%
@echo resources{                               >>%_temp%

type %_newfile% >> %_temp%
del %_newfile%
copy /Y %_temp% %_newfile%
del %_temp%
