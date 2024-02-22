import SwiftUI
import FirebaseCore

@main
struct EnglishTestAppSwiftApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            // ログイン状態によって表示するページを変更する
            if viewModel.isAuthenticated {
                TopView(viewModel: viewModel) // ログイン後に表示するページ
            } else {
                SignInView(viewModel: viewModel) // ログインページ
            }
        }
    }
}
