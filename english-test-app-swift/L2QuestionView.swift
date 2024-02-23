import SwiftUI

struct L2QuestionView: View {
    @ObservedObject var viewModel = L2QuestionViewModel()

    var body: some View {
        VStack {
            if let question = viewModel.questions[safe: viewModel.currentQuestionIndex] {
                Text("発音した単語を選んでください")
                Button("Play Audio") {
                    viewModel.playAudio(from: question.audioUrl)
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
                        viewModel.goToNextQuestion()
                    }
                }
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

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

#Preview {
    L2QuestionView()
}
