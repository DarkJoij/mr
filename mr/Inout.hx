package mr;

import haxe.ds.Option;
import haxe.io.Input;

import mr.Main.MR;

abstract Confirmation(String) {
    public inline function new(string: String) {
        this = string;
    }

    public function isConfirmed(): Bool {
        var successWords = ["yes", "y", "да", "д"];
        return successWords.contains(this);
    }
}

abstract RepeatableString(String) {
    public inline function new(string: String) {
        this = string;
    }

    @:op(A * B)
    public function repeat(count: Int): RepeatableString {
        var buffer = new StringBuf();

        for (_ in 0...count) {
            buffer.add(this);
        }

        return new RepeatableString(buffer.toString());
    }
}

final class Default {
    private static final stdin: Input = Sys.stdin();
    
    public static final fileName: String = "multirun.json";
    public static final callingTemplate: String = "mr <alias|command> [command] [-flags, ...]";

    public static function readConfirmation(): Confirmation {
        Sys.print("Are you sure you want to perform this operation? (y/n): ");
        return new Confirmation(stdin.readLine());
    }

    public static function printExit(message: String): Void {
        Sys.println(message);
        Sys.exit(0);
    }

    public static function printError(message: String): Void {
        Sys.println(message);
        Sys.exit(1);
    }

    public static function printCommandLine(alias: String, command: String): Void {
        var spaces = new RepeatableString(" ") * (25 - alias.length);
        Sys.println('  $alias$spaces |   $command');
    }
}

final class Argv {
    private function swapToFlag(arg: String): Option<String> {
        this.flags.unshift(arg);
        return Option.None;
    } 

    public final ref: Array<String>;
    public final command: Option<String>;
    public final other: Array<String> = [];
    public final flags: Array<String> = [];
    
    public function new() {
        var args = Sys.args();

        if (args.length == 0) {
            Default.printExit('${MR.version}. Use template: ${Default.callingTemplate}');
        }

        this.ref = args.slice(1);
        this.command = !StringTools.startsWith(args[0], "-")
            ? Option.Some(args[0])
            : swapToFlag(args[0]);

        for (arg in this.ref) {
            StringTools.startsWith(arg, "-")
                ? flags.push(arg)
                : other.push(arg);
        }
    }

    public function flagProvided(flag: String): Bool {
        return flags.contains(flag);
    }

    @:deprecated
    public function toString(): String {
        return 'ref: $ref\ncommand: $command\nother: $other\nflags: $flags';
    }
}
