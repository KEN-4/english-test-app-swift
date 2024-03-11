import SwiftUI
import AVFoundation

struct ConversationQuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        NavigationView{
            VStack {
                if let question = viewModel.currentQuestion {
                    Text("会話文の続きを選んでください")
                        .foregroundColor(.customBlack)
                        .padding()
                    // 会話文を表示
                    if let sentences = viewModel.currentQuestion?.sentences {
                        ForEach(sentences, id: \.self) { sentence in
                            Text(sentence)
                                .foregroundColor(.customBlack)
                                .padding(.bottom, 8)
                        }
                    }
                    
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
            .navigationTitle("会話問題")
        }
    }
}


struct ConversationQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewModel: QuestionViewModel())
    }
}
