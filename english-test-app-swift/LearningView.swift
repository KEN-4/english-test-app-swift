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
                                let newValue = !(learningProgress[step] ?? false)
                                learningProgress[step] = newValue
                                UserDefaults.standard.set(learningProgress, forKey: "learningProgress")
                                print("Step: \(step), New Value: \(newValue)") // Debug print statement
                            }) {
                                Image(systemName: learningProgress[step] ?? false ? "checkmark.circle.fill" : "circle")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
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
