# 30 latihan Kotlin

Kerjakan fungsi tanpa membaca solusi. Kontrak fungsi adalah input terstruktur (bukan parsing stdin). CLI pola menerima nama pola dan n. Semua solusi dapat dikompilasi dan diuji dengan `bash scripts/kotlin.sh test`.

## 01. FizzBuzz — Beginner

Soal: buat fungsi untuk fizzbuzz. Batas input: n=0..10000.

Input:
```text
15
```
Output:
```text
[1, 2, Fizz, 4, Buzz, …, FizzBuzz]
```

## 02. Fibonacci — Beginner

Soal: buat fungsi untuk fibonacci. Batas input: n=0..92; F(0)=0,F(1)=1.

Input:
```text
10
```
Output:
```text
55
```

## 03. Factorial — Beginner

Soal: buat fungsi untuk factorial. Batas input: n=0..20.

Input:
```text
5
```
Output:
```text
120
```

## 04. Bilangan prima — Beginner

Soal: buat fungsi untuk bilangan prima. Batas input: Int apa pun.

Input:
```text
49
```
Output:
```text
false
```

## 05. Palindrome peka kapital — Beginner

Soal: buat fungsi untuk palindrome peka kapital. Batas input: ASCII panjang 0..10000.

Input:
```text
katak
```
Output:
```text
true
```

## 06. Reverse String — Beginner

Soal: buat fungsi untuk reverse string. Batas input: ASCII panjang 0..10000.

Input:
```text
abc
```
Output:
```text
cba
```

## 07. Reverse Array tanpa mengubah input — Beginner

Soal: buat fungsi untuk reverse array tanpa mengubah input. Batas input: 0..10000 elemen Int.

Input:
```text
[1,2,3]
```
Output:
```text
[3,2,1]
```

## 08. Minimum dan maksimum — Beginner

Soal: buat fungsi untuk minimum dan maksimum. Batas input: 0..10000 elemen Int.

Input:
```text
[-3,2,0]
```
Output:
```text
(-3,2)
```

## 09. Bubble Sort — Intermediate

Soal: buat fungsi untuk bubble sort. Batas input: 0..2000 elemen Int.

Input:
```text
[3,1,1,-2]
```
Output:
```text
[-2,1,1,3]
```

## 10. Hapus duplikasi, pertahankan urutan pertama — Intermediate

Soal: buat fungsi untuk hapus duplikasi, pertahankan urutan pertama. Batas input: 0..10000 Int.

Input:
```text
[2,1,2,3]
```
Output:
```text
[2,1,3]
```

## 11. Frekuensi karakter — Intermediate

Soal: buat fungsi untuk frekuensi karakter. Batas input: ASCII panjang 0..10000.

Input:
```text
"aba "
```
Output:
```text
{a=2,b=1,spasi=1}
```

## 12. Two Sum, indeks berbeda, pasangan pertama yang ditemukan — Intermediate

Soal: buat fungsi untuk two sum, indeks berbeda, pasangan pertama yang ditemukan. Batas input: 0..10000 Int; target Int.

Input:
```text
[2,7,11,15],9
```
Output:
```text
(0,1)
```

## 13. Binary Search indeks pertama — Intermediate

Soal: buat fungsi untuk binary search indeks pertama. Batas input: Array menaik 0..10000 Int.

Input:
```text
[1,3,3,7],3
```
Output:
```text
1
```

## 14. Segitiga siku-siku — Beginner

Soal: buat fungsi untuk segitiga siku-siku. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
*
**
***
****
```

## 15. Segitiga terbalik — Beginner

Soal: buat fungsi untuk segitiga terbalik. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
****
***
**
*
```

## 16. Piramida — Beginner

Soal: buat fungsi untuk piramida. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
   *
  ***
 *****
*******
```

## 17. Piramida terbalik — Beginner

Soal: buat fungsi untuk piramida terbalik. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
*******
 *****
  ***
   *
```

## 18. Diamond satu if — Intermediate

Soal: buat fungsi untuk diamond satu if. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
   *
  ***
 *****
*******
 *****
  ***
   *
```

## 19. Hollow diamond — Intermediate

Soal: buat fungsi untuk hollow diamond. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
   *
  * *
 *   *
*     *
 *   *
  * *
   *
```

## 20. Hollow rectangle — Intermediate

Soal: buat fungsi untuk hollow rectangle. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
*******
*     *
*     *
*******
```

## 21. X pattern — Intermediate

Soal: buat fungsi untuk x pattern. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
*     *
 *   *
  * *
   *
  * *
 *   *
*     *
```

## 22. Butterfly — Intermediate

Soal: buat fungsi untuk butterfly. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
*      *
**    **
***  ***
********
***  ***
**    **
*      *
```

## 23. Number pyramid — Intermediate

Soal: buat fungsi untuk number pyramid. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
   1
  1 2
 1 2 3
1 2 3 4
```

## 24. Floyd’s triangle — Intermediate

Soal: buat fungsi untuk floyd’s triangle. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
1
2 3
4 5 6
7 8 9 10
```

## 25. Pascal’s triangle — Intermediate

Soal: buat fungsi untuk pascal’s triangle. Batas input: n=1..30.

Input:
```text
n=4
```
Output:
```text
1
1 1
1 2 1
1 3 3 1
```

## 26. Jumlah bilangan genap — Beginner

Soal: buat fungsi untuk jumlah bilangan genap. Batas input: 0..10000 Int.

Input:
```text
[-2,1,4]
```
Output:
```text
2
```

## 27. Hitung vokal — Beginner

Soal: buat fungsi untuk hitung vokal. Batas input: ASCII 0..10000 karakter.

Input:
```text
Ayu
```
Output:
```text
2
```

## 28. Nilai terbesar kedua yang berbeda — Advanced

Soal: buat fungsi untuk nilai terbesar kedua yang berbeda. Batas input: 0..10000 Int.

Input:
```text
[3,3,1]
```
Output:
```text
1
```

## 29. Validasi kurung seimbang — Advanced

Soal: buat fungsi untuk validasi kurung seimbang. Batas input: Hanya ( dan ), panjang 0..10000.

Input:
```text
(())
```
Output:
```text
true
```

## 30. Gabung dua list terurut — Advanced

Soal: buat fungsi untuk gabung dua list terurut. Batas input: Masing-masing 0..10000 Int menaik.

Input:
```text
[1,3] dan [2,3]
```
Output:
```text
[1,2,3,3]
```
