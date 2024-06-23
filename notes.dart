// notes.dart

// Kelas dasar untuk transaksi
class Note {
  int id; // Menambahkan ID sebagai properti

  String description;
  double amount;
  DateTime date;

  Note(this.id, this.description, this.amount, this.date);
}

// Kelas untuk transaksi pendapatan
class Income extends Note {
  Income(int id, String description, double amount, DateTime date)
      : super(id, description, amount, date);
}

// Kelas untuk transaksi pengeluaran
class Expense extends Note {
  Expense(int id, String description, double amount, DateTime date)
      : super(id, description, amount, date);
}


