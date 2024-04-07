import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Sign Up") {
                // UserDefaultsからスコアを読み込む試み
                let scoresFromUserDefaults = viewModel.loadScoresFromUserDefaults()
                let defaultScores = ["listening": 0.0, "speaking": 0.0, "grammar": 0.0, "vocabulary": 0.0]
                // UserDefaultsにスコアがあるかどうかを確認し、あればそれを使用し、なければデフォルト値を使用
                let scoresToUse = scoresFromUserDefaults ?? defaultScores
                
                viewModel.signUp(email: email, password: password, scores: scoresToUse)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: AuthViewModel())
    }
}
