import SwiftUI

struct VoiceChoiceQuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            if let question = viewModel.currentQuestion {
                Text("音声の続きの選択肢を選んでください")
                    .padding()
                Button("Play Audio") {
                    viewModel.playAudio(from: question.audioUrl)
                }
                .padding()
                ForEach(question.choices, id: \.self) { choice in
                    Button(action: {
                        viewModel.selectedChoice = choice
                    }) {
                        Text(choice)
                            .padding()
                            .foregroundColor(viewModel.selectedChoice == choice ? .black : .white)
                            .background(viewModel.selectedChoice == choice ? Color.green : Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.isAnswered)
                }
            } else {
                Text("質問をロード中...")
            }
        }
    }
}

struct VoiceChoiceQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewModel: QuestionViewModel())
    }
}
