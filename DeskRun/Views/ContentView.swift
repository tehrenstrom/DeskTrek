import SwiftUI

struct ContentView: View {
    let state: TreadmillState
    let bleManager: TreadmillBLEManager

    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink {
                    ConnectionView(state: state, bleManager: bleManager)
                } label: {
                    Label("Connection", systemImage: "antenna.radiowaves.left.and.right")
                }

                NavigationLink {
                    DashboardView(state: state, bleManager: bleManager)
                } label: {
                    Label("Dashboard", systemImage: "gauge.with.dots.needle.33percent")
                }
            }
            .navigationTitle("DeskRun")
            .listStyle(.sidebar)
        } detail: {
            if state.connectionStatus == .connected {
                DashboardView(state: state, bleManager: bleManager)
            } else {
                ConnectionView(state: state, bleManager: bleManager)
            }
        }
        .frame(minWidth: 700, minHeight: 500)
    }
}
