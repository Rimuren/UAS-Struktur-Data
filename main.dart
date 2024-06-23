//main.dart

import 'dart:io'; // Import library Dart untuk input/output
import 'notes.dart'; // Import file notes.dart yang berisi definisi class Note, Income, dan Expense
import 'fun.dart'; // Import file fun.dart yang berisi fungsi-fungsi utilitas seperti addTransaction, saveToCSV, dll.
import 'edit.dart'; // Import file edit.dart yang berisi fungsi untuk mengedit transaksi

void main() {
  List<Note> transactions = []; // List untuk menyimpan transaksi

  // Looping menu utama
  while (true) {
    // Menampilkan menu kepada pengguna
    print("""

    Menu:
    1. Tambah Catatan
    2. Cari Catatan
    3. Lihat Riwayat
    4. Hapus Riwayat
    5. Edit Riwayat
    6. Keluar

    Pilih opsi:
    
    """);

    // Membaca pilihan pengguna
    var choice = int.parse(stdin.readLineSync()!);

    // Memproses pilihan pengguna
    switch (choice) {
      case 1:
        // Menambahkan transaksi baru
        addTransaction(transactions);
        // Mengurutkan transaksi berdasarkan deskripsi
        sortTransactions(transactions);
        // Menyimpan transaksi ke file CSV
        saveToCSV(transactions, 'notes.csv');
        break;
      case 2:
        // Mencari transaksi berdasarkan deskripsi
        print("Masukkan Deskripsi Pencarian:");
        var keyword = stdin.readLineSync()!;
        search(transactions, keyword);
        break;
      case 3:
        // Menampilkan riwayat transaksi
        displayHistory(transactions);
        break;
      case 4:
        // Menghapus transaksi berdasarkan ID
        deleteTransaction(transactions);
        // Menyimpan perubahan ke file CSV
        saveToCSV(transactions, 'notes.csv');
        break;
      case 5:
        // Menampilkan riwayat transaksi
        displayHistory(transactions);
        // Mengedit transaksi berdasarkan ID
        editTransaction(transactions);
        // Menyimpan perubahan ke file CSV
        saveToCSV(transactions, 'notes.csv');
        break;
      case 6:
        // Keluar dari program
        exit(0);
      default:
        // Menampilkan pesan jika pilihan tidak valid
        print("Pilihan tidak valid. Silakan pilih kembali.");
        break;
    }
  }
}
