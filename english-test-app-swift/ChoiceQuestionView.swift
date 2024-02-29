import SwiftUI
import AVFoundation

struct ChoiceQuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        NavigationView {
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
        }
    }
}
