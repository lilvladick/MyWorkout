import SwiftData
import Foundation

@Model
class Exercise: Identifiable {
    var title: String
    var descr: String?
    var emoji: String = "💪"
    @Relationship(deleteRule: .cascade) var sets: [ExerciseSet] = []

    init(title: String, descr: String? = nil, emoji: String = "💪") {
        self.title = title
        self.descr = descr
        self.emoji = emoji
    }
}
