# mr (multirun)
Lightweight application to simplify working with long console commands.

# Installition
## Quick installition
#### Windows
Just run the [executable](installers/win64/multirun.exe) and follow instructions.

#### Linux
Download the [archive](installers/linux64/multirun-linux64-compiled.tar.xz), extract any place you want and run the `multirun` (Not `mr`!) file using your terminal.

## Building from source
To build Multirun, you need the installed [Haxe Language compiler](https://haxe.org/download/) and the [`hxcpp library`](https://lib.haxe.org/p/hxcpp).

###### Note: In my case, I used C++ (`hxcpp`) to build executables, but you can also use any available target of the Haxe compiler to get executable files. 

* 1. Install the `hxcpp library` using the following command:
```bat
$ haxelib install hxcpp
```

* 2. Clone repository any place you want and enter the folder:
```bat
$ git clone https://github.com/DarkJoij/mr
...

$ cd mr
```

* 3. Build the [`Main`](mr/Main.hx) class into executable:
```bat
$ haxe -main mr/Main.hx -cpp dist
```

After compilation, the executable will be located in the `dist` folder under the name `Main`.

#### Building [Linux installer](installers/LinuxInstaller.hx)
###### Note: This step is optional and can be skipped if you know what to do with the executable file.

To build the Linux installer, run the following commands:
```bat
$ cd installers
$ haxe -main LinuxInstaller.hx -cpp linux_installer
```

After compilation, the executable will be located in the `linux_installer` folder under the name `LinuxInstaller`.

#### Important! 
For correct installation, it is **NECESSARY** that the Linux installer and the executable are in the same folder! If all the conditions are met, just run the installer and Multirun will be installed on your PC.

## Other 
Look for installer for your system in [installers folder](installers).

# Running 
To run mr binary use command `mr`. If you'll enter this in commands prompt or in power shell you'll see this message:

```bat
C:\Users\User> mr
Multirun v.1.0.0 (2023). Use template: mr <alias|command> [command, ...] [-flags, ...]
```

`<>`- required arguments.\
`[]` - optional arguments.

This is because you called the application without specifying arguments. They are specified according to the scheme: **`mr [command|alias]`**.

## Action
Can be an action from a list: `new`, `lst`, `add`, `del`, `des`.

### `new`
`mr new <alias> <command>` - Creates a new config file in the current directory, if the file already exists, confirmation will be requested by entering into the console. If 2 more arguments are passed after the `new` command, the first one will be set as the alias, and the second as a command.

**Example:**

```bat
C:\Haxe\mr> mr new
Successfully created new multirun.json in C:\Haxe\mr/.
```
```bat
C:\Haxe\mr> mr add winDir dir
multirun.json not found in C:\Haxe\mr/. This will make a new.
Are you sure you want to perform this operation? (y/n): y 
Successfully created new multirun.json in C:\Haxe\mr/.
Successfully added new alias "winDir": "dir".
```

### `lst`
`mr lst` - Shows all the keys contained in the config file. If no key is found, returns default table header.

**Example:**

```bat
C:\Haxe\mr> mr new
Successfully created new multirun.json in C:\Haxe\mr/.

C:\Haxe\mr> mr lst
Aliases                     | Commands

C:\Haxe\mr> mr add build "haxe -main mr/Main.hx -cpp dist"
Successfully added new alias "build": "haxe -main mr/Main.hx -cpp dist".

C:\Haxe\mr> mr lst
Aliases                     | Commands
  build                     |   haxe -main mr/Main.hx -cpp dist
```

### `add`
`mr add <alias> <command>` - Adds a new alias to the list of existing aliases. Important! If the alias already exists, it will be overwritten without warning.

**Example:**

```bat
C:\Haxe\mr> mr add ip ipconfig
Successfully added new alias "ip": "ipconfig".
```

### `del`
`mr del <alias>` - Deletes the script from the list of scripts in the current directory, the `-f` flag is required to confirm the deletion.

**Example:**

```bat
C:\Haxe\mr> mr del ip          
If you sure what you are doing, use flag "mr del <alias> -f" to force operation.

C:\Haxe\mr> mr del ip -f
Successfully removed alias "ip".
```

### `des`
`mr des` - Deletes the mr config file from the current directory, the `-f` flag is required to confirm the operation.

**Example:**

```bat
C:\Haxe\mr> mr des      
If you sure what you are doing, use flag "mr des -f" to force operation.

C:\Haxe\mr> mr des -f   
Successfully deleted multirun.json in C:\Haxe\mr/.
```

## Alias
To call an existing aliases in the current directory, use the template: `mr <alias>`, for example: `mr ip` (according to the examples above).
All arguments passed during the call will also be applied to the called object:

Example batch-file:
```bat
@rem filename: args_test.bat:
@echo off

echo %1
echo %2
echo %3
```

The `mr.json` file
```json
{
	"bat": ".\\args_test"
}
```

The output will be:
```bat
C:\Haxe\mr> mr bat Passed three args
Passed 
three 
args
```

# Conclusion 
This project is still under development and has some problems, such as: lack of unit tests, unforeseen situations, unhandled exceptions, and so on. However, the project is constantly being finalized, and it is getting better all the time, we welcome everyone who is ready to help.\
Thanks for reading.
