import Foundation

class ScoreModel {
    enum SkillType: String {
        case listening = "listening"
        case speaking = "speaking"
        case grammar = "grammar"
        case vocabulary = "vocabulary"
    }
    
    var scores: [SkillType: Double] = [
        .listening: 0.0,
        .speaking: 0.0,
        .grammar: 0.0,
        .vocabulary: 0.0,
    ]

    func addScore(skill: SkillType, additionalScore: Double = 1.0) {
        scores[skill] = (scores[skill] ??  0.0) + additionalScore
        debugPrint("Score for \(skill.rawValue) after adding: \(scores[skill] ?? 0.0)")
        saveScores()
    }

    func saveScores() {
        let scoresData = scores.mapKeys { $0.rawValue }
        UserDefaults.standard.set(scoresData, forKey: "userScores")
    }
}

extension Dictionary {
    func mapKeys<T: Hashable>(transform: (Key) -> T) -> Dictionary<T, Value> {
        Dictionary<T, Value>(uniqueKeysWithValues: map { (transform($0.key), $0.value) })
    }
}
