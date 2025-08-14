import SwiftData
import Foundation


@Model
class Workout {
    var date: Date
    var title: String
    @Relationship(deleteRule: .cascade) var exercises: [WorkoutExercise] = []

    init(date: Date, title: String) {
        self.date = date
        self.title = title
    }
}
