import SwiftUI
import DGCharts
import FirebaseAuth
import FirebaseFirestore

struct ResultView: View {
    var scoreModel = ScoreModel()
    @State private var shareText: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("スコア").font(.title)
                RadarChartViewRepresentable(entries: [
                    RadarChartDataEntry(value: scoreModel.scores["listening"] ?? 0),
                    RadarChartDataEntry(value: scoreModel.scores["speaking"] ?? 0),
                    RadarChartDataEntry(value: scoreModel.scores["grammar"] ?? 0),
                    RadarChartDataEntry(value: scoreModel.scores["vocabulary"] ?? 0)
                ])
                .frame(height: 400) // 適切な高さに調整
                Text("おすすめの学習方法").font(.title).padding(.top)
                ForEach(getMostNeededStudyMethods(scores: scoreModel.scores), id: \.self) { recommendation in
                    Text(recommendation)
                }
                
                ShareLink(item: shareText) {
                    Label("スコアを共有", systemImage: "square.and.arrow.up")
                }
            }
            .navigationBarTitle("テスト結果", displayMode: .inline)
            .onAppear {
                // ビューが表示されるときに共有テキストを初期化
                shareText = formatShareText()
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
