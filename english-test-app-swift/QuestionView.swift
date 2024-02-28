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
                default:
                    Text("Unsupported question type")
                }
            }
        }
    }
}
