import SwiftUI

@main
struct DeskRunApp: App {
    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView(appState: appState)
        }
        MenuBarExtra("DeskRun", systemImage: "figure.walk") {
            MenuBarView(appState: appState)
        }
        .menuBarExtraStyle(.window)
    }
}
