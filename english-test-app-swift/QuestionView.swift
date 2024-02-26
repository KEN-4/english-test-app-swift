import SwiftUI

struct QuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            if let questionType = viewModel.currentQuestion?.type {
                switch questionType {
                case "2-choices":
                    // L2QuestionViewにviewModelを渡す
                    L2QuestionView(viewModel: viewModel)
                case "dictation":
                    // DictationViewにviewModelを渡す
                    DictationView(viewModel: viewModel)
                // その他の問題形式に応じたビューを表示
                default:
                    Text("Unsupported question type")
                }
            }
        }
    }
}
