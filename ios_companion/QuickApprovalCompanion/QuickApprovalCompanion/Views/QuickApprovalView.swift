//
//  QuickApprovalView.swift
//  QuickApprovalCompanion
//
//  Created by nouransalah on 27/11/2026.
//



import SwiftUI

struct QuickApprovalView: View {
    @StateObject private var viewModel = QuickApprovalViewModel()
    @Environment(\.colorScheme) private var colorScheme
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if viewModel.isLoading {
                        loadingCard
                    } else if let request = viewModel.request {
                        summaryCard(for: request)
                        actionSection(for: request)
                    }

                    if let message = viewModel.feedbackMessage {
                        feedbackBanner(message: message, isError: viewModel.isErrorFeedback)
                    }
                }
                .padding()
                .frame(maxWidth: 600)
                .frame(maxWidth: .infinity)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Quick Approval")
            .task {
                if viewModel.request == nil {
                    await viewModel.loadPendingRequest()
                }
            }
        }
    }

    private var loadingCard: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text("Loading request summary...")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16))
    }

    private func summaryCard(for request: ApprovalRequest) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(request.referenceCode)
                        .font(.caption.monospaced())
                        .foregroundStyle(.secondary)
                    Text(request.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                }
                Spacer()
                statusBadge(for: request.status)
            }

            Text(request.formattedAmount)
                .font(.title2.bold())
                .foregroundStyle(.primary)

            Divider()

            LabeledContent("Requester", value: request.requesterName)
                .font(.subheadline)
            LabeledContent("Department", value: request.department)
                .font(.subheadline)

            Text(request.summaryNote)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .padding(.top, 2)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16))
    }

    private func actionSection(for request: ApprovalRequest) -> some View {
        VStack(spacing: 10) {
            if request.status == .pending {
                Button {
                    Task { await viewModel.approveRequest() }
                } label: {
                    HStack {
                        Image(systemName: "faceid")
                        Text("Approve with Biometrics / Passcode")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(colorScheme == .dark ? Color(red: 0.067, green: 0.094, blue: 0.153) : .white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.accentColor)
                .disabled(viewModel.isProcessingAction)
                

                Button(role: .destructive) {
                    Task { await viewModel.rejectRequest() }
                } label: {
                    Text("Reject Request")
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.bordered)
                .disabled(viewModel.isProcessingAction)
            } else {
                Button {
                    Task { await viewModel.loadPendingRequest() }
                } label: {
                    Label("Reset Sample Request", systemImage: "arrow.clockwise")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(.bordered)
            }

            if viewModel.isProcessingAction {
                ProgressView("Verifying...")
                    .font(.caption)
                    .padding(.top, 4)
            }
        }
    }

    private func statusBadge(for status: ApprovalStatus) -> some View {
        Text(status.rawValue.capitalized)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(badgeColor(for: status).opacity(0.16), in: Capsule())
            .foregroundStyle(badgeColor(for: status))
    }

    private func badgeColor(for status: ApprovalStatus) -> Color {
        switch status {
        case .pending:
            return .orange
        case .approved:
            return Color("ApprovalSuccessColor")
        case .rejected:
            return .red
        }
    }

    private func feedbackBanner(message: String, isError: Bool) -> some View {
        let bannerColor = isError ? Color.red : Color("ApprovalSuccessColor")

        return HStack(spacing: 10) {
            Image(systemName: isError ? "exclamationmark.triangle.fill" : "checkmark.circle.fill")
                .foregroundStyle(bannerColor)
            Text(message)
                .font(.footnote)
                .foregroundStyle(.primary)
            Spacer()
        }
        .padding(12)
        .background(
            bannerColor.opacity(0.12),
            in: RoundedRectangle(cornerRadius: 12)
        )
    }
}

#Preview("LTR") {
    QuickApprovalView()
}

#Preview("RTL") {
    QuickApprovalView()
        .environment(\.layoutDirection, .rightToLeft)
}
