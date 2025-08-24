import Combine
import SwiftUI
import SwiftData

@MainActor
class EditExerciseListViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    
    private var context: ModelContext
    
    var onDone: (() -> Void)?

    init(context: ModelContext, onDone: (() -> Void)? = nil) {
        self.context = context
        self.onDone = onDone
        fetchExercises()
    }

    private func fetchExercises() {
        let descriptor = FetchDescriptor<Exercise>(sortBy: [SortDescriptor(\.title)])
        if let result = try? context.fetch(descriptor) {
            exercises = result
        }
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            let exercise = exercises[index]
            context.delete(exercise)
        }
        try? context.save()
        fetchExercises()
        onDone?()
    }
}
