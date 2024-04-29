import SwiftUI
import SwiftData
import FirebaseCore

@main
struct EnglishTestAppSwift: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            LaunchScreen()
                .environmentObject(viewModel)
                .modelContainer(for: UserData.self)
        }
    }
}
