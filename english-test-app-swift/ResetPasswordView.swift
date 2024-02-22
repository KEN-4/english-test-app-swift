import SwiftUI

struct ResetPasswordView: View {
    @State private var email: String = ""
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Reset Password") {
                viewModel.resetPassword(email: email)
            }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(viewModel: AuthViewModel())
    }
}
