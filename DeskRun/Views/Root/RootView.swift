import SwiftUI

struct RootView: View {
    let appState: AppState

    var body: some View {
        Group {
            switch appState.settings.activeMode {
            case .some(.freeWalk):
                FreeWalkShell(appState: appState)
            case .some(.journey):
                JourneyShell(appState: appState)
            case .none:
                ModeSplashView(
                    onChoose: { mode in
                        appState.settings.activeMode = mode
                        appState.saveSettings()
                    }
                )
            }
        }
        .onAppear {
            appState.notificationManager.requestPermission()
        }
    }
}
