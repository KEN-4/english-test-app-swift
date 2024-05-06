import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isNewUser = false
    
    init() {
        observeAuthChanges()
    }
    
    private func observeAuthChanges() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.isAuthenticated = user != nil
            }
        }
    }
    
    func loadScoresFromUserDefaults() -> [String: Double]? {
        if let scores = UserDefaults.standard.object(forKey: "userScores") as? [String: Double] {
            return scores
        }
        return nil
    }
    
    func saveScoresToFirebase(uid: String, scores: [String: Double]) {
        let userRef = Firestore.firestore().collection("users").document(uid)
        userRef.updateData(["result_scores": scores]) { error in
            if let error = error {
                print("スコアのFirebaseへの保存に失敗しました: \(error.localizedDescription)")
            } else {
                print("スコアをFirebaseに保存しました")
            }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                if let user = result?.user, error == nil {
                    self?.isAuthenticated = true
                    self?.isNewUser = true
                    
                    // UserDefaultsからスコアを読み込む
                    if let scores = self?.loadScoresFromUserDefaults() {
                        // 読み込んだスコアでFirebaseを更新
                        self?.saveScoresToFirebase(uid: user.uid, scores: scores)
                    } else {
                        // UserDefaultsにスコアが存在しない場合、Firebaseから取得してUserDefaultsを更新
                        self?.fetchScoresAndUpdateUserDefaults(uid: user.uid)
                    }
                }
            }
        }
    }
    
    
    func signUp(email: String, password: String, scores: [String: Double]) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let user = result?.user, error == nil {
                    self.isAuthenticated = true
                    self.isNewUser = true
                    // 新規ユーザーの情報とスコアをFirebaseに保存する
                    self.saveUserInfo(user: user, email: email, scores: scores)
                } else {
                    // エラーハンドリング
                    print(error?.localizedDescription ?? "Unknown error occurred")
                }
            }
        }
    }
    
    func saveUserInfo(user: User, email: String, scores: [String: Double]) {
        let uid = user.uid
        let animalDetails = getAnimalTypeAndDetails(scores: scores)
        let recommendationResult = getMostNeededStudyMethod(scores: scores)
        let recommendationDescription = recommendationResult.description
        let recommendationSteps = recommendationResult.steps
        let recommendationResources = recommendationResult.resources
        
        debugPrint("Animal Type: \(animalDetails.name)")
        debugPrint("Recommendation Description: \(recommendationDescription)")
        debugPrint("Recommendation Steps: \(recommendationSteps)")
        debugPrint("Recommendation Resources: \(recommendationResources)")
        
        let userData = [
            "createdAt": Timestamp(date: Date()),
            "email": email,
            "result_scores": scores,
            "animalType": animalDetails.name,
            "animalDescription": animalDetails.description,
            "imageName": animalDetails.imageName,
            "recommendation": recommendationDescription,
            "learningProgress": recommendationSteps.reduce(into: [String: Bool]()) { (dict, step) in
                dict[step] = false  // 最初はすべてのステップを未完了（false）として設定
            },
            "recommendationResources": recommendationResources
        ] as [String : Any]
        
        Firestore.firestore().collection("users").document(uid).setData(userData) { error in
            if let error = error {
                print("Firestoreへの保存に失敗しました：\(error.localizedDescription)")
            } else {
                print("ユーザー情報とスコアをFirestoreに保存しました。")
            }
        }
    }

    
    // パスワードをリセットするメソッド
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error in sending password reset: \(error)")
            }
        }
    }
    // ログアウトするメソッド
    func signOut() {
        do {
            try Auth.auth().signOut()
            isAuthenticated = false
            isNewUser = false
            UserDefaults.standard.removeObject(forKey: "userData")
            UserDefaults.standard.removeObject(forKey: "userScores")
            print("ユーザーデータをUserDefaultsから削除しました。")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    // アカウントを削除するメソッド
    func deleteUser() {
        Auth.auth().currentUser?.delete { error in
            if let error = error {
                print("アカウントの削除に失敗しました: \(error.localizedDescription)")
            } else {
                print("アカウントが正常に削除されました。")
                // アカウント削除後の追加処理（必要に応じて）
                self.isAuthenticated = false
                self.isNewUser = false
                UserDefaults.standard.removeObject(forKey: "userData")
                UserDefaults.standard.removeObject(forKey: "userScores")
                print("ユーザーデータをUserDefaultsから削除しました。")
            }
        }
    }

    
    func fetchScoresAndUpdateUserDefaults(uid: String) {
        let userRef = Firestore.firestore().collection("users").document(uid)
        userRef.getDocument { [weak self] (document, error) in
            DispatchQueue.main.async {
                if let document = document, document.exists {
                    if let data = document.data(), let scores = data["result_scores"] as? [String: Double] {
                        self?.updateUserDefaults(scores: scores)
                        print("スコアをUserDefaultsに保存しました: \(scores)")
                    } else {
                        print("スコアの取得に失敗しました。")
                    }
                } else {
                    print("ドキュメントが存在しません: \(error?.localizedDescription ?? "不明なエラー")")
                }
            }
        }
    }
    
    func updateUserDefaults(scores: [String: Double]) {
        let animalDetails = getAnimalTypeAndDetails(scores: scores)
        let recommendationResult = getMostNeededStudyMethod(scores: scores)
        let recommendationDescription = recommendationResult.description
        let recommendationSteps = recommendationResult.steps
        let recommendationResources = recommendationResult.resources
        
        debugPrint("Animal Type: \(animalDetails.name)")
        debugPrint("Recommendation Description: \(recommendationDescription)")
        debugPrint("Recommendation Steps: \(recommendationSteps)")
        debugPrint("Recommendation Resources: \(recommendationResources)")

        var currentProgress = UserDefaults.standard.dictionary(forKey: "learningProgress") as? [String: Bool] ?? [:]
        recommendationSteps.forEach { step in
            if currentProgress[step] == nil {
                currentProgress[step] = false
            }
        }

        UserDefaults.standard.set([
            "scores": scores,
            "animalType": animalDetails.name,
            "animalDescription": animalDetails.description,
            "imageName": animalDetails.imageName,
            "recommendation": recommendationDescription,
            "learningProgress": recommendationSteps.reduce(into: [String: Bool]()) { (dict, step) in
                dict[step] = false  // 最初はすべてのステップを未完了（false）として設定
            },
            "recommendationResources": recommendationResources
        ], forKey: "userData")
        if let userData = UserDefaults.standard.dictionary(forKey: "userData") {
            debugPrint("保存されたユーザーデータ: \(userData)")
        }
    }
    
    func saveLearningProgressToFirebase(uid: String, learningProgress: [String: Bool]) {
        let userRef = Firestore.firestore().collection("users").document(uid)
        userRef.updateData(["learningProgress": learningProgress]) { error in
            if let error = error {
                print("Learning progress の保存に失敗しました: \(error.localizedDescription)")
            } else {
                print("Learning progress を Firebase に保存しました")
            }
        }
    }
}
