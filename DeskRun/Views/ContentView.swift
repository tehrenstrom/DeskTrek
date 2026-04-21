import SwiftUI

enum SidebarItem: String, Hashable, CaseIterable {
    case dashboard = "Trail Status"
    case connection = "Outfitter"
    case goals = "Provisions"
    case history = "Journal"
    case settings = "Camp"
}

struct ContentView: View {
    let appState: AppState

    @State private var selectedItem: SidebarItem? = .dashboard

    var body: some View {
        NavigationSplitView {
            List(SidebarItem.allCases, id: \.self, selection: $selectedItem) { item in
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
        .onChange(of: appState.treadmillState.connectionStatus) { oldValue, newValue in
            if newValue == .connected && oldValue != .connected {
                selectedItem = .dashboard
            }
        }
        .onAppear {
            appState.notificationManager.requestPermission()
        }
    }

    @ViewBuilder
    private func sidebarLabel(for item: SidebarItem) -> some View {
        switch item {
        case .dashboard:
            Label("Trail Status", systemImage: "gauge.with.dots.needle.33percent")
                .font(.system(size: 13, weight: .medium, design: .monospaced))
        case .connection:
            Label("Outfitter", systemImage: "antenna.radiowaves.left.and.right")
                .font(.system(size: 13, weight: .medium, design: .monospaced))
        case .goals:
            Label("Provisions", systemImage: "target")
                .font(.system(size: 13, weight: .medium, design: .monospaced))
        case .history:
            Label("Journal", systemImage: "book.closed")
                .font(.system(size: 13, weight: .medium, design: .monospaced))
        case .settings:
            Label("Camp", systemImage: "tent")
                .font(.system(size: 13, weight: .medium, design: .monospaced))
        }
    }
}
