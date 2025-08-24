import SwiftUI
import Combine
import SwiftData

@MainActor
class AddExerciseTemplateViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    @Published var selectedExercises: [Exercise]

    private var context: ModelContext
    var onDone: (([Exercise]) -> Void)?

    init(context: ModelContext, selected: [Exercise]) {
        self.context = context
        self.selectedExercises = selected
        fetchExercises()
    }

    private func fetchExercises() {
        let descriptor = FetchDescriptor<Exercise>(sortBy: [SortDescriptor(\.title)])
        if let result = try? context.fetch(descriptor) {
            exercises = result
        }
    }

    func toggleSelection(_ exercise: Exercise) {
        if let index = selectedExercises.firstIndex(where: { $0.persistentModelID == exercise.persistentModelID }) {
            selectedExercises.remove(at: index)
        } else {
            selectedExercises.append(exercise)
        }
    }
    
    func done() {
        onDone?(selectedExercises)
    }
}
