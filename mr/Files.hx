package mr;

import haxe.Json;
import sys.FileSystem;
import sys.io.File;

import mr.Inout.Default;

final class FileTools {
    public static function createFile(): Void {
        var buffer = File.write(Default.fileName, false);
        buffer.close();

        File.saveContent(Default.fileName, "{}");
        Sys.println('Successfully created new ${Default.fileName} in ${Sys.getCwd()}.');
    }

    public static function readFile(): Dynamic {
        var content = File.getContent(Default.fileName);
        return Json.parse(content);
    }

    public static function writeFile(data: Dynamic): Void {
        var content = Json.stringify(data, null, "\t");
        File.saveContent(Default.fileName, content);
    }

    public static function deleteFile(): Void {
        try {
            FileSystem.deleteFile(Default.fileName);
            Default.printExit('Successfully deleted ${Default.fileName} in ${Sys.getCwd()}.');
        } catch (exception) {
            Default.printError('There is no ${Default.fileName} in ${Sys.getCwd()}.');
        }
    }
}
