import 'package:financial_requests_module/core/error/app_exception.dart';
import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';

class TransactionRequestDto {
  const TransactionRequestDto({
    required this.id,
    required this.referenceId,
    required this.title,
    required this.amount,
    required this.currency,
    required this.priority,
    required this.status,
    required this.createdAt,
    required this.notes,
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

  factory TransactionRequestDto.fromJson(Map<String, dynamic> json) {
    final id = _readString(json['id']);
    final referenceId = _readString(json['reference_id']);
    final title = _readString(json['title']);

    if (id.isEmpty || referenceId.isEmpty || title.isEmpty) {
      throw const AppException(
        type: AppErrorType.malformedData,
        message: 'Missing required transaction fields in payload.',
      );
    }

    return TransactionRequestDto(
      id: id,
      referenceId: referenceId,
      title: title,
      amount: _readDouble(json['amount']),
      currency: _readString(json['currency'], fallback: 'SAR'),
      priority: _parsePriority(json['priority']),
      status: _parseStatus(json['status']),
      createdAt: _parseDate(json['created_at']),
      notes: _readString(json['notes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference_id': referenceId,
      'title': title,
      'amount': amount,
      'currency': currency,
      'priority': priority.name,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'notes': notes,
    };
  }

  TransactionRequest toEntity() {
    return TransactionRequest(
      id: id,
      referenceId: referenceId,
      title: title,
      amount: amount,
      currency: currency,
      priority: priority,
      status: status,
      createdAt: createdAt,
      notes: notes,
    );
  }

  static String _readString(dynamic value, {String fallback = ''}) {
    if (value is String) return value.trim();
    if (value is num || value is bool) return value.toString();
    return fallback;
  }

  static double _readDouble(dynamic value, {double fallback = 0.0}) {
    if (value is double) {
      return value.isFinite ? value : fallback;
    }
    if (value is int) return value.toDouble();
    if (value is String) {
      final parsed = double.tryParse(value.trim());
      if (parsed != null && parsed.isFinite) return parsed;
    }
    return fallback;
  }

  static TransactionStatus _parseStatus(dynamic value) {
    final normalized = _readString(value, fallback: 'pending').toLowerCase();
    switch (normalized) {
      case 'completed':
      case 'approved':
        return TransactionStatus.completed;
      case 'rejected':
      case 'declined':
        return TransactionStatus.rejected;
      case 'pending':
      default:
        return TransactionStatus.pending;
    }
  }

  static TransactionPriority _parsePriority(dynamic value) {
    final normalized = _readString(value, fallback: 'medium').toLowerCase();
    switch (normalized) {
      case 'high':
        return TransactionPriority.high;
      case 'low':
        return TransactionPriority.low;
      case 'medium':
      default:
        return TransactionPriority.medium;
    }
  }

  static DateTime _parseDate(dynamic value) {
    if (value is String && value.trim().isNotEmpty) {
      final parsed = DateTime.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
    return DateTime.now();
  }
}