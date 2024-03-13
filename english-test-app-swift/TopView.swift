import SwiftUI

struct TopView: View {
    @State private var showModal = false
    @State private var showQuickTestModal = false
    @State private var animateBackground = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.5)]),
                                   startPoint: animateBackground ? .bottomLeading : .topTrailing,
                                   endPoint: animateBackground ? .topTrailing : .bottomLeading)
                        .animation(Animation.linear(duration: 3).repeatForever(autoreverses: true), value: animateBackground)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 20) {
                        Button("診断開始") {
                            showModal = true
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .fullScreenCover(isPresented: $showModal) {
                            QuestionView(viewModel: QuestionViewModel(collection: "questions"))
                        }
                        
                        Button("クイック診断") {
                            showQuickTestModal = true
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .fullScreenCover(isPresented: $showQuickTestModal) {
                            QuestionView(viewModel: QuestionViewModel(collection: "quickquestions"))
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("English Test")
        }
        .onAppear {
            animateBackground = true
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
