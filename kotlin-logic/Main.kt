package masterclass

fun main(args: Array<String>) {
    val kind = args.getOrNull(0) ?: "diamond"
    val n = args.getOrNull(1)?.toIntOrNull() ?: 4
    when (kind) {
        "basics" -> println(basicsDemo())
        "algorithms" -> {
            println("FizzBuzz: ${fizzBuzz(15)}")
            println("Fibonacci(10): ${fibonacci(10)}")
            println("Two Sum: ${twoSum(intArrayOf(2,7,11,15),9)}")
            println("Binary Search: ${binarySearch(intArrayOf(1,3,3,7),3)}")
        }
        else -> println(pattern(kind, n))
    }
}
