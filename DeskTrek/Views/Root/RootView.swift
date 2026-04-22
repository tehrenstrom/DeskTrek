import SwiftUI

struct RootView: View {
    let appState: AppState

    var body: some View {
        MainShell(appState: appState)
            .onAppear {
                appState.notificationManager.requestPermission()
            }
    }
}
