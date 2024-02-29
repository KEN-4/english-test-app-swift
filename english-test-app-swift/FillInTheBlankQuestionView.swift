import SwiftUI
import AVFoundation

struct FillInTheBlankQuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.currentQuestion != nil {
                    Text("会話文の続きの()を埋めてください")
                        .font(.title)
                        .padding()
                    // 会話文を表示
                    if let sentences = viewModel.currentQuestion?.sentences {
                        ForEach(sentences, id: \.self) { sentence in
                            Text(sentence)
                                .padding(.bottom, 8)
                        }
                    }
                    TextField("音声を文字起こししてください", text: $viewModel.textInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("答えをチェック") {
                        viewModel.checkAnswers()
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
            }
        }
    }
}
