import SwiftUI

struct VoiceChoiceQuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        NavigationView{
            VStack {
                if let question = viewModel.currentQuestion {
                    Text("音声の続きの選択肢を選んでください")
                        .foregroundColor(.customBlack)
                        .padding()
                    Button("Play Audio") {
                        viewModel.playAudio(from: question.audioUrl)
                    }
                    .foregroundColor(.customBlue)
                    .padding()
                    ForEach(question.choices, id: \.self) { choice in
                        Button(action: {
                            viewModel.selectedChoice = choice
                        }) {
                            Text(choice)
                                .padding()
                                .foregroundColor(viewModel.isAnswered ? Color.customGray : (viewModel.selectedChoice == choice ? Color.customBlack : Color.customWhite))
                                .background(viewModel.isAnswered ? Color.customGray : (viewModel.selectedChoice == choice ? Color.customDarkBlue : Color.customBlue))
                                .cornerRadius(10)
                        }
                        .disabled(viewModel.isAnswered)
                    }
                } else {
                    Text("質問をロード中...")
                }
            }
            .navigationTitle("会話問題")
        }
    }
}

struct VoiceChoiceQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewModel: QuestionViewModel())
    }
}
