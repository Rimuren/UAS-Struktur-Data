//edit.dart

import 'dart:io'; // Import library Dart untuk input/output
import 'notes.dart'; // Import file notes.dart yang berisi definisi class Transaction, Income, dan Expense

// Fungsi untuk mengedit transaksi berdasarkan ID
void editTransaction(List<Note> transactions) {
  // Meminta pengguna untuk memasukkan ID transaksi yang ingin diedit
  print("Masukkan ID yang ingin diedit:");
  int idToEdit;
  try {
    // Membaca input ID dari pengguna dan mengonversinya menjadi integer
    idToEdit = int.parse(stdin.readLineSync()!);
  } catch (e) {
    // Menampilkan pesan kesalahan jika input ID tidak valid
    print("ID tidak valid.");
    return;
  }

  // Mencari transaksi berdasarkan ID
  Note? transactionToEdit;
  for (var transaction in transactions) {
    if (transaction.id == idToEdit) {
      transactionToEdit = transaction;
      break; // Berhenti mencari jika transaksi ditemukan
    }
  }

  // Jika transaksi tidak ditemukan, menampilkan pesan kesalahan dan keluar dari fungsi
  if (transactionToEdit == null) {
    print("Riwayat dengan ID tersebut tidak ditemukan.");
    return;
  }

  // Menampilkan data transaksi saat ini
  print("Data saat ini:");
  print("ID: ${transactionToEdit.id}");
  print("Deskripsi: ${transactionToEdit.description}");
  print("Jumlah: ${transactionToEdit.amount}");
  print("Tanggal: ${transactionToEdit.date.toIso8601String().split('T')[0]}");

  // Meminta pengguna untuk memasukkan deskripsi baru
  // Jika pengguna menekan enter tanpa memasukkan deskripsi baru, deskripsi saat ini akan dipertahankan
  print("Masukkan deskripsi baru (tekan enter untuk mempertahankan nilai saat ini):");
  String newDesc = stdin.readLineSync()!;
  if (newDesc.isNotEmpty) {
    transactionToEdit.description = newDesc; // Memperbarui deskripsi transaksi
  }

  // Meminta pengguna untuk memasukkan jumlah baru
  // Jika pengguna menekan enter tanpa memasukkan jumlah baru, jumlah saat ini akan dipertahankan
  print("Masukkan jumlah baru (tekan enter untuk mempertahankan nilai saat ini):");
  String newAmountStr = stdin.readLineSync()!;
  if (newAmountStr.isNotEmpty) {
    try {
      double newAmount = double.parse(newAmountStr);
      transactionToEdit.amount = newAmount; // Memperbarui jumlah transaksi
    } catch (e) {
      // Menampilkan pesan kesalahan jika jumlah baru tidak valid
      print("Jumlah tidak valid. Menggunakan nilai saat ini.");
    }
  }

  // Meminta pengguna untuk memasukkan tanggal baru dalam format yyyy-mm-dd
  // Jika pengguna menekan enter tanpa memasukkan tanggal baru, tanggal saat ini akan dipertahankan
  print("Tambah tanggal (yyyy-mm-dd) / tekan enter untuk mempertahankan nilai saat ini:");
  String newDateStr = stdin.readLineSync()!.trim();
  if (newDateStr.isNotEmpty) {
    try {
      DateTime newDate = DateTime.parse(newDateStr);
      transactionToEdit.date = newDate; // Memperbarui tanggal transaksi
    } catch (e) {
      // Menampilkan pesan kesalahan jika format tanggal baru tidak valid
      print("Format tanggal tidak valid. Menggunakan nilai saat ini.");
    }
  }

  // Menampilkan pesan bahwa transaksi telah berhasil diperbarui
  print("Riwayat berhasil diperbarui.");
}
