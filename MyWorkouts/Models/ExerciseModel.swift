import SwiftData
import Foundation

@Model
class Exercise: Identifiable {
    var name: String
    var descr: String?
    @Relationship(deleteRule: .cascade) var sets: [ExerciseSet] = []
    
    init(name: String, descr: String? = nil) {
        self.name = name
        self.descr = descr
    }
}
