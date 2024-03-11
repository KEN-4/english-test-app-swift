import SwiftUI

struct TopView: View {
    // モーダル表示のトリガーとなる状態変数
    @State private var showModal = false

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    showModal = true
                }) {
                    Text("診断開始").font(.title)
                        .foregroundColor(.customBlue)
                }
            }
            .navigationTitle("English Test")
            .fullScreenCover(isPresented: $showModal) {
                QuestionView(viewModel: QuestionViewModel())
            }
        }
    }
}


#Preview {
    TopView()
}
