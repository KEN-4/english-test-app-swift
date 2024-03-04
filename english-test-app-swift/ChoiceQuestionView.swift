import SwiftUI
import AVFoundation

struct ChoiceQuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    @State private var showingModal = false

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
                        viewModel.goToNextQuestion()
                    }
                    .disabled(viewModel.isAnswered)
                }
                if viewModel.isAnswered {
                    Text("正解: \(question.correctAnswer)")
                    Button("次の質問") {
                    }
                }
            } else {
                Text("質問をロード中...")
            }
        }
        // ResultViewへのモーダル遷移をviewModel.showResultViewに基づいて設定
        .fullScreenCover(isPresented: $viewModel.showResultView) {
            // ここでモーダルとして表示したいビューを指定
            ResultView(scoreModel: viewModel.scoreModel)
        }
        .navigationTitle("Choice Question")
        .navigationBarTitleDisplayMode(.inline)
    }
}

