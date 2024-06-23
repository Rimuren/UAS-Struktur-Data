//fun.dart

import 'dart:io'; // Import library Dart untuk input/output
import 'notes.dart'; // Import file notes.dart yang berisi definisi class Note, Income, dan Expense

int _nextId = 1; // Variabel untuk mengelola ID berikutnya

// Fungsi untuk menyimpan transaksi ke dalam file CSV
// Mengonversi daftar transaksi menjadi string CSV dan menulisnya ke file
void saveToCSV(List<Note> transactions, String fileName) {
  var file = File(fileName); // Membuat file dengan nama fileName
  var csvString = 'Id,Deskripsi,Jumlah,Tanggal\n'; // Header CSV

  // Mengonversi setiap transaksi menjadi baris CSV
  for (var transaction in transactions) {
    csvString +=
        '${transaction.id},${transaction.description},${transaction.amount},${transaction.date.toIso8601String().split('T')[0]}\n';
  }

  // Menulis string CSV ke file
  file.writeAsStringSync(csvString);
  print("Data telah disimpan ke $fileName");
}

// Fungsi untuk menambahkan catatan baru
void addTransaction(List<Note> transactions) {
  print("Masukkan deskripsi :");
  String desc = stdin.readLineSync()!; // Membaca deskripsi dari input pengguna

  print("Masukkan jumlah :");
  double amount = double.parse(stdin.readLineSync()!); // Membaca jumlah dari input pengguna

  print('Tambah tanggal (yyyy-mm-dd) / tekan enter untuk tanggal hari ini:');
  String inputDate = stdin.readLineSync()!.trim(); // Membaca input tanggal dan menghapus spasi ekstra

  DateTime date;
  if (inputDate.isNotEmpty) {
    try {
      date = DateTime.parse(inputDate); // Mengonversi input tanggal menjadi objek DateTime
    } catch (e) {
      print("Format tanggal tidak valid. Menggunakan tanggal hari ini.");
      date = DateTime.now(); // Menggunakan tanggal hari ini jika format tidak valid
    }
  } else {
    date = DateTime.now(); // Menggunakan tanggal hari ini jika input kosong
  }

  // Menentukan ID untuk transaksi baru
  int id = _nextId++; // Menggunakan _nextId dan menambahkannya untuk ID berikutnya

  // Menambahkan transaksi sebagai pemasukan atau pengeluaran
  print("Apakah Data Merupakan Pemasukan (Y/N)?");
  var isIncome = stdin.readLineSync()!.toLowerCase() == 'y'; // Membaca input pengguna untuk menentukan jenis transaksi
  if (isIncome) {
    transactions.add(Income(id, desc, amount, date)); // Menambahkan pemasukan
  } else {
    transactions.add(Expense(id, desc, amount, date)); // Menambahkan pengeluaran
  }
}

// Fungsi untuk menampilkan riwayat beserta total pemasukan dan pengeluaran
void displayHistory(List<Note> transactions) {
  if (transactions.isEmpty) {
    print("Belum ada Catatan."); // Menampilkan pesan jika tidak ada transaksi
  } else {
    double totalIncome = 0; // Variabel untuk menyimpan total pemasukan
    double totalExpense = 0; // Variabel untuk menyimpan total pengeluaran

    print("Riwayat :");
    for (var transaction in transactions) {
      print(
          "${transaction.id}. Deskripsi: ${transaction.description}, Jumlah: ${transaction.amount}, Tanggal: ${transaction.date.toIso8601String().split('T')[0]}");

      // Menghitung total pemasukan dan pengeluaran
      if (transaction is Income) {
        totalIncome += transaction.amount;
      } else if (transaction is Expense) {
        totalExpense += transaction.amount;
      }
    }

    // Menampilkan total pemasukan dan pengeluaran
    print("Pemasukan: $totalIncome");
    print("Pengeluaran: $totalExpense");

    // Menampilkan saldo saat ini
    double currentBalance = totalIncome - totalExpense;
    print("Total saat ini: $currentBalance");
  }
}

// Fungsi untuk mencari transaksi berdasarkan deskripsi
void search(List<Note> transactions, String keyword) {
  // Filter berdasarkan keyword yang diberikan
  List<Note> results = transactions
      .where((transaction) =>
          transaction.description.toLowerCase().contains(keyword.toLowerCase()))
      .toList();

  if (results.isEmpty) {
    print("Tidak ditemukan."); // Menampilkan pesan jika tidak ada transaksi yang ditemukan
  } else {
    print("Hasil Pencarian:");
    for (var transaction in results) {
      print(
          "Deskripsi: ${transaction.description}, Jumlah: ${transaction.amount}, Tanggal: ${transaction.date.toIso8601String().split('T')[0]}");
    }
  }
}

// Fungsi untuk mengurutkan transaksi berdasarkan deskripsi
void sortTransactions(List<Note> transactions) {
  transactions.sort((a, b) => a.description.compareTo(b.description)); // Mengurutkan transaksi berdasarkan deskripsi
}

// Fungsi untuk menghapus transaksi berdasarkan ID
void deleteTransaction(List<Note> transactions) {
  print("Masukkan ID transaksi yang ingin dihapus:");
  int idToDelete = int.parse(stdin.readLineSync()!); // Membaca ID dari input pengguna

  bool found = false;
  // Mencari transaksi berdasarkan ID
  for (var i = 0; i < transactions.length; i++) {
    if (transactions[i].id == idToDelete) {
      transactions.removeAt(i); // Menghapus transaksi jika ditemukan
      found = true;
      print("Riwayat berhasil dihapus.");
      break;
    }
  }

  if (!found) {
    print("Riwayat dengan ID tersebut tidak ditemukan."); // Menampilkan pesan jika transaksi tidak ditemukan
  }
}
