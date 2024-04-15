import Foundation

struct StudyRecommendation {
    let level: String
    let description: String
    let steps: [String]
    let resources: [String]
}

let studyRecommendations: [String: [String: StudyRecommendation]] = [
    "listening": [
        "beginner": StudyRecommendation(
            level: "Beginner",
            description: "洋楽を歌詞と共に聞いて&歌って、単語やフレーズの発音を自然に覚えましょう。",
            steps: [
                "取り組みたい曲を一つ決める",
                "曲の歌詞の意味を調べてざっと読む（歌詞を全体的に理解するだけでOK！）",
                "歌詞を見ながらその曲を何回も聴きましょう！",
                "歌詞を見ながらその曲を何回も歌いましょう！自分自身で声に出して歌うことで、発音力もUPしますよ！",
                "知らない単語や表現が出てきたら、調べてメモしましょう！"
            ],
            resources: [
                "https://youtu.be/QDYfEBY9NM4?si=n4rAhebySJa-wEgn",
                "https://youtu.be/fLexgOxsZu0?si=NYb1M347sc0pmYS_",
                "https://youtu.be/eitDnP0_83k?feature=shared"
            ]
        ),
        "intermediate": StudyRecommendation(
            level: "Intermediate",
            description: "TED Talks や短いポッドキャストを通して、多様な話題やアクセントに慣れ、複雑な語彙を身につけましょう。",
            steps: [
                "取り組みたい動画を一つ決める",
                "その動画のうち、取り組みたい部分を1分程度切り取って選ぶ",
                "その部分の日本語訳を理解する",
                "発音やアクセントに気をつけながら、シャドーイングを行う"
            ],
            resources: [
                "https://elllo.org/video/0726/737-Rocio-Who-Admire.html"
            ]
        ),
        "advanced": StudyRecommendation(
            level: "Advanced",
            description: "好きな有名人のインタビュー動画や、洋画のシーンをディクテーション＆シャドーイングしましょう。",
            steps: [
                "取り組みたい動画を1つ決める",
                "その動画のうち、取り組みたい部分を1分程度切り取って選ぶ",
                "その部分のディクテーションを行う",
                "字幕を見ながらディクテーションの答え合わせをする",
                "発音やアクセントに気をつけながら、シャドーイングを行う"
            ],
            resources: [
                "https://youtu.be/gkr57P0fwbI?si=cKVJtWKPFV5EysJJ"
            ]
        )
    ],
    "speaking": [
        "beginner": StudyRecommendation(
            level: "Beginner",
            description: "自己紹介を簡単な英語でできるようにしましょう！",
            steps: [
                "（             )にあなたの情報を入れて自己紹介文を完成させましょう！",
                "Hello, I’m (             ).",
                "I’m (          ) years old.",
                "I live in (             ).",
                "My hobby is (                )."
            ],
            resources: []
        ),
        "intermediate": StudyRecommendation(
            level: "Intermediate",
            description: "簡単な日常会話や決まったシーンでの会話をできるようにしましょう！",
            steps: [
                "ファストフード店でのやり取りの会話を練習しましょう",
                "（　　　　）に入る英語を考えましょう",
                "店員：Hi!What can I get for you? /What would you like to order?",
                "you：（　　　　　　　　　　）",
                "店員：just the burger, or as a combo?セット：combo/meal",
                "you：（　　　　　　　　　　）",
                "you：（　　　　　　　　　　）",
                "店員：What would you like for the side menu?",
                "you：（　　　　　　　　　　）",
                "店員：Ok, anything else?",
                "you：（　　　　　　　　　　）",
                "店員：Will it be for here or to go?",
                "you：（　　　　　　　　　　）",
                "店員：Ok, your total will be $6.50.",
                "you：（　　　　　　　　　　）",
                "店員：Please insert the card here.",
                "you：（　　　　　　　　　　）",
                "店員：Do you need a receipt?",
                "you：（　　　　　　　　　　）",
                "店員：Ok, we will call your number once your food is ready."
            ],
            resources: [
                "https://elllo.org/video/0726/737-Rocio-Who-Admire.html"
            ]
        ),
        "advanced": StudyRecommendation(
            level: "Advanced",
            description: "英会話レッスンに挑戦しましょう！プロの先生と英語で話して、指摘してもらいましょう",
            steps: [
                "取り組みたい英会話を1つ決める",
                "英会話レッスンの予約をする",
                "英会話レッスンをする"
            ],
            resources: [
                "https://hana-englishroom.my.canva.site/"
            ]
        )
    ],
    "grammar": [
        "beginner": StudyRecommendation(
            level: "Beginner",
            description: "英語の基礎文法書や文法解説動画を用いて、言語の基本構造をしっかり理解し、例文を作ってみましょう。",
            steps: [
                "英語の基礎文法書を読む",
                "文法解説動画を見る",
                "例文を作ってみる"
            ],
            resources: [
                "https://youtu.be/D9tPzH3fXtc?si=0-WrFNuUkaVbuURY"
            ]
        ),
        "intermediate": StudyRecommendation(
            level: "Intermediate",
            description: "英語の短編小説や記事を読んで、分からなかった文章の文法を学びましょう。",
            steps: [
                "短編小説や記事を読む",
                "分からなかった文章の文法を調べる",
                "調べた文法を使って自分で文を作ってみる"
            ],
            resources: [
                "https://www.newsinlevels.com"
            ]
        ),
        "advanced": StudyRecommendation(
            level: "Advanced",
            description: "自分で英語日記を書いてみましょう。分からなかった部分は書いて復習しましょう。",
            steps: [
                "日記を英語で書く",
                "分からなかった単語や文法を調べる",
                "復習をする"
            ],
            resources: []
        )
    ],
    "vocabulary": [
        "beginner": StudyRecommendation(
            level: "Beginner",
            description: "基本単語帳やフラッシュカードを使い、初歩的な単語とフレーズを効果的に覚えましょう",
            steps: [
                "この動画に出てくる単語を全て覚えましょう！"
            ],
            resources: [
                "https://youtu.be/CkHUxGQ_h1s?si=UMWmBddPfT20VvzG"
            ]
        ),
        "intermediate": StudyRecommendation(
            level: "Intermediate",
            description: "記事や小説の中の新しい単語をメモして、文脈の中での語集の使用方法を学びましょう。",
            steps: [
                "取り組みたい小説を一つ決める",
                "その小説のうち、取り組みたい部分を1文程度切り取って選ぶ",
                "その部分の日本語訳を理解する",
                "発音やアクセントに気をつけながら、シャドーイングを行う"
            ],
            resources: [
                "https://www.newsinlevels.com"
            ]
        ),
        "advanced": StudyRecommendation(
            level: "Advanced",
            description: "自分で英語日記を書いてみましょう。分からなかった単語は日本語で書いて最後に復習し、表現を増やしましょう。",
            steps: [
                "まずは、次のお題に対して、３文で日記を書いてみましょう！",
                "How was your day?",
                "What did you do?"
            ], resources: []
        )
    ],
]

func getMostNeededStudyMethod(scores: [String: Double]) -> (description: String, steps: [String], resources: [String]) {
    guard let lowestSkill = scores.min(by: { $0.value < $1.value })?.key else {
        debugPrint("Failed to find the lowest skill")
        return ("", [], [])
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

    guard let recommendation = studyRecommendations[lowestSkill]?[level] else {
        debugPrint("No recommendation found for \(lowestSkill) at level \(level)")
        return ("No recommendation available", [], [])
    }

    debugPrint("Found recommendation steps: \(recommendation.steps)")
    return (recommendation.description, recommendation.steps, recommendation.resources)
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
