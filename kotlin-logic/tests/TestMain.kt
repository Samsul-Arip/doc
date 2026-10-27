package masterclass

private fun fails(block: () -> Unit) {
    var failed = false
    try {
        block()
    } catch (_: IllegalArgumentException) {
        failed = true
    }
    check(failed)
}

fun main() {
    check(fizzBuzz(0).isEmpty())
    check(fizzBuzz(15).last() == "FizzBuzz")
    check(fibonacci(0) == 0L)
    check(fibonacci(10) == 55L)
    check(fibonacci(92) == 7540113804746346429L)
    fails { fibonacci(93) }
    check(factorial(0) == 1L)
    check(factorial(20) == 2432902008176640000L)
    fails { factorial(21) }
    check(!isPrime(-3))
    check(!isPrime(1))
    check(isPrime(2))
    check(isPrime(Int.MAX_VALUE))
    check(!isPrime(49))
    check(palindrome(""))
    check(palindrome("katak"))
    check(!palindrome("KataKx"))
    check(reverseString("abc") == "cba")
    val original = intArrayOf(1, 2, 3)
    check(reverseArray(original).contentEquals(intArrayOf(3, 2, 1)))
    check(original[0] == 1)
    check(reverseArray(intArrayOf()).isEmpty())
    check(minMax(intArrayOf()) == null)
    check(minMax(intArrayOf(-3, 2, 0)) == (-3 to 2))
    check(bubbleSort(intArrayOf(3, 1, 1, -2)).contentEquals(intArrayOf(-2, 1, 1, 3)))
    check(bubbleSort(intArrayOf()).isEmpty())
    check(deduplicate(listOf(2, 1, 2, 3)) == listOf(2, 1, 3))
    check(frequencies("aba ") == mapOf('a' to 2, 'b' to 1, ' ' to 1))
    check(twoSum(intArrayOf(3, 3), 6) == (0 to 1))
    check(twoSum(intArrayOf(2), 4) == null)
    check(twoSum(intArrayOf(Int.MAX_VALUE, 1), Int.MIN_VALUE) == null)
    check(binarySearch(intArrayOf(1, 3, 3, 7), 3) == 1)
    check(binarySearch(intArrayOf(), 1) == -1)
    check(sumEven(listOf(-2, 1, 4)) == 2L)
    check(vowelCount("Ayu") == 2)
    check(secondLargest(listOf(3, 3, 1)) == 1)
    check(secondLargest(emptyList()) == null)
    check(balanced("(())"))
    check(!balanced(")("))
    check(
        mergeSorted(listOf(1, 3), listOf(2, 3)) == listOf(1, 2, 3, 3),
    )
    val kinds =
        listOf(
            "triangle",
            "inverted-triangle",
            "pyramid",
            "inverted-pyramid",
            "diamond",
            "hollow-diamond",
            "rectangle",
            "x",
            "butterfly",
            "number-pyramid",
            "floyd",
            "pascal",
        )
    for (kind in kinds) {
        check(
            pattern(kind, 1) ==
                if (kind ==
                    "butterfly"
                ) {
                    "**"
                } else if (kind in listOf("number-pyramid", "floyd", "pascal")) {
                    "1"
                } else {
                    "*"
                },
        )
        fails { pattern(kind, 0) }
    }
    check(pattern("diamond", 3) == "  *\n ***\n*****\n ***\n  *")
    check(pattern("hollow-diamond", 3) == "  *\n * *\n*   *\n * *\n  *")
    check(pattern("pascal", 5).lines().last() == "1 4 6 4 1")
    // Properti: wajik punya n²+(n-1)² bintang; simetris vertikal dan horizontal.
    for (n in 1..15) {
        val lines = pattern("diamond", n).lines()
        check(lines == lines.reversed())
        check(lines.sumOf { line -> line.count { it == '*' } } == n * n + (n - 1) * (n - 1))
        for (line in lines) {
            val full = line.padEnd(2 * n - 1)
            check(full == full.reversed())
        }
    }

    check(restock(3, 2) == 5)
    fails { restock(-1, 2) }
    check(quotientRemainder(17, 5) == (3 to 2))
    fails { quotientRemainder(1, 0) }
    check(compareNumbers(Int.MIN_VALUE, Int.MAX_VALUE) == "lebih kecil")
    check(canBuy(1, 0, 100, true))
    check(!canBuy(0, 100, 100, true))
    check(!canBuy(1, 0, 0, false))
    check(scoreLabel(84) == "B")
    check(scoreLabel(85) == "A")
    fails { scoreLabel(101) }
    check(sumTo(0) == 0L)
    check(sumTo(4) == 10L)
    check(multiplicationTable(3) == listOf(listOf(1, 2, 3), listOf(2, 4, 6), listOf(3, 6, 9)))
    check(average(emptyList()) == null)
    check(average(listOf(1, 2)) == 1.5)
    check(normalizedPalindrome("Kasur rusak"))
    check(digitSum(1203) == 6)
    check(digitSum(0) == 0)
    println("Seluruh pengujian Kotlin lulus (algoritma, batas input, overflow, dan 12 pola).")
}
