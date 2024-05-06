import SwiftUI
import DGCharts
import FirebaseAuth
import FirebaseFirestore

struct Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.image)
    }
    public var image: Image
    public var caption: String
}

struct ResultView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var showingLogin = false
    @State private var showingSignup = false
    @State private var userData: [String: Any] = [:]
    @State private var scores: [String: Double] = ["listening": 0, "speaking": 0, "grammar": 0, "vocabulary": 0]
    @State private var animalType: String = ""
    @State private var animalDescription: String = ""
    @State private var imageName: String = ""
    @State private var recommendation: String = ""
    @State private var shareText: String = ""
    @State private var learningProgress: [String: Bool] = [:]
    @State private var recommendationResources: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("あなたの動物タイプは \(animalType)です").font(.title).padding(.top)
                    Text(userData["animalDescription"] as? String ?? "").padding()
                    Image(userData["imageName"] as? String ?? "ant")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding()
                    Text("おすすめの学習方法").font(.title).padding(.top)
                    Text(recommendation).padding()
                    ShareLink(
                        "診断結果の動物画像を共有",
                        item: Photo(image: Image(userData["imageName"] as? String ?? "ant"), caption: recommendation),
                        preview: SharePreview(
                            recommendation,
                            image: Image(userData["imageName"] as? String ?? "ant"))
                    )
                    ShareLink(
                           "診断結果のテキストを共有",
                           item: "\(animalType)\n\(String(describing: userData["animalDescription"]))\n\nスコア結果:\n\(shareText)"
                    )
                    Text("スコア").font(.title)
                    RadarChartViewRepresentable(entries: [
                        RadarChartDataEntry(value: scores["listening"] ?? 0),
                        RadarChartDataEntry(value: scores["speaking"] ?? 0),
                        RadarChartDataEntry(value: scores["grammar"] ?? 0),
                        RadarChartDataEntry(value: scores["vocabulary"] ?? 0)
                    ])
                    .frame(height: 400) // 適切な高さに調整
                    // 認証されていない場合にログインと新規登録ボタンを表示
                    if !viewModel.isAuthenticated {
                        Button("ログイン") {
                            showingLogin = true
                        }
                        .sheet(isPresented: $showingLogin) {
                            SignInView(viewModel: viewModel)
                        }
                        .padding()

                        Button("新規登録") {
                            showingSignup = true
                        }
                        .sheet(isPresented: $showingSignup) {
                            SignUpView(viewModel: viewModel)
                        }
                        .padding()
                    }
                    if viewModel.isAuthenticated {
                        NavigationLink(destination: LearningView(viewModel: viewModel)) {
                            Text("学習ページへ")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.customBlue)
                                .foregroundColor(Color.customWhite)
                                .cornerRadius(10)
                        }
                        .padding()

                        Button("ログアウト") {
                            viewModel.signOut()
                        }
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.customRed)
                        .foregroundColor(.customWhite)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        Button("アカウント削除") {
                            viewModel.deleteUser()
                        }
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.customRed)
                        .foregroundColor(.customWhite)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                }
                .navigationBarTitle("診断結果")
                .onAppear {
                    loadDataFromUserDefaults()
                    if let userData = UserDefaults.standard.dictionary(forKey: "userData"),
                       let learningProgressData = userData["learningProgress"] as? [String: Bool] {
                        self.learningProgress = learningProgressData
                        debugPrint("Loaded learning progress: \(learningProgress)")
                    } else {
                        debugPrint("No learning progress found.")
                    }
                    debugPrint("Loaded userData on appear: \(self.userData)")
                }
            }
        }
    }

    private func loadDataFromUserDefaults() {
        if let storedData = UserDefaults.standard.dictionary(forKey: "userData") {
            userData = storedData
            scores = storedData["scores"] as? [String: Double] ?? [:]
            animalType = storedData["animalType"] as? String ?? ""
            animalDescription = storedData["animalDescription"] as? String ?? ""
            imageName = storedData["imageName"] as? String ?? ""
            recommendation = storedData["recommendation"] as? String ?? ""
            learningProgress = storedData["learningProgress"] as? [String: Bool] ?? [:]
            recommendationResources = storedData["recommendationResources"] as? String ?? ""
            shareText = formatShareText()
            debugPrint("Loaded userData in loadDataFromUserDefaults: \(userData)")
        } else {
            debugPrint("No userData found in UserDefaults.")
        }
    }


    func formatShareText() -> String {
        let text = """
        スコア
        リスニング: \(scores["listening"] ?? 0)
        スピーキング: \(scores["speaking"] ?? 0)
        文法: \(scores["grammar"] ?? 0)
        語彙: \(scores["vocabulary"] ?? 0)\nおすすめの学習方法:\n\(recommendation)
        """
        return text
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(viewModel: AuthViewModel())
    }
}
