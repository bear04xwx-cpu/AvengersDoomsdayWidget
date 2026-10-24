import SwiftUI

@main
struct AvengersDoomsdayWidgetApp: App {
    var body: some Scene {
        WindowGroup {
            CountdownHomeView()
                .preferredColorScheme(.dark)
        }
    }
}
