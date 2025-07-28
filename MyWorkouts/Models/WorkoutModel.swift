import SwiftData
import Foundation


@Model
class Workout {
    var date: Date
    var name: String
    @Relationship(deleteRule: .cascade) var exercises: [WorkoutExercise] = []

    init(date: Date, name: String) {
        self.date = date
        self.name = name
    }
}
