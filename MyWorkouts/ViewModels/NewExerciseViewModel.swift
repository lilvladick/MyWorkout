import Combine
import SwiftUI
import SwiftData

@MainActor
class NewExerciseViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var emoji: String = "💪"

    let context: ModelContext
    
    var onDone: (() -> Void)?

    init(context: ModelContext, onDone: (() -> Void)? = nil) {
        self.context = context
        self.onDone = onDone
    }
    func saveExercise() {
        let exercise = Exercise(title: title, descr: description.isEmpty ? nil : description, emoji: emoji)
        context.insert(exercise)
        try? context.save()
        onDone?()
    }
}
