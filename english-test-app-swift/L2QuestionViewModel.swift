import FirebaseFirestore
import SwiftUI
import AVFoundation
import FirebaseStorage

class L2QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var isAnswered = false
    @Published var result: String?
    @Published var showResultView = false
    
    var audioPlayer: AVAudioPlayer?
    var scoreModel = ScoreModel()
    
    init() {
        fetchQuestions()
    }

    func fetchQuestions() {
        let firestore = Firestore.firestore()
        firestore.collection("question").whereField("type", isEqualTo: "2-choices").getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                self.questions = snapshot.documents.map { doc -> Question in
                    let data = doc.data()
                    return Question(id: doc.documentID, dictionary: data)
                }
            }
        }
    }

    func playAudio(from storageUrlString: String) {
        let storageRef = Storage.storage().reference(forURL: storageUrlString)
        storageRef.downloadURL { url, error in
            guard let downloadURL = url else {
                print("ダウンロードURLの取得エラー: \(String(describing: error))")
                return
            }
            // URLSessionを使用して非同期にデータを取得
            URLSession.shared.dataTask(with: downloadURL) { data, response, error in
                guard let data = data, error == nil else {
                    print("音声ファイルのダウンロードエラー: \(String(describing: error))")
                    return
                }
                // メインスレッドで音声プレイヤーを更新
                DispatchQueue.main.async { [self] in
                    do {
                        audioPlayer = try AVAudioPlayer(data: data)
                        audioPlayer?.prepareToPlay()
                        audioPlayer?.play()
                    } catch {
                        print("音声再生エラー: \(error)")
                    }
                }
            }.resume()
        }
    }
    // 回答をチェックする
    func checkAnswer(choice: String) {
        guard currentQuestionIndex < questions.count else { return }
        let currentQuestion = questions[currentQuestionIndex]

        // 回答が正解かどうかをチェック
        isAnswered = true
        if choice == currentQuestion.correctAnswer {
            result = "正解"
            currentQuestion.skills.forEach { skill in
                scoreModel.addScore(skill: skill, additionalScore: currentQuestion.score / Double(currentQuestion.skills.count))
            }
        } else {
            result = "不正解"
            // 不正解時の処理をここに追加
        }
    }

    // 次の質問へ移動する
    func goToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            isAnswered = false
            result = nil
        } else {
            showResultView = true
        }
    }
}
