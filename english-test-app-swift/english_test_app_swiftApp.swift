import SwiftUI
import FirebaseCore

@main
struct EnglishTestAppSwiftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @StateObject var viewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            TopView()
        }
    }
}
