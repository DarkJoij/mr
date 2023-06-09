import haxe.io.Input;
import sys.io.File;
import sys.io.Process;

private final class Linux {
    public static final workingDirectory: String = processBashCommand("echo \"$PWD\"");
    public static final userName: String = processBashCommand("echo \"$USER\"");

    public static function processBashCommand(command: String): String {
        var process = new Process(command);

        try {
            var bytes = process.stdout.readLine();
            return bytes.toString();
        } catch (exception) {
            return 'Exception occured: ${exception.message}.';
        }
    }
}

private final class Bashrc {
    private static final bashrcPath: String = '/home/${Linux.userName}/.bashrc';

    public static function readFile(): String {
        return File.getContent(bashrcPath);
    }

    public static function writeToFile(line: String): Void {
        var bashrcContent = readFile();
        File.saveContent(bashrcPath, bashrcContent + "\n" + line);
    }
}

final class LinuxInstaller {
    private static final stdin: Input = Sys.stdin();

    public static function main(): Void {
        Sys.println("Welcome to Multirun Linux Installer.\n");
        Sys.println("This will install Multirun on your computer.");
        
        try {
            Bashrc.writeToFile("export PATH=\"$PATH:" + Linux.workingDirectory + '"');
        } catch (exception) {
            return Sys.println('Unknown exception occured: "$exception" at ${exception.stack}.');
        }

        Sys.println("Installition complete. You can close this window.");
        stdin.readByte();
    }
}
