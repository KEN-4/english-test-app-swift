import SwiftUI

struct L2QuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            if let question = viewModel.currentQuestion {
                Text("発音した単語を選んでください")
                Button("Play Audio") {
                    viewModel.playAudio(from: question.audioUrl)
                }
                ForEach(question.choices, id: \.self) { choice in
                    Button(action: {
                        viewModel.selectedChoice = choice
                    }) {
                        Text(choice)
                            .padding()
                            .foregroundColor(.white)
                            .background(viewModel.selectedChoice == choice ? Color.green : Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.isAnswered)
                }
                
                Spacer()
                
                if !viewModel.isAnswered {
                    Button("送信") {
                        viewModel.submitAnswer()
                    }
                    .disabled(viewModel.selectedChoice == nil)
                    .padding()
                    .background(viewModel.selectedChoice != nil ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                } else {
                    Text("正解: \(question.correctAnswer)")
                    Button("次の質問") {
                        viewModel.goToNextQuestion()
                    }
                }
            } else {
                Text("質問をロード中...")
            }
        }
    }
}
