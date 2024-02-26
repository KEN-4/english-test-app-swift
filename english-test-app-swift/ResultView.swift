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
            }
        }
    }
}
