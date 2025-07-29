import SwiftData
import Foundation

@Model
class Exercise: Identifiable {
    var name: String
    var descr: String?
    var emoji: String = "💪"
    @Relationship(deleteRule: .cascade) var sets: [ExerciseSet] = []

    init(name: String, descr: String? = nil, emoji: String = "💪") {
        self.name = name
        self.descr = descr
        self.emoji = emoji
    }
}
