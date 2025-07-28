import Foundation
import SwiftData

@Model
class WorkoutExercise: Identifiable {
    @Relationship var template: Exercise
    @Relationship(deleteRule: .cascade) var sets: [ExerciseSet] = []

    init(template: Exercise) {
        self.template = template
    }
}
