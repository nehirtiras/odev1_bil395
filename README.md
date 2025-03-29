# odev1_bil395 Nehir Tıraş 231101065

# Basit Hesap Makinesi (Lex & Yacc)
Özellikler:

Temel işlemler: +, -, *, /

Üs alma: ^

Parantez desteği: (, )

Değişken atama (örnek: x = 5 + 3)

Ondalık sayı desteği (örnek: 3.14 * 2)

Hata yönetimi:

Sıfıra bölme hatası

Geçersiz karakter uyarısı
*****
# Değişken Yönetimi:

Sabit boyutlu symbol table (100 eleman)

strdup() ile hafıza yönetimi

Sayı Desteği:

Tüm sayılar double olarak işlenir

Hata Kontrolü:

Sıfıra bölme hatası

Geçersiz karakter uyarısı
*****
# Kurulum & Çalıştırma


lex calculator.l
yacc -d calculator.y


gcc lex.yy.c y.tab.c -o calculator -lm
./calculator


*****
# Test Senaryoları
Temel Aritmetik

3 + 5 → 8

10 * 4 → 40

Parantezli İfadeler

(1 + 2) * 4 → 12

Değişken Atama

x = 5 → Assigned 5 to x

x * 3 → 15

Hata Yönetimi

5 / 0 → Error: Division by zero

3 % 2 → Error: Invalid character

Üs Alma (Bonus)

2 ^ 3 → 8
