//
//  ApprovalRequest.swift
//  QuickApprovalCompanion
//
//  Created by nouransalah on 27/11/2026.
//

import Foundation

enum ApprovalStatus: String, CaseIterable, Identifiable {
    case pending
    case approved
    case rejected

    var id: String { rawValue }
}

enum ApprovalPriority: String {
    case high
    case medium
    case low
}

struct ApprovalRequest: Identifiable, Equatable {
    let id: String
    let referenceCode: String
    let title: String
    let requesterName: String
    let department: String
    let amount: Double
    let currencyCode: String
    let priority: ApprovalPriority
    let createdAt: Date
    let summaryNote: String
    var status: ApprovalStatus

    var formattedAmount: String {
        amount.formatted(
            .currency(code: currencyCode)
                .presentation(.narrow)
        )
    }
}
