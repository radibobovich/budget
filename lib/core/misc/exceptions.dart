class TransactionNotFoundException implements Exception {
  final int id;
  const TransactionNotFoundException(this.id);

  @override
  String toString() {
    return 'Transaction with id $id not found';
  }
}
