import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    // イニシャライザメソッドを呼び出して、アプリの起動時に認証状態をチェックする
    init() {
            observeAuthChanges()
        }

        private func observeAuthChanges() {
            Auth.auth().addStateDidChangeListener { [weak self] _, user in
                DispatchQueue.main.async {
                    self?.isAuthenticated = user != nil
                }
            }
        }
    // ログインするメソッド
    func signIn(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                DispatchQueue.main.async {
                    if result != nil, error == nil {
                        self?.isAuthenticated = true
                    }
                }
            }
        }
    // 新規登録するメソッド
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                guard let self = self else { return }

                if let error = error {
                    // エラーハンドリング
                    print("登録に失敗しました：\(error.localizedDescription)")
                } else if let user = result?.user {
                    self.isAuthenticated = true
                    // Firestoreにユーザー情報を保存
                    self.saveUserInfo(user: user, email: email)
                }
            }
        }
    }

    // Firestoreにユーザー情報を保存するメソッド
    private func saveUserInfo(user: User, email: String) {
        let uid = user.uid
        let userData = [
            "createdAt": Timestamp(date: Date()),
            "email": email,
            "result_scores": ["grammar": 0, "listening": 0, "speaking": 0, "vocabulary": 0]
        ] as [String : Any]

        Firestore.firestore().collection("users").document(uid).setData(userData) { error in
            if let error = error {
                print("Firestoreへの保存に失敗しました：\(error.localizedDescription)")
            } else {
                print("ユーザー情報をFirestoreに保存しました。")
            }
        }
    }
    
    // パスワードをリセットするメソッド
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error in sending password reset: \(error)")
            }
        }
    }
    // ログアウトするメソッド
    func signOut() {
            do {
                try Auth.auth().signOut()
                isAuthenticated = false
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
}
