import FirebaseFirestore
import SwiftUI
import AVFoundation
import FirebaseStorage

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex = 0
    @Published var selectedChoice: String?
    @Published var isAnswered = false
    @Published var result: String?
    @Published var showResultView = false
    @Published var textInput: String = ""
    @Published var choicesMade: [String] = []
    var scores: [String: Double] = ["listening": 0, "speaking": 0, "grammar": 0, "vocabulary": 0]
    var authViewModel: AuthViewModel
    
    var progress: Float {
        guard !questions.isEmpty else { return 0 }
        return Float(currentQuestionIndex) / Float(questions.count - 1)
    }

    var audioPlayer: AVAudioPlayer?
    var scoreModel = ScoreModel()
    
    var currentQuestion: Question? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    init(collection: String = "questions") {
        self.authViewModel = AuthViewModel()
        fetchQuestions(from: collection)
    }

    func fetchQuestions(from collection: String) {
        let firestore = Firestore.firestore()
        firestore.collection(collection).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                self.questions = snapshot.documents.map { doc -> Question in
                    let data = doc.data()
                    let question = Question(id: doc.documentID, dictionary: data)
                    return question
                }
            }
        }
    }


    func playAudio(from storageUrlString: String) {
        let storageRef = Storage.storage().reference(forURL: storageUrlString)
        storageRef.downloadURL { url, error in
            guard let downloadURL = url else {
                debugPrint("ダウンロードURLの取得エラー: \(String(describing: error))")
                return
            }
            // URLSessionを使用して非同期にデータを取得
            URLSession.shared.dataTask(with: downloadURL) { data, response, error in
                guard let data = data, error == nil else {
                    debugPrint("音声ファイルのダウンロードエラー: \(String(describing: error))")
                    return
                }
                DispatchQueue.main.async { [self] in
                    do {
                        audioPlayer = try AVAudioPlayer(data: data)
                        audioPlayer?.prepareToPlay()
                        audioPlayer?.play()
                    } catch {
                        debugPrint("音声再生エラー: \(error)")
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
            result = "⚪︎"
            currentQuestion.skills.forEach { skillString in
                if let skill = ScoreModel.SkillType(rawValue: skillString) {
                    scoreModel.addScore(skill: skill, additionalScore: currentQuestion.score)
                } else {
                    print("Invalid skill type: \(skillString)")
                }
            }
        } else {
            result = "×"
        }
    }
    
    // 回答をチェックする
    func checkAnswers() {
        debugPrint("checkAnswers called")
        guard let currentQuestion = currentQuestion else { return }
        
        isAnswered = true
        if currentQuestion.answers.contains(where: { answer in
            textInput.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == answer.lowercased()
        }) {
            debugPrint("正解")
            result = "⚪︎"
            currentQuestion.skills.forEach { skillString in
                if let skill = ScoreModel.SkillType(rawValue: skillString) {
                    scoreModel.addScore(skill: skill, additionalScore: currentQuestion.score)
                } else {
                    print("Invalid skill type: \(skillString)")
                }
            }
        } else {
            debugPrint("不正解")
            result = "×"
        }
        textInput = ""
    }
    
    func submitAnswer() {
        guard let currentQuestion = currentQuestion else { return }
        
        isAnswered = true // 回答されたフラグを立てる
        
        switch currentQuestion.type {
        case "choice", "2-choices", "voicechoice", "conversation":
            // 選択肢ベースの質問の処理
            guard let choice = selectedChoice else { return }
            let isCorrect = choice == currentQuestion.correctAnswer
            updateResult(isCorrect: isCorrect)
            
        case "dictation", "fill_in_the_blank", "translation":
            // 入力テキストベースの質問の処理
            let isCorrect = currentQuestion.answers.contains { answer in
                textInput.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == answer.lowercased()
            }
            updateResult(isCorrect: isCorrect)
            textInput = "" // 入力フィールドをクリア
            
        default:
            debugPrint("Unsupported question type: \(currentQuestion.type)")
        }
        
        // 結果の更新とスキルスコアの加算
        func updateResult(isCorrect: Bool) {
            result = isCorrect ? "⚪︎" : "×"
            if isCorrect {
                currentQuestion.skills.forEach { skillString in
                    if let skill = ScoreModel.SkillType(rawValue: skillString) {
                        scoreModel.addScore(skill: skill, additionalScore: currentQuestion.score)
                    } else {
                        print("Invalid skill type: \(skillString)")
                    }
                }
            }
        }
        selectedChoice = nil
    }


    // 次の質問へ移動する
    func goToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            isAnswered = false
            result = nil
        } else {
            if let savedScores = UserDefaults.standard.dictionary(forKey: "userScores") as? [String: Double] {
                scores = savedScores
                debugPrint("Final scores before saving: \(scores)")
            }
            // 全ての質問が終了したらスコアをUserDefaultsに保存
            authViewModel.updateUserDefaults(scores: scores)
            if let userData = UserDefaults.standard.dictionary(forKey: "userData") {
                debugPrint("Saved user data: \(userData)")
            }
            showResultView = true
        }
    }
    // 選択を追加する関数
    func addChoiceToTextField(choice: String) {
        choicesMade.append(choice)
        textInput = choicesMade.joined(separator: " ")
    }
    
    // 最後の選択を取り消す関数
    func removeLastChoice() {
        if !choicesMade.isEmpty {
            choicesMade.removeLast()
            textInput = choicesMade.joined(separator: " ")
        }
    }
    
    func clearChoices() {
        choicesMade.removeAll()
        textInput = ""
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
