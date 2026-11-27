import 'dart:math';

import 'package:financial_requests_module/core/error/app_exception.dart';
import 'package:financial_requests_module/core/network/network_client.dart';
import 'package:financial_requests_module/features/transactions/data/models/transaction_request_dto.dart';
import 'package:financial_requests_module/features/transactions/domain/entities/transaction_request.dart';

class TransactionsRemoteOrMockDataSource {
  TransactionsRemoteOrMockDataSource({
    NetworkClient? networkClient,
  }) : _networkClient = networkClient ?? const NetworkClient();

  final NetworkClient _networkClient;
  final Random _random = Random();

  final _items = [
    {
      'id': 'req-101',
      'reference_id': 'TRX-2026-0841',
      'title': 'Cloud Infrastructure Renewal',
      'amount': 4850.0,
      'currency': 'SAR',
      'priority': 'high',
      'status': 'pending',
      'created_at': '2026-11-24T09:30:00.000Z',
      'notes': 'Annual production cluster & database hosting invoice.',
    },
    {
      'id': 'req-102',
      'reference_id': 'TRX-2026-0842',
      'title': 'Vendor Settlement - Logistics',
      'amount': 12300.5,
      'currency': 'SAR',
      'priority': 'medium',
      'status': 'completed',
      'created_at': '2026-11-22T14:15:00.000Z',
      'notes': 'Monthly regional fulfillment settlement batch.',
    },
    {
      'id': 'req-103',
      'reference_id': 'TRX-2026-0843',
      'title': 'Hardware Peripheral Purchase',
      'amount': '920.75',
      'currency': 'SAR',
      'priority': 'low',
      'status': 'rejected',
      'created_at': '2026-11-20T11:00:00.000Z',
      'notes': null,
    },
    {
      'id': 'req-104',
      'reference_id': 'TRX-2026-0844',
      'title': 'Security Audit Retainer',
      'amount': 7500,
      'currency': 'SAR',
      'priority': 'high',
      'status': 'pending',
      'created_at': '2026-11-26T16:45:00.000Z',
      'notes': 'Q4 penetration testing & compliance review.',
    },
  ];

  Future<List<TransactionRequestDto>> getTransactions({
    bool simulateError = false,
    bool simulateEmpty = false,
    bool simulateMalformedPayload = false,
  }) {
    return _networkClient.execute(() async {
      if (simulateError) {
        throw const AppException(
          type: AppErrorType.network,
          message: 'Unable to reach transactions service. Please retry.',
          code: '503_SERVICE_UNAVAILABLE',
        );
      }

      if (simulateEmpty) {
        return <TransactionRequestDto>[];
      }

      final payload = simulateMalformedPayload
          ? [
        ..._items,
        {
          'id': '',
          'reference_id': null,
          'title': '',
        },
      ]
          : _items;

      return payload.map(TransactionRequestDto.fromJson).toList();
    });
  }

  Future<TransactionRequestDto> createTransaction({
    required String title,
    required double amount,
    required String currency,
    required TransactionPriority priority,
    required String notes,
  }) {
    return _networkClient.execute(() async {
      final suffix = 1000 + _random.nextInt(9000);
      final newMap = {
        'id': 'req-${DateTime.now().millisecondsSinceEpoch}',
        'reference_id': 'TRX-2026-$suffix',
        'title': title.trim(),
        'amount': amount,
        'currency': currency.trim().isEmpty ? 'SAR' : currency.trim(),
        'priority': priority.name,
        'status': TransactionStatus.pending.name,
        'created_at': DateTime.now().toUtc().toIso8601String(),
        'notes': notes.trim(),
      };

      _items.insert(0, newMap);
      return TransactionRequestDto.fromJson(newMap);
    });
  }

  Future<TransactionRequestDto> updateStatus({
    required String id,
    required TransactionStatus status,
  }) {
    return _networkClient.execute(() async {
      final index = _items.indexWhere((item) => item['id'] == id);
      if (index == -1) {
        throw const AppException(
          type: AppErrorType.malformedData,
          message: 'Transaction record was not found.',
          code: 'NOT_FOUND',
        );
      }

      _items[index] = {
        ..._items[index],
        'status': status.name,
      };

      return TransactionRequestDto.fromJson(_items[index]);
    });
  }
}