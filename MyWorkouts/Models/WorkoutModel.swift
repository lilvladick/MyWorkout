import SwiftData
import Foundation


@Model
class Workout {
    var date: Date
    var startTime: Date
    var endTime: Date
    var title: String
    @Relationship(deleteRule: .cascade) var exercises: [WorkoutExercise] = []

    init(date: Date, title: String, startTime: Date, endTime: Date) {
        self.date = date
        self.title = title
        self.startTime = startTime
        self.endTime = endTime
    }
}
