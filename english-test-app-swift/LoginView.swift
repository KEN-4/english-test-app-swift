import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var infoText: String = ""

    var body: some View {
        VStack {
            TextField("メールアドレス", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("パスワード", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("ログイン") {
                login()
            }
            .padding()
            Text(infoText)
        }
        .padding()
    }
    
    func login() {
        // Firebase Authを使用してログインを試みるロジックをここに記述
    }
}
