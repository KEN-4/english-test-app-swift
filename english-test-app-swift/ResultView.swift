import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ResultView: View {
    var scoreModel = ScoreModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("スコア").font(.title)
                ForEach(scoreModel.scores.keys.sorted(), id: \.self) { key in
                    Text("\(key.capitalized): \(scoreModel.scores[key]!, specifier: "%.1f")")
                }

                Text("おすすめの学習方法").font(.title).padding(.top)
                ForEach(getMostNeededStudyMethods(scores: scoreModel.scores), id: \.self) { recommendation in
                    Text(recommendation)
                }

                Button("ログアウト") {
                    try? Auth.auth().signOut()
                    // ログインページへの遷移ロジックをここに追加
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(10)
            }
            .padding()
        }
        .onAppear {
            saveResultsToFirestore(scoreModel: scoreModel)
        }
    }
}

func saveResultsToFirestore(scoreModel: ScoreModel) {
    guard let user = Auth.auth().currentUser else { return }
    let uid = user.uid
    let scores = scoreModel.scores

    let docRef = Firestore.firestore().collection("users").document(uid)
    docRef.updateData([
        "result_scores": scores
    ]) { error in
        if let error = error {
            print("Firestore保存エラー: \(error)")
        }
    }
}
