import SwiftUI
import DGCharts
import FirebaseAuth
import FirebaseFirestore

struct ResultView: View {
    var scoreModel = ScoreModel()
    @State private var shareText: String = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("スコア").font(.title)
                    RadarChartViewRepresentable(entries: [
                        RadarChartDataEntry(value: scoreModel.scores["listening"] ?? 0),
                        RadarChartDataEntry(value: scoreModel.scores["speaking"] ?? 0),
                        RadarChartDataEntry(value: scoreModel.scores["grammar"] ?? 0),
                        RadarChartDataEntry(value: scoreModel.scores["vocabulary"] ?? 0)
                    ])
                    .frame(height: 400) // 適切な高さに調整
                    Text("あなたの動物タイプは").font(.title).padding(.top)
                    // ここに動物タイプを出力
                    Text(getAnimalType(scores: scoreModel.scores))
                        .font(.title2)
                        .padding()
                    Text("おすすめの学習方法").font(.title).padding(.top)
                    if let recommendation = getMostNeededStudyMethod(scores: scoreModel.scores) {
                        Text(recommendation)
                    } else {
                        Text("学習方法の推薦が利用できません")
                    }
                    ShareLink(item: shareText) {
                        Label("スコアを共有", systemImage: "square.and.arrow.up")
                    }
                }
                .navigationBarTitle("テスト結果")
                .onAppear {
                    // ビューが表示されるときに共有テキストを初期化
                    shareText = formatShareText()
                }
            }
        }
    }
    
    func formatShareText() -> String {
        // スコアのデータをテキストとして整形
        let text = """
        スコア
        リスニング: \(scoreModel.scores["listening"] ?? 0)
        スピーキング: \(scoreModel.scores["speaking"] ?? 0)
        文法: \(scoreModel.scores["grammar"] ?? 0)
        語彙: \(scoreModel.scores["vocabulary"] ?? 0)
        """
        return text
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewModel: QuestionViewModel())
    }
}
