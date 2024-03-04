import SwiftUI
import DGCharts
import FirebaseAuth
import FirebaseFirestore

struct ResultView: View {
    var scoreModel = ScoreModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("スコア").font(.title)
            ForEach(scoreModel.scores.keys.sorted(), id: \.self) { key in
                Text("\(key.capitalized): \(scoreModel.scores[key]!, specifier: "%.1f")")
            }
            RadarChartViewRepresentable(entries: [
                RadarChartDataEntry(value: scoreModel.scores["listening"] ?? 0),
                RadarChartDataEntry(value: scoreModel.scores["speaking"] ?? 0),
                RadarChartDataEntry(value: scoreModel.scores["grammar"] ?? 0),
                RadarChartDataEntry(value: scoreModel.scores["vocabulary"] ?? 0)
            ])
            .frame(height: 300) // チャートの高さを指定
            Text("おすすめの学習方法").font(.title).padding(.top)
            ForEach(getMostNeededStudyMethods(scores: scoreModel.scores), id: \.self) { recommendation in
                Text(recommendation)
            }
        }
    }
}
