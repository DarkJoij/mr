// +------+---------+------------+------------+------+
// | Exec | Command | Ext arg #1 | Ext arg #2 | Flag |
// +------+---------+------------+------------+------+
// |  mr  |   add   |   <name>   |  <command> |      |
// |  mr  |   del   |   <name>   |            |  -f  |
// |  mr  |   des   |            |            |  -f  |
// |  mr  |   lst   |            |            |      |
// |  mr  |   new   |            |            |      |
// |  mr  |         |            |            |      |
// |  mr  |         |  <command> |            |      |
// +------+---------+------------+------------+------+

package mr;

import mr.Commands.Multi;

final class MR {
    public static final author: String = "(C) Dallas 2023. https://github.com/DarkJoij";
    public static final version: String = "Multirun v.1.0.0 (2023)";
}

final class Main {
    public static function main(): Void {
        var multi = new Multi();
        multi.run();
    }
}
