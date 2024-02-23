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
                viewModel.signUp(email: email, password: password)
            }

            if viewModel.isAuthenticated {
                // ログイン後のページに遷移
                if viewModel.isAuthenticated {
                    TopView(viewModel: viewModel)
                }

            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: AuthViewModel())
    }
}
