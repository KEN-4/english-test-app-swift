import SwiftUI
import AVFoundation

struct ChoiceQuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showingModal = false
    
    var body: some View {
        NavigationView{
            VStack {
                if let question = viewModel.currentQuestion {
                    Text("正しいと思う選択肢を選んでください")
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
                    // 選択肢を表示
                    ForEach(question.choices, id: \.self) { choice in
                        Button(action: {
                            viewModel.selectedChoice = choice
                        }) {
                            Text(choice)
                                .padding()
                                .foregroundColor(viewModel.isAnswered ? Color.customGray : (viewModel.selectedChoice == choice ? Color.customBlack : Color.customWhite))
                                .background(viewModel.isAnswered ? Color.customGray : (viewModel.selectedChoice == choice ? Color.customDarkBlue : Color.customBlue))
                                .cornerRadius(10)
                        }
                        .disabled(viewModel.isAnswered)
                    }
                } else {
                    Text("質問をロード中...")
                }
            }
            .navigationTitle("選択問題")
            // ResultViewへのモーダル遷移をviewModel.showResultViewに基づいて設定
            .fullScreenCover(isPresented: $viewModel.showResultView) {
                // ここでモーダルとして表示したいビューを指定
                ResultView(viewModel: authViewModel)
            }
        }
    }
}

struct ChoiceQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceQuestionView(viewModel: QuestionViewModel())
    }
}
