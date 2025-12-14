class TempWallet {
  final String name;
  final double balance;
  // Add these two new fields
  final String holderName;
  final String lastFourDigit;

  TempWallet({
    required this.name,
    required this.balance,
    required this.holderName,
    required this.lastFourDigit,
  });
}
