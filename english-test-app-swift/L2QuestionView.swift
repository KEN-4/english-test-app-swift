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
                    .padding() // ボタンの内側のパディングを追加します。
                    .frame(minWidth: 0, maxWidth: .infinity) // ボタンの幅を画面いっぱいにします。
                    .background(viewModel.selectedChoice != nil ? Color.green : Color.gray) // 背景色を設定します。
                    .foregroundColor(.white) // テキストの色を設定します。
                    .cornerRadius(10) // 角を丸くします。
                    .padding(.horizontal) //
                } else {
                    VStack(spacing: 10) {
                        Text(viewModel.result ?? "エラー") // "正解"または"不正解"のテキスト
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("正解: \(question.correctAnswer)")
                            .padding(.bottom) // 正解のテキストとボタンの間に余白を追加

                        Button("次へ") {
                            viewModel.goToNextQuestion()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white) // テキストの色を設定
                        .cornerRadius(10) // 角を丸くする
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 20) // VStackの内側の縦方向のパディング
                    .background(Color.green) // VStackの背景色を設定
                    .cornerRadius(15) // VStackの角を丸くする
                    .shadow(radius: 5) // 影を追加して立体感を出す
                    .padding(.horizontal) // VStackの外側の水平方向のパディング
                }
            }
        }
    }
}
