import SwiftUI
import AVFoundation

struct ConversationQuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if let question = viewModel.currentQuestion {
                    Text("会話文の続きを選んでください")
                        .font(.title)
                        .padding()
                    // 会話文を表示
                    if let sentences = viewModel.currentQuestion?.sentences {
                        ForEach(sentences, id: \.self) { sentence in
                            Text(sentence)
                                .padding(.bottom, 8)
                        }
                    }
                    
                    // 選択肢を表示
                    if let choices = viewModel.currentQuestion?.choices {
                        ForEach(choices.indices, id: \.self) { index in
                            Button(action: {
                                // 選択肢がタップされたときの処理
                                self.viewModel.checkAnswer(choice: choices[index])
                            }) {
                                Text(choices[index])
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(viewModel.isAnswered ? Color.gray : Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .disabled(viewModel.isAnswered) // 回答後はボタンを無効化
                            .padding(.bottom, 8)
                        }
                    }

                    if viewModel.isAnswered {
                        Button(action: {
                            viewModel.goToNextQuestion()
                        }) {
                            Text("次の質問へ")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding([.top, .bottom], 10)
                    }
                } else {
                    ProgressView("質問を読み込み中...")
                }
                // ResultViewへの遷移を制御するNavigationLink
                NavigationLink(destination: ResultView(scoreModel: viewModel.scoreModel), isActive: $viewModel.showResultView) {
                    EmptyView()
                }
            }
        }
    }
}
