package masterclass

private fun grid(
    rows: Int,
    cols: Int,
    fill: (Int, Int) -> String,
): String = (1..rows).joinToString("\n") { i -> (1..cols).joinToString("") { j -> fill(i, j) }.trimEnd() }

fun pattern(
    kind: String,
    n: Int,
): String {
    require(n in 1..30) { "n harus 1..30" }
    val size = 2 * n - 1
    return when (kind) {
        "triangle" -> grid(n, n) { i, j -> if (j <= i) "*" else " " }
        "inverted-triangle" -> grid(n, n) { i, j -> if (j <= n - i + 1) "*" else " " }
        "pyramid" -> grid(n, size) { i, j -> if (j >= n - i + 1 && j <= n + i - 1) "*" else " " }
        "inverted-pyramid" -> grid(n, size) { i, j -> if (j >= i && j <= 2 * n - i) "*" else " " }
        "diamond" ->
            grid(size, size) { i, j ->
                if (
                    (i <= n && j >= n - i + 1 && j <= n + i - 1) ||
                    (i > n && j >= i - n + 1 && j <= 3 * n - i - 1)
                ) {
                    "*"
                } else {
                    " "
                }
            }
        "hollow-diamond" ->
            grid(size, size) { i, j ->
                if ((i <= n && (j == n - i + 1 || j == n + i - 1)) ||
                    (i > n && (j == i - n + 1 || j == 3 * n - i - 1))
                ) {
                    "*"
                } else {
                    " "
                }
            }
        "rectangle" -> grid(n, size) { i, j -> if (i == 1 || i == n || j == 1 || j == size) "*" else " " }
        "x" -> grid(size, size) { i, j -> if (j == i || j == size - i + 1) "*" else " " }
        "butterfly" ->
            grid(size, 2 * n) { i, j ->
                val width = if (i <= n) i else 2 * n - i
                if (j <= width || j > 2 * n - width) "*" else " "
            }
        "number-pyramid" ->
            (1..n).joinToString("\n") { i ->
                " ".repeat(n - i) + (1..i).joinToString(" ")
            }
        "floyd" -> {
            var value = 1
            (1..n).joinToString("\n") { i -> (1..i).joinToString(" ") { (value++).toString() } }
        }
        "pascal" ->
            (0 until n).joinToString("\n") { i ->
                var value = 1L
                (0..i).joinToString(" ") { j ->
                    val output = value.toString()
                    value = value * (i - j) / (j + 1)
                    output
                }
            }
        else -> error("Pola tidak dikenal: $kind")
    }
}
