import SwiftUI

struct DictationView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            Button("Play Audio") {
                if let question = viewModel.currentQuestion {
                    viewModel.playAudio(from: question.audioUrl)
                }
            }
            TextField("音声を文字起こししてください", text: $viewModel.textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("答えをチェック") {
                viewModel.checkAnswers()
            }
            .disabled(viewModel.isAnswered)
            if viewModel.isAnswered, let question = viewModel.currentQuestion {
                Text("正解: \(question.answers[0])")
                Button("次の質問") {
                    viewModel.goToNextQuestion()
                }
            }
        }
    }
}
