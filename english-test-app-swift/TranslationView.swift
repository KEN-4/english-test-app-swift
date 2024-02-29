import SwiftUI
import AVFoundation

struct TranslationView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        NavigationView {
            ScrollView { // VStackをScrollViewでラップする
                VStack {
                    if let currentQuestion = viewModel.currentQuestion {
                        Text("日本語の文を英文に訳してください")
                            .font(.title)
                            .padding()
                        
                        // 会話文を表示
                        ForEach(currentQuestion.sentences, id: \.self) { sentence in
                            Text(sentence)
                                .padding(.bottom, 8)
                        }
                        
                        // 選択肢を表示
                        ForEach(currentQuestion.choices, id: \.self) { choice in
                            Button(action: {
                                viewModel.addChoiceToTextField(choice: choice)
                            }) {
                                Text(choice)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                        
                        Button("Remove Last Choice") {
                            viewModel.removeLastChoice()
                        }
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        TextField("Add text by pressing the button", text: $viewModel.textInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button("Clear All Text") {
                            viewModel.clearChoices()
                        }
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Button("答えをチェック") {
                            viewModel.checkAnswers()
                        }
                        .padding()
                        
                        if viewModel.isAnswered {
                            if let firstAnswer = viewModel.currentQuestion?.answers.first {
                                Text("正解: \(firstAnswer)")
                                    .padding()
                            };                            Button(action: {
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
                .padding()
            }
            .navigationBarTitle("Translation Test", displayMode: .inline)
        }
    }
}
