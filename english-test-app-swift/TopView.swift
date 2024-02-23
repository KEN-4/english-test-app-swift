import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct TopView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var userEmail: String = ""
    @State private var scores: [String: Double] = [:]

    var body: some View {
        NavigationView {
            VStack {
                if let user = Auth.auth().currentUser, !viewModel.isNewUser {
                    Text("Email: \(user.email ?? "不明")")
                    .padding()
                    // スコア表示
                    if !scores.isEmpty {
                        Text("前回のスコア")
                        ForEach(scores.keys.sorted(), id: \.self) { key in
                            Text("\(key): \(scores[key] ?? 0)")
                        }
                    }
                }
                
                NavigationLink(destination: L2QuestionView()) {
                    Text("診断開始")
                }
                .padding()
                Button("Log Out") {
                    // ログアウトしてログイン画面へ遷移する
                    viewModel.signOut()
                }
                // Firestoreからスコア情報を取得
                .onAppear {
                    fetchScores()
                }
            }
            .navigationTitle("English Test")
        }
    }
    
    private func fetchScores() {
        guard let user = Auth.auth().currentUser else { return }
        
        let docRef = Firestore.firestore().collection("users").document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                if let resultScores = data?["result_scores"] as? [String: Double] {
                    DispatchQueue.main.async {
                        self.scores = resultScores
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}


struct Top_Previews: PreviewProvider {
    static var previews: some View {
        TopView(viewModel: AuthViewModel())
    }
}
