import Foundation

let studyRecommendations: [String: [String: String]] = [
    "listening": [
        "beginner": "洋楽を歌詞と共に聞いて&歌って、単語やフレーズの発音を自然に覚えましょう。",
        "intermediate": "TED Talksや短いポッドキャストを通して、多様な話題やアクセントに慣れ、複雑な語彙を身につけましょう。",
        "advanced": "好きな有名人のインタビュー動画や、洋画のシーンをシャドーイングしましょう。"
    ],
    "speaking": [
        "beginner": "基本的な自己紹介や日常会話を練習して、日常的なコミュニケーション能力を向上させましょう。",
        "intermediate": "日本人の先生と英会話をしましょう。",
        "advanced": "英語でのディベートやプレゼンテーション行い、複雑なトピックでも流暢に意見を表現する能力を身につけましょう。"
    ],
    "grammar": [
        "beginner": "英語の基礎文法書を用いて、言語の基本構造をしっかり理解し、例文を作ってみましょう。",
        "intermediate": "英語の短編小説や記事を読んで、分からなかった文章の文法を学びましょう。",
        "advanced": "自分で英語日記を書いてみましょう。分からなかった部分は書いて復習しましょう。"
    ],
    "vocabulary": [
        "beginner": "基本単語帳やフラッシュカードを使い、初歩的な単語とフレーズを効果的に覚えましょう。",
        "intermediate": "記事や小説の中の新しい単語をメモして、文脈の中での語彙の使用方法を学びましょう。",
        "advanced": "自分で英語日記を書いてみましょう。分からなかった単語は日本語で書いて最後に復習し、表現を増やしましょう。"
    ]
]

func getMostNeededStudyMethods(scores: [String: Double]) -> [String] {
    let lowestSkills = scores.filter { $0.value == scores.values.min() }.keys
    var recommendations: [String] = []

    for skill in lowestSkills {
        let level: String
        let score = scores[skill, default: 0.0]

        switch score {
        case 7.0...:
            level = "advanced"
        case 4.0..<7.0:
            level = "intermediate"
        default:
            level = "beginner"
        }

        if let recommendation = studyRecommendations[skill]?[level] {
            recommendations.append(recommendation)
        }
    }

    return recommendations
}