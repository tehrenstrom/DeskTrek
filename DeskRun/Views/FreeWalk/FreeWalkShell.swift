import SwiftUI

enum FreeWalkSidebarItem: String, Hashable, CaseIterable {
    case dashboard = "Trail Status"
    case connection = "Outfitter"
    case goals = "Provisions"
    case history = "Journal"
    case settings = "Camp"
}

struct FreeWalkShell: View {
    let appState: AppState

    @State private var selectedItem: FreeWalkSidebarItem? = .dashboard

    var body: some View {
        NavigationSplitView {
            List(FreeWalkSidebarItem.allCases, id: \.self, selection: $selectedItem) { item in
                sidebarLabel(for: item)
            }
            .navigationTitle("DeskRun")
            .listStyle(.sidebar)
        } detail: {
            switch selectedItem {
            case .dashboard:
                DashboardView(appState: appState)
            case .connection:
                ConnectionView(state: appState.treadmillState, bleManager: appState.bleManager)
            case .goals:
                GoalsView(appState: appState)
            case .history:
                HistoryView(appState: appState)
            case .settings:
                SettingsView(appState: appState)
            case .none:
                DashboardView(appState: appState)
            }
        }
        .frame(minWidth: 750, minHeight: 550)
        .preferredColorScheme(.light)
        .onChange(of: appState.treadmillState.connectionStatus) { oldValue, newValue in
            if newValue == .connected && oldValue != .connected {
                selectedItem = .dashboard
            }
        }
    }

    @ViewBuilder
    private func sidebarLabel(for item: FreeWalkSidebarItem) -> some View {
        switch item {
        case .dashboard:
            Label("Trail Status", systemImage: "gauge.with.dots.needle.33percent")
        case .connection:
            Label("Outfitter", systemImage: "antenna.radiowaves.left.and.right")
        case .goals:
            Label("Provisions", systemImage: "target")
        case .history:
            Label("Journal", systemImage: "book.closed")
        case .settings:
            Label("Camp", systemImage: "tent")
        }
    }
}
