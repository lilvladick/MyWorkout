import SwiftData
import Combine
import SwiftUI

@MainActor
class ExerciseViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []

    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
        fetchExercises()
    }

    func fetchExercises() {
        let descriptor = FetchDescriptor<Exercise>(sortBy: [SortDescriptor(\.title)])
        if let result = try? context.fetch(descriptor) {
            exercises = result
        }
    }

    func deleteExercise(at offsets: IndexSet) {
        for index in offsets {
            let exercise = exercises[index]
            context.delete(exercise)
        }
        try? context.save()
        fetchExercises()
    }
}
