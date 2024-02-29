import SwiftUI

struct QuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        VStack {
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
