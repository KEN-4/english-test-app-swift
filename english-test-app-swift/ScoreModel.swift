import Foundation

class ScoreModel {
    var scores: [String: Double] = [
        "listening": 0.0,
        "speaking": 0.0,
        "grammar": 0.0,
        "vocabulary": 0.0,
    ]

    func addScore(skill: String, additionalScore: Double = 1.0) {
        // スキルに対して追加スコアをそのまま加算
        scores[skill, default: 0.0] += additionalScore
        debugPrint("Score for \(skill) after adding: \(String(describing: scores[skill]))")
    }

}
