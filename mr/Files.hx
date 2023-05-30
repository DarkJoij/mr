package mr;

import haxe.Json;
import sys.io.File;

import mr.Inout.Default;

final class FilesTools {
    public static function createFile(): Void {
        var buffer = File.write(Default.fileName, false);
        buffer.close();
    }

    public static function readFile(): Json {
        var buffer = File.read(Default.fileName, false);
        var content = buffer.readAll();

        return Json.parse(content.toString());
    }

    public static function writeFile(data: Json): Void {
        var content = Json.stringify(data, null, "\t");
        File.saveContent(Default.fileName, content);
    }
}
