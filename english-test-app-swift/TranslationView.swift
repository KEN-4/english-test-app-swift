import SwiftUI
import AVFoundation

struct TranslationView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let currentQuestion = viewModel.currentQuestion {
                        Text("日本語の文を英文に訳してください")
                            .foregroundColor(.customBlack)
                            .padding()
                        
                        TextField("ボタンを押して文章を完成させてください", text: $viewModel.textInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
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
                        ForEach(currentQuestion.choices, id: \.self) { choice in
                            Button(action: {
                                viewModel.addChoiceToTextField(choice: choice)
                            }) {
                                Text(choice)
                                    .padding()
                                    .background(Color.customBlue)
                                    .foregroundColor(.customWhite)
                                    .cornerRadius(8)
                            }
                        }
                        
                        Button("Remove Last Choice") {
                            viewModel.removeLastChoice()
                        }
                        .padding()
                        .background(Color.customRed)
                        .foregroundColor(.customWhite)
                        .cornerRadius(8)
                        
                        Button("Clear All Text") {
                            viewModel.clearChoices()
                        }
                        .padding()
                        .background(Color.customRed)
                        .foregroundColor(.customWhite)
                        .cornerRadius(8)
                    } else {
                        Text("質問をロード中...")
                    }
                }
                .navigationTitle("翻訳問題")
            }
        }
    }
}

struct TranslationView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewModel: QuestionViewModel())
    }
}
