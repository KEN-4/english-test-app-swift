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
                .padding()

                // 選択肢を表示
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


struct L2QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewModel: QuestionViewModel())
    }
}
