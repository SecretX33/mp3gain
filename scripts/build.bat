@echo off
SETLOCAL EnableExtensions

IF NOT EXIST "%CD%\meson.build" (
    echo Error: current directory '%CD%' is not the root of the project, please CD into the root of the project and try again.
    goto END
)

rd /s /q "build"
meson setup "build"
cd "build"
meson compile

:END
endlocal
