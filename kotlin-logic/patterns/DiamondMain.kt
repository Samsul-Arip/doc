package diamond

fun main() {
    val n = 4
    val size = 2 * n - 1

    for (i in 1..size) {
        for (j in 1..size) {

            if (
                (i <= n && j >= n - i + 1 && j <= n + i - 1) ||
                (i > n && j >= i - n + 1 && j <= 3 * n - i - 1)
            ) {
                print("*")
            } else {
                print(" ")
            }
        }
        println()
    }
}
