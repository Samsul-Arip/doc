package masterclass

fun restock(
    initial: Int,
    incoming: Int,
): Int {
    require(initial in 0..1000000 && incoming in 0..1000000)
    val result: Int = initial + incoming
    return result
}

fun quotientRemainder(
    total: Int,
    perBox: Int,
): Pair<Int, Int> {
    require(total in 0..1000000 && perBox in 1..1000000)
    return total / perBox to total % perBox
}

fun compareNumbers(
    a: Int,
    b: Int,
): String =
    if (a > b) {
        "lebih besar"
    } else if (a < b) {
        "lebih kecil"
    } else {
        "sama"
    }

fun canBuy(
    stock: Int,
    balance: Long,
    price: Long,
    vip: Boolean,
): Boolean {
    require(stock >= 0 && balance >= 0 && price >= 0)
    return stock > 0 && (balance >= price || vip) && !(price == 0L && !vip)
}

fun scoreLabel(score: Int): String {
    require(score in 0..100)
    return when (score) {
        in 85..100 -> "A"
        in 70..84 -> "B"
        in 55..69 -> "C"
        else -> "D"
    }
}

fun sumTo(n: Int): Long {
    require(n in 0..10000)
    var sum = 0L
    var i = 1
    while (i <= n) {
        sum += i
        i++
    }
    return sum
}

fun multiplicationTable(n: Int): List<List<Int>> {
    require(n in 1..20)
    val result = mutableListOf<List<Int>>()
    for (i in 1..n) {
        val row = mutableListOf<Int>()
        for (j in 1..n) row.add(i * j)
        result.add(row)
    }
    return result
}

fun average(values: List<Int>): Double? {
    if (values.isEmpty()) return null
    var total = 0L
    for (value in values) total += value
    return total.toDouble() / values.size
}

fun normalizedPalindrome(text: String): Boolean {
    val clean = text.filter { it != ' ' }.lowercase()
    return palindrome(clean)
}

fun digitSum(n: Int): Int {
    require(n in 0..1000000000)
    var remaining = n
    var sum = 0
    do {
        sum += remaining % 10
        remaining /= 10
    } while (remaining > 0)
    return sum
}
