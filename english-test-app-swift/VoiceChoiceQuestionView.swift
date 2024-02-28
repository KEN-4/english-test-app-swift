//
//  VoiceChoiceQuestionView.swift
//  english-test-app-swift
//
//  Created by 内藤広貴 on 2024/02/26.
//

import SwiftUI

struct VoiceChoiceQuestionView: View {
    @ObservedObject var viewModel: QuestionViewModel
    
    var body: some View {
        VStack {
            if let question = viewModel.currentQuestion {
                Text("音声の続きの選択肢を選んでください")
                Button("Play Audio") {
                    viewModel.playAudio(from: question.audioUrl)
                }
                ForEach(question.choices, id: \.self) { choice in
                    Button(choice) {
                        viewModel.checkAnswer(choice: choice)
                    }
                    .disabled(viewModel.isAnswered)
                }
                if viewModel.isAnswered {
                    Text("正解: \(question.correctAnswer)")
                    Button("次の質問") {
                        viewModel.goToNextQuestion()
                    }
                }
            } else {
                Text("質問をロード中...")
            }
        }
    }
}
