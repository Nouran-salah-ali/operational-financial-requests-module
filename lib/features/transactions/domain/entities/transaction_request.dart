enum TransactionStatus {
  completed,
  pending,
  rejected,
}

enum TransactionPriority {
  low,
  medium,
  high,
}

class TransactionRequest {
  const TransactionRequest({
    required this.id,
    required this.referenceId,
    required this.title,
    required this.amount,
    required this.currency,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.notes = '',
  });

  final String id;
  final String referenceId;
  final String title;
  final double amount;
  final String currency;
  final TransactionPriority priority;
  final TransactionStatus status;
  final DateTime createdAt;
  final String notes;

  TransactionRequest copyWith({
    String? id,
    String? referenceId,
    String? title,
    double? amount,
    String? currency,
    TransactionPriority? priority,
    TransactionStatus? status,
    DateTime? createdAt,
    String? notes,
  }) {
    return TransactionRequest(
      id: id ?? this.id,
      referenceId: referenceId ?? this.referenceId,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
  }
}