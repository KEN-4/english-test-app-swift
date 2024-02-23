import SwiftUI

struct DictationView: View {
    @ObservedObject var viewModel: DictationViewModel
    var scoreModel: ScoreModel

    var body: some View {
        VStack {
            if let question = viewModel.questions[safe: viewModel.currentQuestionIndex] {
                Text("音声を文字起こししてください")
                Button("Play Audio") {
                    viewModel.playAudio(from: question.audioUrl)
                }
                TextField("音声を文字起こししてください", text: $viewModel.textInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("答えをチェック") {
                    viewModel.checkAnswer()
                }
                .disabled(viewModel.isAnswered)
                if viewModel.isAnswered {
                    Text(viewModel.result ?? "")
                    Text("正解: \(question.answers[0])")
                    Button("次の質問") {
                        viewModel.goToNextQuestion()
                    }
                }
            } else {
                Text("質問をロード中...")
            }
            // ResultViewへの遷移を制御するNavigationLink
            NavigationLink(destination: ResultView(scoreModel: viewModel.scoreModel), isActive: $viewModel.showResultView) {
                EmptyView()
            }
        }
        .onAppear {
            viewModel.fetchQuestions()
        }
    }
}
