import SwiftUI

struct LearningView: View {
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
                    List(steps.keys.sorted(), id: \.self) { step in
                        HStack {
                            Text(step)
                            Spacer()
                            Button(action: {
                                let currentStatus = learningProgress[step] ?? false
                                learningProgress[step] = !currentStatus
                                userData["learningProgress"] = learningProgress
                                UserDefaults.standard.set(userData, forKey: "userData")
                                print("Updated learning progress for \(step): \(learningProgress[step] ?? false)")
                            }) {
                                Image(systemName: learningProgress[step] ?? false ? "checkmark.circle.fill" : "circle")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                // リソースリンクの表示
                if let resources = userData["recommendationResources"] as? [String] {
                    VStack(alignment: .leading) {
                        Text("リソースリンク:")
                            .font(.headline)
                            .padding(.top)
                        ForEach(resources, id: \.self) { resource in
                            Link(destination: URL(string: resource)!) {
                                Text(resource)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding()
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
