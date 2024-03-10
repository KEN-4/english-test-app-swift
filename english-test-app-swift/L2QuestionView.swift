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
                        // 選択した選択肢をviewModelに設定
                        viewModel.selectedChoice = choice
                    }) {
                        Text(choice)
                            .padding()
                            .foregroundColor(viewModel.selectedChoice == choice ? .black : .white)
                            .background(viewModel.selectedChoice == choice ? Color.green : Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.isAnswered) // 回答後は選択肢を無効化
                }
            } else {
                Text("質問をロード中...")
            }
        }
        .padding() // コンテンツ全体にパディングを追加
    }
}
