package masterclass

fun fizzBuzz(n: Int): List<String> {
    require(n in 0..10000)
    return (1..n).map {
        when {
            it % 15 == 0 -> "FizzBuzz"
            it % 3 == 0 -> "Fizz"
            it % 5 == 0 -> "Buzz"
            else -> it.toString()
        }
    }
}

// F(0)=0, F(1)=1; F(92) adalah nilai terbesar yang muat di Long.
fun fibonacci(n: Int): Long {
    require(n in 0..92)
    if (n == 0) return 0
    var previous = 0L
    var current = 1L
    for (i in 1 until n) {
        val next = previous + current
        previous = current
        current = next
    }
    return current
}

fun factorial(n: Int): Long {
    require(n in 0..20)
    var result = 1L
    for (value in 2..n) result *= value
    return result
}

fun isPrime(n: Int): Boolean {
    if (n < 2) return false
    var divisor = 2
    // Pembagian menghindari overflow dari divisor * divisor.
    while (divisor <= n / divisor) {
        if (n % divisor == 0) return false
        divisor++
    }
    return true
}

// Kontrak latihan: karakter ASCII; Unicode grapheme dibahas pada dokumentasi.
fun palindrome(text: String): Boolean {
    var left = 0
    var right = text.lastIndex
    while (left < right) {
        if (text[left++] != text[right--]) return false
    }
    return true
}

fun reverseString(text: String): String {
    val result = StringBuilder()
    for (i in text.lastIndex downTo 0) result.append(text[i])
    return result.toString()
}

fun reverseArray(input: IntArray): IntArray {
    val result = input.copyOf()
    var left = 0
    var right = result.lastIndex
    while (left < right) {
        val temp = result[left]
        result[left++] = result[right]
        result[right--] = temp
    }
    return result
}

fun minMax(input: IntArray): Pair<Int, Int>? {
    if (input.isEmpty()) return null
    var min = input[0]
    var max = input[0]
    for (value in input) {
        if (value < min) min = value
        if (value > max) max = value
    }
    return min to max
}

fun bubbleSort(input: IntArray): IntArray {
    val result = input.copyOf()
    for (end in result.lastIndex downTo 1) {
        var swapped = false
        for (i in 0 until end) {
            if (result[i] > result[i + 1]) {
                val temp = result[i]
                result[i] = result[i + 1]
                result[i + 1] = temp
                swapped = true
            }
        }
        if (!swapped) break
    }
    return result
}

fun deduplicate(input: List<Int>): List<Int> {
    val seen = linkedSetOf<Int>()
    for (value in input) seen.add(value)
    return seen.toList()
}

fun frequencies(text: String): Map<Char, Int> {
    val result = linkedMapOf<Char, Int>()
    for (char in text) result[char] = (result[char] ?: 0) + 1
    return result
}

fun twoSum(
    input: IntArray,
    target: Int,
): Pair<Int, Int>? {
    val seen = mutableMapOf<Long, Int>()
    for (i in input.indices) {
        val complement = target.toLong() - input[i].toLong()
        val previous = seen[complement]
        if (previous != null) return previous to i
        seen[input[i].toLong()] = i
    }
    return null
}

// Prasyarat: input terurut menaik. Jika seri, kembalikan indeks kemunculan pertama.
fun binarySearch(
    input: IntArray,
    target: Int,
): Int {
    var low = 0
    var high = input.lastIndex
    var found = -1
    while (low <= high) {
        val mid = low + (high - low) / 2
        when {
            input[mid] < target -> low = mid + 1
            input[mid] > target -> high = mid - 1
            else -> {
                found = mid
                high = mid - 1
            }
        }
    }
    return found
}
