import Foundation

class LearningProgressManager: ObservableObject {
    @Published var userData: [String: Any]
    @Published var learningProgress: [String: Bool]

    init() {
        // UserDefaultsからuserDataを読み込む
        let defaultData = UserDefaults.standard.dictionary(forKey: "userData") ?? [:]
        self.userData = defaultData
        // userDataからlearningProgressを取得
        self.learningProgress = defaultData["learningProgress"] as? [String: Bool] ?? [:]
    }

    func updateLearningProgress(for step: String) {
        learningProgress[step] = !(learningProgress[step] ?? false)
        userData["learningProgress"] = learningProgress
        // UserDefaultsにuserDataを保存
        UserDefaults.standard.set(userData, forKey: "userData")
        // ビューに変更を通知
        objectWillChange.send()
    }
}
