import SwiftUI
import AVFoundation

struct ChoiceQuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    @State private var showingModal = false // モーダル表示のための状態変数

    var body: some View {
        VStack {
            if let question = viewModel.currentQuestion {
                Text("正しいと思う選択肢を選んでください")
                ForEach(question.sentences, id: \.self) { sentence in
                    Text(sentence)
                        .padding(.bottom, 8)
                }
                ForEach(question.choices, id: \.self) { choice in
                    Button(choice) {
                        viewModel.checkAnswer(choice: choice)
                    }
                    .disabled(viewModel.isAnswered)
                }
                if viewModel.isAnswered {
                    Text("正解: \(question.correctAnswer)")
                    Button("次の質問") {
                        // モーダルを表示するために状態変数をtrueに設定
                        showingModal = true
                    }
                }
            } else {
                Text("質問をロード中...")
            }
        }
        // ResultViewへのモーダル遷移を設定
        .fullScreenCover(isPresented: $showingModal) {
            // ここでモーダルとして表示したいビューを指定
            ResultView(scoreModel: viewModel.scoreModel)
        }
        .navigationTitle("Choice Question")
        .navigationBarTitleDisplayMode(.inline)
    }
}

