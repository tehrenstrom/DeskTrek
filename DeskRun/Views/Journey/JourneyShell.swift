import SwiftUI

enum JourneySidebarItem: String, Hashable, CaseIterable {
    case trail = "Trail"
    case dashboard = "Free Walk"
    case outfitter = "Outfitter"
    case journal = "Journal"
    case trophies = "Trophy Wall"
    case badges = "Badges"
    case camp = "Camp"
}

struct JourneyShell: View {
    let appState: AppState

    @State private var selectedItem: JourneySidebarItem? = .trail

    var body: some View {
        NavigationSplitView {
            List(JourneySidebarItem.allCases, id: \.self, selection: $selectedItem) { item in
                sidebarLabel(for: item)
            }
            .navigationTitle("DeskRun")
            .listStyle(.sidebar)
        } detail: {
            switch selectedItem {
            case .trail:
                trailDetail
            case .dashboard:
                VStack(spacing: 0) {
                    freeWalkBanner
                    DashboardView(appState: appState)
                }
            case .outfitter:
                ConnectionView(state: appState.treadmillState, bleManager: appState.bleManager)
            case .journal:
                HistoryView(appState: appState)
            case .trophies:
                TrophyWallView(appState: appState)
            case .badges:
                BadgesView(appState: appState)
            case .camp:
                SettingsView(appState: appState)
            case .none:
                trailDetail
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
    }

    @ViewBuilder
    private var trailDetail: some View {
        if appState.journeyStore.active == nil {
            TrailPickerView(appState: appState)
        } else {
            JourneyMapView(appState: appState)
        }
    }

    @ViewBuilder
    private func sidebarLabel(for item: JourneySidebarItem) -> some View {
        switch item {
        case .trail:
            Label("Trail", systemImage: "map")
        case .dashboard:
            Label("Free Walk", systemImage: "figure.walk")
        case .outfitter:
            Label("Outfitter", systemImage: "antenna.radiowaves.left.and.right")
        case .journal:
            Label("Journal", systemImage: "book.closed")
        case .trophies:
            Label("Trophy Wall", systemImage: "rosette")
        case .badges:
            Label("Badges", systemImage: "shield")
        case .camp:
            Label("Camp", systemImage: "tent")
        }
    }

    @ViewBuilder
    private var freeWalkBanner: some View {
        if appState.journeyStore.active != nil {
            let enabled = appState.journeyEngine.isTrackingEnabled
            HStack(spacing: 10) {
                Image(systemName: enabled ? "figure.hiking" : "pause.circle")
                    .foregroundStyle(enabled ? TrailColor.coral : TrailColor.forestGreen)
                Text(enabled
                     ? "Walks right now count toward your journey."
                     : "Journey tracking is paused — walk freely, no miles will count.")
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundStyle(TrailColor.text)
                Spacer()
                Button(enabled ? "Pause Journey" : "Resume Journey") {
                    appState.journeyEngine.setTrackingEnabled(!enabled)
                }
                .buttonStyle(RetroSecondaryButtonStyle())
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(enabled ? TrailColor.desertSand.opacity(0.35) : TrailColor.forestGreen.opacity(0.2))
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(TrailColor.darkEarth.opacity(0.3)),
                alignment: .bottom
            )
        }
    }
}
