import SwiftUI

@main
struct DeskTrekApp: App {
    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView(appState: appState)
        }
        MenuBarExtra("DeskTrek", systemImage: "figure.walk") {
            MenuBarView(appState: appState)
        }
        .menuBarExtraStyle(.window)
    }
}
