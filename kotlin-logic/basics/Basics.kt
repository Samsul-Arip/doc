package masterclass

fun basicsDemo(): String {
    val name: String = "Ayu" // val: referensi tidak dapat diisi ulang.
    var stock: Int = 3 // var: nilainya dapat berubah.
    stock += 2
    val price: Double = 12500.0
    val available: Boolean = stock > 0 && price >= 0.0
    val label = if (available) "Tersedia" else "Habis"
    val grade =
        when (stock) {
            0 -> "Kosong"
            in 1..4 -> "Rendah"
            else -> "Cukup"
        }
    val numbers = arrayOf(1, 2, 3)
    val names: List<String> = listOf(name, "Bima")
    val mutable = mutableListOf(1, 2)
    mutable.add(3)
    var sum = 0
    for (value in numbers) sum += value
    var index = 0
    while (index < names.size) index++
    var once = 0
    do {
        once++
    } while (once < 1)
    return "$name: $label/$grade; jumlah=$sum; nama=${names.size}; sekali=$once; sisa=${5 % 2}"
}
