import Foundation
import SwiftData

@Model
class UserData {
    var createdAt: Date
    var email: String
    var resultScores: [String: Double]
    var animalType: String
    var animalDescription: String
    var imageName: String
    var recommendation: String
    var learningProgress: [String: Bool]
    var recommendationResources: [String]
    
    init(createdAt: Date, email: String, resultScores: [String : Double], animalType: String, animalDescription: String, imageName: String, recommendation: String, learningProgress: [String : Bool], recommendationResources: [String]) {
        self.createdAt = createdAt
        self.email = email
        self.resultScores = resultScores
        self.animalType = animalType
        self.animalDescription = animalDescription
        self.imageName = imageName
        self.recommendation = recommendation
        self.learningProgress = learningProgress
        self.recommendationResources = recommendationResources
    }
}
