import SwiftUI

struct TopView: View {
    // モーダル表示のトリガーとなる状態変数
    @State private var showModal = false

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    // ボタンをタップしたらモーダル表示をトリガー
                    showModal = true
                }) {
                    Text("診断開始")
                        .padding()
                }
            }
            .navigationTitle("English Test")
            // モーダル表示を定義
            .fullScreenCover(isPresented: $showModal) {
                // 表示するビューを指定
                QuestionView(viewModel: QuestionViewModel())
            }
        }
    }
}


struct Top_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
