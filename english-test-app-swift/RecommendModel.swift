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

func getMostNeededStudyMethod(scores: [String: Double]) -> String? {
    guard let lowestSkill = scores.min(by: { $0.value < $1.value })?.key else {
        return nil
    }
    
    let score = scores[lowestSkill, default: 0.0]
    let level: String
    
    switch score {
    case 7.0...:
        level = "advanced"
    case 4.0..<7.0:
        level = "intermediate"
    default:
        level = "beginner"
    }

    return studyRecommendations[lowestSkill]?[level]
}



let animalTypes: [String: [String: (name: String, description: String, imageName: String)]] = [
    "listening": [
        "beginner": ("カメ", "ゆっくりと聞き、情報を吸収するあなたはカメタイプです。", "turtle"),
        "intermediate": ("キツネ", "機敏に情報をキャッチし分析するあなたはキツネタイプです。", "fox"),
        "advanced": ("チーター", "高速で情報を処理するあなたはチータータイプです。", "cheetah")
    ],
    "speaking": [
        "beginner": ("カナリア", "明るく鳴き、周りを楽しませるあなたはカナリアタイプです。", "canary"),
        "intermediate": ("オウム", "色々な言葉を覚えて周りに伝えるあなたはオウムタイプです。", "parrot"),
        "advanced": ("インコ", "鮮やかで存在感があり、高度なコミュニケーションを取るあなたはインコタイプです。", "parakeet")
    ],
    "grammar": [
        "beginner": ("アリ", "地道に基礎を積み重ねるあなたはアリタイプです。", "ant"),
        "intermediate": ("ゾウ", "大きなステップを踏み出し、記憶力も抜群のあなたはゾウタイプです。", "elephant"),
        "advanced": ("イルカ", "高度な知識を活用し、柔軟に思考するあなたはイルカタイプです。", "dolphin")
    ],
    "vocabulary": [
        "beginner": ("ウサギ", "素早く基本的な単語を集めるあなたはウサギタイプです。", "rabbit"),
        "intermediate": ("リス", "活動的に様々な単語を集め、使いこなすあなたはリスタイプです。", "squirrel"),
        "advanced": ("ヒョウ", "広い範囲の語彙を持ち、敏捷に使い分けるあなたはヒョウタイプです。", "leopard")
    ]
]


func getAnimalTypeAndDetails(scores: [String: Double]) -> (name: String, description: String, imageName: String) {
    guard let highestSkill = scores.max(by: { $0.value < $1.value })?.key else {
         return ("不明", "動物タイプが特定できません", "")
    }
    
    let score = scores[highestSkill, default: 0.0]
    let level: String
    
    switch score {
    case 7.0...:
        level = "advanced"
    case 4.0..<7.0:
        level = "intermediate"
    default:
        level = "beginner"
    }
    
    if let details = animalTypes[highestSkill]?[level] {
        return details
    } else {
        return ("不明", "適切な動物タイプが見つかりません。", "")
    }
}
