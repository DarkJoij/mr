package mr;

import sys.FileSystem;
import sys.io.Process;

import mr.Files.FileTools;
import mr.Inout.Argv;
import mr.Inout.Default;
import mr.Inout.RepeatableString;
import mr.Main.MR;

private final class Checks {
    public static function ifNoFileHere(): Void {
        if (!FileSystem.exists(Default.fileName)) {
            Default.printError('${Default.fileName} not found in ${Sys.getCwd()}. '
            + 'Use "mr new" to create new.');
        }
    }

    public static function isValidCommandNameLength(alias: String): Void {
        if (alias.length > 25) {
            Default.printError('Alias name "$alias" is too long. Try to choose a shorter name.');
        }
    }
}

private class Commands {
    private function checkArgumentsLength(expectedLength: Int, usage: String): Void {
        if (argv.other.length < expectedLength) {
            Default.printError('Too few argument were passed. Use template: $usage');
        }
    }

    public final argv: Argv = new Argv();

    public function new() { }

    public function add(): Void {
        if (!FileSystem.exists(Default.fileName)) {
            Sys.println('${Default.fileName} not found in ${Sys.getCwd()}. This will make a new.');
            var confirmation = Default.readConfirmation();

            confirmation.isConfirmed() 
                ? FileTools.createFile() 
                : Default.printExit("Operation rejected.");
        }

        checkArgumentsLength(2, "mr add <alias> <command>");

        var alias = argv.other[0];
        var command = argv.other[1];
        Checks.isValidCommandNameLength(alias);

        var data = FileTools.readFile();
        Reflect.setField(data, alias, command);

        FileTools.writeFile(data); 
        Default.printExit('Successfully added new alias "$alias": "$command".');
    }

    public function del(): Void {
        Checks.ifNoFileHere();
        checkArgumentsLength(1, "mr del <alias>");

        var alias = argv.other[0];
        var data = FileTools.readFile();
    
        if (Reflect.hasField(data, alias)) {
            if (argv.flagProvided("-f")) {
                Reflect.deleteField(data, alias);
                FileTools.writeFile(data);

                Default.printExit('Successfully removed alias "$alias".');
            } else {
                Default.printExit('If you sure what you are doing, ' 
                + 'use flag "mr del <alias> -f" to force operation.');
            }
        }

        Default.printError('There is no alias "$alias" in ${Default.fileName}.');
    }

    public function des(): Void {
        Checks.ifNoFileHere();

        if (argv.flagProvided("-f")) {
            FileTools.deleteFile();
        } else {
            Default.printExit('If you sure what you are doing, ' 
            + 'use flag "mr des -f" to force operation.');
        }
    }

    public function lst(): Void {
        Checks.ifNoFileHere();

        var data = FileTools.readFile();
        var spaces = new RepeatableString(" ") * 20;

        Sys.println('Aliases$spaces | Commands');

        for (alias in Reflect.fields(data)) {
            var command = Reflect.field(data, alias);
            Default.printCommandLine(alias, command);
        }
    }

    public function gen(): Void {
        if (FileSystem.exists(Default.fileName)) {
            Default.printError('${Default.fileName} already exists in ${Sys.getCwd()}.');
        }

        FileTools.createFile();
    }
}

final class Multi extends Commands {
    private function process(query: String): Void {
        var process = new Process(query);

        var output = process.stdout.readAll();
        var error = process.stderr.readAll();

        Sys.print(process.exitCode() == 0 ? output.toString() : error.toString());
    }

    private function handleAlias(command: String): Void {
        switch (command) {
            case "add": add();
            case "del": del();
            case "des": des();
            case "lst": lst();
            case "new": gen();
            default:
                var data = FileTools.readFile();

                if (!Reflect.hasField(data, command)) {
                    Default.printError('There is no such command: $command.');
                }

                var cmd = Reflect.field(data, command);
                var query = '$cmd ${argv.ref.join(" ")}';
                process(query);
        }
    }

    private function handleFlag(): Void {
        if (argv.flags.length > 1) {
            Default.printError("Multiple flags are not implemented yet.");
        }

        switch (argv.flags[0]) {
            case "-a":
                Default.printExit(MR.author);
            case "-f":
                Default.printError("Force flag allowed only with some commands "
                + '(${Default.callingTemplate}).'); 
            case "-p":
                Default.printExit(":P");
            case "-v":
                Default.printExit(MR.version + ".");
        }
    }

    public function new() {
        super();
    }

    public function run(): Void {
        switch (argv.command) {
            case Some(command):
                handleAlias(command);
            case None:
                handleFlag();
        }
    }
}
