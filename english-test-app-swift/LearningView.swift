import SwiftUI
import FirebaseAuth

struct LearningView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var userData: [String: Any] = UserDefaults.standard.dictionary(forKey: "userData") ?? [:]
    @State private var learningProgress: [String: Bool] = [:]

    var body: some View {
        VStack {
            if let recommendation = userData["recommendation"] as? String {
                Text("おすすめの学習方法")
                    .font(.headline)
                    .padding()

                Text(recommendation)
                    .padding()

                if let steps = userData["learningProgress"] as? [String: Bool] {
                    List(steps.keys.sorted().reversed(), id: \.self) { step in
                        HStack {
                            Text(step)
                            Spacer()
                            Button(action: {
                                let currentStatus = learningProgress[step] ?? false
                                learningProgress[step] = !currentStatus
                                userData["learningProgress"] = learningProgress
                                UserDefaults.standard.set(userData, forKey: "userData")
                                if let uid = Auth.auth().currentUser?.uid {
                                    viewModel.saveLearningProgressToFirebase(uid: uid, learningProgress: learningProgress)
                                }
                                print("Updated learning progress for \(step): \(learningProgress[step] ?? false)")
                            }) {
                                Image(systemName: learningProgress[step] ?? false ? "checkmark.circle.fill" : "circle")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                if let resources = userData["recommendationResources"] as? [String] {
                    if resources.contains(where: { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) {
                        VStack(alignment: .leading) {
                            Text("リソースリンク:")
                                .font(.headline)
                                .padding(.top)
                            ForEach(resources.filter({ !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }), id: \.self) { resource in
                                Link(destination: URL(string: resource)!) {
                                    Text(resource)
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .padding()
                    }
                }
            } else {
                Text("現在おすすめの学習方法はありません。")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            self.learningProgress = userData["learningProgress"] as? [String: Bool] ?? [:]
            print("Loaded learning progress on appear: \(self.learningProgress)")
        }
        .navigationBarTitle("学習ページ", displayMode: .inline)
    }
}
