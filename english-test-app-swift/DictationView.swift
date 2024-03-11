import SwiftUI

struct DictationView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        NavigationView{
            VStack {
                if let question = viewModel.currentQuestion {
                    Button("Play Audio") {
                        viewModel.playAudio(from: question.audioUrl)
                    }
                    .foregroundColor(.customBlue)
                    .padding()
                    TextField("音声を文字起こししてください", text: $viewModel.textInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .navigationTitle("ディクテーション問題")
        }
    }
}

struct DictationView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewModel: QuestionViewModel())
    }
}
