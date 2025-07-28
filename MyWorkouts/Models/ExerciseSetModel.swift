import SwiftData
import Foundation

@Model
class ExerciseSet: Identifiable {
    var weight: Double
    var reps: Int
    
    init(weight: Double, reps: Int) {
        self.weight = weight
        self.reps = reps
    }
}
