@echo off
SETLOCAL EnableExtensions

IF NOT EXIST "%CD%\meson.build" (
    echo Error: current directory '%CD%' is not the root of the project, please CD into the root of the project and try again.
    goto END
)

set "vsDevCmd=%VS_DEV_CMD%"
IF "%vsDevCmd%"=="" (
    echo Error: VS_DEV_CMD environment variable is not set, please set it to the path of the VSDevCmd.bat file ^(from Visual Studio 2022 x64 Native Tools Command Prompt^) and try again.
    goto END
)

call "%vsDevCmd%"

:: Build the project
call "%CD%\scripts\build.bat"

:END
endlocal
