import SwiftUI

struct QuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            
            ProgressBar(progress: viewModel.progress)
                .frame(height: 20)
                .padding()
            
            Spacer()
            if let questionType = viewModel.currentQuestion?.type {
                switch questionType {
                case "2-choices":
                    L2QuestionView(viewModel: viewModel)
                case "dictation":
                    DictationView(viewModel: viewModel)
                case "voicechoice":
                    VoiceChoiceQuestionView(viewModel: viewModel)
                case "conversataion":
                    ConversationQuestionView(viewModel: viewModel)
                case "fill_in_the_blank":
                    FillInTheBlankQuestionView(viewModel: viewModel)
                case "translation":
                    TranslationView(viewModel: viewModel)
                case "choice":
                    ChoiceQuestionView(viewModel: viewModel)
                default:
                    Text("Unsupported question type")
                }
            }
            Spacer()
            
            if !viewModel.isAnswered {
                Button("送信") {
                    viewModel.submitAnswer()
                }
                .disabled(viewModel.isAnswered || (viewModel.selectedChoice == nil && viewModel.textInput.isEmpty))
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            // 回答後のフィードバック表示
            if viewModel.isAnswered {
                // 正解または不正解の表示
                Text(viewModel.result ?? "エラー")
                    .font(.headline)
                    .foregroundColor(viewModel.result == "⚪︎" ? .green : .red)

                if let question = viewModel.currentQuestion, ["dictation", "fill_in_the_blank", "translation"].contains(question.type) {
                    Text("正解: \(question.answers[0])")
                } else if let question = viewModel.currentQuestion {
                    Text("正解: \(question.correctAnswer)")
                        .padding()
                }
                
                // 「次の質問へ」ボタン
                Button("次の質問へ") {
                    viewModel.goToNextQuestion()
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
    }
}


struct ProgressBar: View {
    var progress: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                Rectangle().frame(width: min(CGFloat(progress) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.blue)
                    .animation(.linear, value: progress)
            }
            .cornerRadius(45.0)
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewModel: QuestionViewModel())
    }
}
