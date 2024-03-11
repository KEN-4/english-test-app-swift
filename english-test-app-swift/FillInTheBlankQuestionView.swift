import SwiftUI
import AVFoundation

struct FillInTheBlankQuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if let question = viewModel.currentQuestion {
                    Text("会話文の続きの()を埋めてください")
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
                    TextField("会話文の続きの()を埋めてください", text: $viewModel.textInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                } else {
                    Text("質問をロード中...")
                }
            }
            .navigationTitle("穴埋め問題")
        }
    }
}

struct FillInTheBlankQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewModel: QuestionViewModel())
    }
}
