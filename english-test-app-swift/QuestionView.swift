import SwiftUI

struct QuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            
            ProgressBar(progress: viewModel.progress)
                .frame(height: 20)
                .padding()
            

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
