package mr;

// Possible branches of commands:
// +------+---------+------------+------------+------+
// | Exec | Command | Ext arg #1 | Ext arg #2 | Flag |
// +------+---------+------------+------------+------+
// |  mr  |   add   |   <name>   |  <command> |      |
// |  mr  |   del   |   <name>   |            |  -f  |
// |  mr  |   des   |            |            |  -f  |
// |  mr  |   lst   |            |            |      |
// |  mr  |    .    |            |            |      |
// |  mr  |         |            |            |      |
// |  mr  |         |  <command> |            |      |
// +------+---------+------------+------------+------+

final class Main {
    public static function main(): Void {
        Sys.println("Hello");
    }
}
