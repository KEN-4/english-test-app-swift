import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $email)
                    .autocapitalization(.none) // 自動大文字化を無効にする
                    .keyboardType(.emailAddress) // キーボードタイプをメールアドレス用に設定
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Sign In") {
                    viewModel.signIn(email: email, password: password)
                }

                if viewModel.isAuthenticated {
                    // ログイン後のページに遷移
                    TopView(viewModel: viewModel)
                }

                // 新規登録画面への遷移ボタン
                NavigationLink(destination: SignUpView(viewModel: viewModel)) {
                    Text("Create Account")
                        .padding(.top, 16)
                }
                // パスワードのリセットページへ移動する
                NavigationLink(destination: ResetPasswordView(viewModel: viewModel)) {
                    Text("Password Reset")
                        .padding(.top, 16)
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: AuthViewModel())
    }
}
