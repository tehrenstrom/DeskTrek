import SwiftUI

@main
struct DeskRunApp: App {
    @State private var treadmillState = TreadmillState()
    @State private var bleManager: TreadmillBLEManager

    init() {
        let state = TreadmillState()
        _treadmillState = State(initialValue: state)
        _bleManager = State(initialValue: TreadmillBLEManager(state: state))
    }

    var body: some Scene {
        WindowGroup {
            ContentView(state: treadmillState, bleManager: bleManager)
        }
        MenuBarExtra("DeskRun", systemImage: "figure.walk") {
            MenuBarView(state: treadmillState, bleManager: bleManager)
        }
    }
}
