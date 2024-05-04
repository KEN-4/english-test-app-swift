import Foundation

class ScoreModel {
    enum SkillType: String, Comparable, CaseIterable {
        case listening
        case speaking
        case grammar
        case vocabulary
        
        // Comparableに準拠すると、この関数を定義しなければならない（定義することで大小比較が可能になる）
        // アルファベット順に比較
        static func < (lhs: SkillType, rhs: SkillType) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
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
