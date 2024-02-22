import SwiftUI

struct TopView: View {
    var viewModel: AuthViewModel

    var body: some View {
        VStack {
            Text("Hello, you're logged in!")
                .font(.title)
                .padding()
            Button("Log Out") {
                // ログアウトしてログイン画面へ遷移する
                viewModel.signOut()
            }
        }
    }
}

struct Top_Previews: PreviewProvider {
    static var previews: some View {
        TopView(viewModel: AuthViewModel())
    }
}
