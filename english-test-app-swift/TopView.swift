import SwiftUI

struct TopView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: QuestionView(viewModel: QuestionViewModel())) {
                    Text("診断開始")
                        .padding()
                }
            }
            .navigationTitle("English Test")
        }
    }
}

struct Top_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
