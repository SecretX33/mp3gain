# How to compile this project

1. First, you need to install our build tool of choice, Mason. Yes, you need to install it, so go ahead and install it: https://mesonbuild.com/SimpleStart.html
2. Open your terminal in Linux/Mac OS, or your `Developer Command Prompt for VS 2022` if you are on Windows (it won't work on any other terminal in Windows).
3. Navigate to the root folder of the project, where the `meson.build` file is located.
4. Set up the `build` folder with this command (you only need to run this one time).

```bash
meson setup build
```
5. Done, have fun!

Please note that there is a folder called `scripts` in this project, which contain very useful, handy scripts to automate most of the commands you will need to run.

## Build

Go to the `build` folder and run this command:
```bash
meson compile
```

## Reconfigure build (when modifying the `meson.build` file)

```bash
rm -r build
meson setup build
```

## Always build reconfiguring build

Use the script `build.bat` in `scripts` folder.

## Integration with IDEs

There is build script that is meant to be run directly by IDEs, you can find them in the `scripts/ide` folder. This is what I personally prefer and use.