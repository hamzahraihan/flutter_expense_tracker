class TransactionsData {
  final int id;
  final String title;
  final double amount;
  final DateTime date;

  TransactionsData({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}

List<TransactionsData> transactionsDataList = [
  TransactionsData(
    id: 1,
    title: 'Shopping',
    amount: 200.00,
    date: DateTime(1996, 7, 10, 17, 8),
  ),
  TransactionsData(
    id: 2,
    title: 'Groceries',
    amount: 45.75,
    date: DateTime(2023, 12, 27, 10, 15),
  ),
  TransactionsData(
    id: 3,
    title: 'Electricity Bill',
    amount: 90.50,
    date: DateTime(2023, 12, 25, 9, 30),
  ),
  TransactionsData(
    id: 4,
    title: 'Internet Subscription',
    amount: 50.00,
    date: DateTime(2023, 12, 20, 14, 0),
  ),
  TransactionsData(
    id: 5,
    title: 'Dining Out',
    amount: 120.00,
    date: DateTime(2023, 12, 26, 20, 45),
  ),
  TransactionsData(
    id: 6,
    title: 'Car Maintenance',
    amount: 300.00,
    date: DateTime(2023, 12, 15, 11, 30),
  ),
  TransactionsData(
    id: 7,
    title: 'Gym Membership',
    amount: 40.00,
    date: DateTime(2023, 12, 5, 6, 0),
  ),
  TransactionsData(
    id: 8,
    title: 'Gift Purchase',
    amount: 150.00,
    date: DateTime(2023, 12, 18, 16, 20),
  ),
  TransactionsData(
    id: 9,
    title: 'Fuel',
    amount: 65.00,
    date: DateTime(2023, 12, 22, 8, 0),
  ),
  TransactionsData(
    id: 10,
    title: 'Movie Night',
    amount: 25.00,
    date: DateTime(2023, 12, 28, 21, 30),
  ),
];
