package masterclass

fun sumEven(values: List<Int>): Long {
    var result = 0L
    for (v in values) if (v % 2 == 0) result += v
    return result
}

fun vowelCount(text: String): Int = text.count { it.lowercaseChar() in "aiueo" }

fun secondLargest(values: List<Int>): Int? {
    var first: Int? = null
    var second: Int? = null
    for (v in values) {
        if (first == null || v > first) {
            second = first
            first = v
        } else if (v != first && (second == null || v > second)) {
            second = v
        }
    }
    return second
}

fun balanced(text: String): Boolean {
    var depth = 0
    for (c in text) {
        require(c == '(' || c == ')')
        depth += if (c == '(') 1 else -1
        if (depth < 0) return false
    }
    return depth == 0
}

fun mergeSorted(
    a: List<Int>,
    b: List<Int>,
): List<Int> {
    var i = 0
    var j = 0
    val result = mutableListOf<Int>()
    while (i < a.size && j < b.size) {
        if (a[i] <= b[j]) result.add(a[i++]) else result.add(b[j++])
    }
    while (i < a.size) result.add(a[i++])
    while (j < b.size) result.add(b[j++])
    return result
}
