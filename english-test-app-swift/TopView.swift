import SwiftUI

struct TopView: View {
    @State private var showModal = false
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

                    VStack {
                        Button(action: {
                            showModal = true
                        }) {
                            Text("診断開始").font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.customBlue)
                                .cornerRadius(10)
                        }
                        .frame(width: geometry.size.width * 0.8)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .onAppear {
                animateBackground = true
            }
            .navigationTitle("English Test")
            .fullScreenCover(isPresented: $showModal) {
                QuestionView(viewModel: QuestionViewModel())
            }
        }
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}
