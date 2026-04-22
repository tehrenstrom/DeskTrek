import SwiftUI

enum MainSidebarItem: String, Hashable, CaseIterable {
    case dashboard
    case trail
    case trophies
    case badges
    case ambitions
    case journal
    case trailhead
    case settings

    var title: String {
        switch self {
        case .dashboard: return "Trail Status"
        case .trail: return "Trail"
        case .trophies: return "Trophy Wall"
        case .badges: return "Badges"
        case .ambitions: return "Ambitions"
        case .journal: return "Journal"
        case .trailhead: return "Trailhead"
        case .settings: return "Settings"
        }
    }

    var systemImage: String {
        switch self {
        case .dashboard: return "gauge.with.dots.needle.33percent"
        case .trail: return "map"
        case .trophies: return "rosette"
        case .badges: return "shield"
        case .ambitions: return "target"
        case .journal: return "book.closed"
        case .trailhead: return "signpost.right"
        case .settings: return "gearshape"
        }
    }
}

struct MainShell: View {
    let appState: AppState

    @State private var selectedItem: MainSidebarItem? = .dashboard

    var body: some View {
        NavigationSplitView {
            List(MainSidebarItem.allCases, id: \.self, selection: $selectedItem) { item in
                Label(item.title, systemImage: item.systemImage)
            }
            .navigationTitle("DeskTrek")
            .listStyle(.sidebar)
        } detail: {
            switch selectedItem {
            case .dashboard, .none:
                DashboardView(appState: appState, onOpenTrail: { selectedItem = .trail })
            case .trail:
                trailDetail
            case .trophies:
                TrophyWallView(appState: appState)
            case .badges:
                BadgesView(appState: appState)
            case .ambitions:
                GoalsView(appState: appState, onOpenTrail: { selectedItem = .trail })
            case .journal:
                HistoryView(appState: appState)
            case .trailhead:
                ConnectionView(state: appState.treadmillState, bleManager: appState.bleManager, settings: appState.settings)
            case .settings:
                SettingsView(appState: appState, onOpenTrail: { selectedItem = .trail })
            }
        }
        .frame(minWidth: 900, minHeight: 600)
        .preferredColorScheme(.light)
        .sheet(isPresented: Binding(
            get: { appState.journeyEngine.showCompletion },
            set: { appState.journeyEngine.showCompletion = $0 }
        )) {
            if let lastTrophy = appState.journeyStore.trophies.last,
               let trail = TrailCatalog.trail(for: lastTrophy.trailID) {
                FinaleView(
                    certificate: lastTrophy,
                    trail: trail,
                    appState: appState,
                    onDismiss: {
                        appState.journeyEngine.showCompletion = false
                        selectedItem = .trophies
                    }
                )
            } else {
                Color.clear
            }
        }
        .onChange(of: appState.treadmillState.connectionStatus) { oldValue, newValue in
            if newValue == .connected && oldValue != .connected {
                selectedItem = .dashboard
            }
        }
    }

    @ViewBuilder
    private var trailDetail: some View {
        if appState.journeyStore.active == nil {
            TrailPickerView(appState: appState)
        } else {
            JourneyMapView(appState: appState)
        }
    }
}
