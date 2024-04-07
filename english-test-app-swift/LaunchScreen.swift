import SwiftUI

struct LaunchScreen: View {
    @State private var startAnimation = false
    @State private var goToContentView = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if goToContentView {
            if viewModel.isAuthenticated {
                ResultView(viewModel: viewModel)
            } else {
                TopView()
            }
        } else {
            ZStack {
                Image("icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100) // 初期サイズ
                    .scaleEffect(startAnimation ? 5 : 1) // 拡大するアニメーション
                    .opacity(startAnimation ? 0 : 1) // フェードアウトするアニメーション
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.5)) {
                            startAnimation = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            goToContentView = true
                        }
                    }
                .background(Color.white.ignoresSafeArea())
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen().environmentObject(AuthViewModel())
    }
}
