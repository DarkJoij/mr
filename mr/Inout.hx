package mr;

import haxe.io.Input;
import haxe.ds.Option;

abstract Confirmation(String) {
    public function new(string: String) {
        this = string;
    }

    public function isConfirmed(): Bool {
        var successWords = ["yes", "y", "да", "д"];
        return successWords.contains(this);
    }
}

final class Default {
    private static final stdin: Input = Sys.stdin();
    
    public static final fileName: String = "multirun.json";
    public static final callingTemplate: String = "mr <command|script> [command] [-flags, ...]";

    public static function printExit(message: String): Void {
        Sys.println(message);
        Sys.exit(0);
    }

    public static function printError(message: String): Void {
        Sys.println(message);
        Sys.exit(1);
    }

    public static function readConfirmation(): Confirmation {
        Sys.print("Are you sure you want to perform this operation? (y/n): ");
        return new Confirmation(stdin.readLine());
    }
}

final class Argv {
    public final command: Option<String>;
    public final other: Array<String> = [];
    public final flags: Array<String> = [];

    public function new() {
        var args = Sys.args();

        if (args.length == 0) {
            Default.printExit('Multirun v.1.0.0. Use template: "${Default.callingTemplate}".');
        }

        for (arg in args.slice(1)) {
            StringTools.startsWith(arg, "-") 
                ? flags.push(arg) 
                : other.push(arg); 
        }

        command = other.length != 0 
            ? Option.Some(args[0]) 
            : Option.None;
    }

    public function flagProvided(flag: String): Bool {
        return flags.contains(flag);
    }

    public function toString(): String {
        return 'command: $command\nother: $other\nflags: $flags';
    }
}
