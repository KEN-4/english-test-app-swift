import SwiftUI
import FirebaseCore

@main
struct EnglishTestAppSwiftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            if viewModel.isAuthenticated {
                TopView(viewModel: viewModel)
            } else {
                SignInView(viewModel: viewModel)
            }
        }
    }
}
