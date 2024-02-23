import Foundation

// 質問モデル
struct Question: Identifiable {
    let id: String
    let audioUrl: String
    let choices: [String]
    let correctAnswer: String
    let type: String
    let skills: [String]
    let sentences: [String]
    let answers: [String]
    let score: Double

    init(id: String, dictionary: [String: Any]) {
        self.id = id
        self.audioUrl = dictionary["audioUrl"] as? String ?? ""
        self.choices = dictionary["choices"] as? [String] ?? []
        self.correctAnswer = dictionary["correctAnswer"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
        self.skills = dictionary["skills"] as? [String] ?? []
        self.sentences = dictionary["sentences"] as? [String] ?? []
        self.answers = dictionary["answers"] as? [String] ?? []
        self.score = dictionary["score"] as? Double ?? 0.0
    }
}
