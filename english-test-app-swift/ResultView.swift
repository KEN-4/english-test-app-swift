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
    var scoreModel = ScoreModel()
    @State private var showingLogin = false // ログイン画面表示フラグ
    @State private var showingSignup = false // 新規登録画面表示フラグ
    @State private var shareText: String = ""
    
    var body: some View {
        let animalDetails = getAnimalTypeAndDetails(scores: scoreModel.scores)
        let photo = Photo(image: Image(animalDetails.imageName), caption: animalDetails.description)
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("あなたの動物タイプは \(animalDetails.name)です").font(.title).padding(.top)
                    Text(animalDetails.description).padding()
                    Image(animalDetails.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding()
                    Text("おすすめの学習方法").font(.title).padding(.top)
                    if let recommendation = getMostNeededStudyMethod(scores: scoreModel.scores) {
                        Text(recommendation)
                    } else {
                        Text("学習方法の推薦が利用できません")
                    }
                    ShareLink(
                        "診断結果の動物画像を共有",
                        item: photo,
                        preview: SharePreview(
                            photo.caption,
                            image: photo.image))
                    ShareLink(
                           "診断結果のテキストを共有",
                           item: "\(animalDetails.name)\n\(animalDetails.description)\n\nスコア結果:\n\(shareText)"
                       )
                    Text("スコア").font(.title)
                    RadarChartViewRepresentable(entries: [
                        RadarChartDataEntry(value: scoreModel.scores["listening"] ?? 0),
                        RadarChartDataEntry(value: scoreModel.scores["speaking"] ?? 0),
                        RadarChartDataEntry(value: scoreModel.scores["grammar"] ?? 0),
                        RadarChartDataEntry(value: scoreModel.scores["vocabulary"] ?? 0)
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
                }
                .navigationBarTitle("診断結果")
                .onAppear {
                    // ビューが表示されるときに共有テキストを初期化
                    shareText = formatShareText()
                }
                
            }
        }
    }
    
    func formatShareText() -> String {
        // スコアのデータとおすすめの学習方法をテキストとして整形
        let recommendationText: String
        if let recommendation = getMostNeededStudyMethod(scores: scoreModel.scores) {
            recommendationText = "\nおすすめの学習方法:\n\(recommendation)"
        } else {
            recommendationText = "\n学習方法の推薦が利用できません"
        }

        let text = """
        スコア
        リスニング: \(scoreModel.scores["listening"] ?? 0)
        スピーキング: \(scoreModel.scores["speaking"] ?? 0)
        文法: \(scoreModel.scores["grammar"] ?? 0)
        語彙: \(scoreModel.scores["vocabulary"] ?? 0)\(recommendationText)
        """
        return text
    }

}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(viewModel: QuestionViewModel())
    }
}
