import SwiftUI

struct L2QuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        NavigationView{
            VStack {
                if let question = viewModel.currentQuestion {
                    Text("発音した単語を選んでください")
                        .foregroundColor(.customBlack)
                    Button("Play Audio") {
                        viewModel.playAudio(from: question.audioUrl)
                    }
                    .foregroundColor(.customBlue)
                    .padding()
                    
                    // 選択肢を表示
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
            .navigationTitle("2択聞き取り問題")
        }
    }
}


struct L2QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewModel: QuestionViewModel())
    }
}
