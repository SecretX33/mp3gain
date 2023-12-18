@echo off
SETLOCAL EnableExtensions

rd /s /q "build"
meson setup "build"
cd "build"
meson compile

endlocal
