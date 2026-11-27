//
//  QuickApprovalViewModel.swift
//  QuickApprovalCompanion
//
//  Created by nouransalah on 27/11/2026.
//

import Foundation
import LocalAuthentication
import SwiftUI
import Combine

@MainActor
final class QuickApprovalViewModel: ObservableObject {
    @Published private(set) var request: ApprovalRequest?
    @Published private(set) var isLoading = false
    @Published private(set) var isProcessingAction = false
    @Published var feedbackMessage: String?
    @Published var isErrorFeedback = false

    private let contextFactory: () -> LAContext

    init(contextFactory: @escaping () -> LAContext = { LAContext() }) {
        self.contextFactory = contextFactory
    }

    func loadPendingRequest() async {
        isLoading = true
        feedbackMessage = nil
        isErrorFeedback = false

        // Simulated async network fetch
        try? await Task.sleep(for: .milliseconds(600))

        request = ApprovalRequest(
            id: "req-1042",
            referenceCode: "FIN-2026-1042",
            title: "Q4 Cloud & Analytics Infrastructure Renewal",
            requesterName: "Nouran Hassanin",
            department: "Product & Engineering",
            amount: 14500.00,
            currencyCode: "SAR",
            priority: .high,
            createdAt: .now,
            summaryNote: "Annual reserved capacity and monitoring seats for production environments.",
            status: .pending
        )
        isLoading = false
    }

    func approveRequest() async {
        guard let currentRequest = request, !isProcessingAction else { return }
        await performDecision(
            targetStatus: .approved,
            reason: "Confirm approval for \(currentRequest.referenceCode)",
            successText: "Request \(currentRequest.referenceCode) approved."
        )
    }

    func rejectRequest() async {
        guard let currentRequest = request, !isProcessingAction else { return }
        await performDecision(
            targetStatus: .rejected,
            reason: "Confirm rejection for \(currentRequest.referenceCode)",
            successText: "Request \(currentRequest.referenceCode) rejected."
        )
    }

    private func performDecision(
        targetStatus: ApprovalStatus,
        reason: String,
        successText: String
    ) async {
        isProcessingAction = true
        feedbackMessage = nil
        defer { isProcessingAction = false }

        let verified = await authenticateUser(reason: reason)
        guard verified else {
            isErrorFeedback = true
            feedbackMessage = "Verification cancelled or failed. Action was not applied."
            return
        }

        // Simulated async status persistence
        try? await Task.sleep(for: .milliseconds(450))

        request?.status = targetStatus
        isErrorFeedback = false
        feedbackMessage = successText
    }

    private func authenticateUser(reason: String) async -> Bool {
        let context = contextFactory()
        var error: NSError?

        let policy: LAPolicy = .deviceOwnerAuthentication
        guard context.canEvaluatePolicy(policy, error: &error) else {
            // Allow smooth flow on simulators without enrolled biometrics/passcode
            #if targetEnvironment(simulator)
            return true
            #else
            return false
            #endif
        }

        return await withCheckedContinuation { continuation in
            context.evaluatePolicy(policy, localizedReason: reason) { success, _ in
                continuation.resume(returning: success)
            }
        }
    }
}
