import SwiftUI
import SwiftData
import Combine

@MainActor
class WorkoutNewViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var date: Date = Date()
    @Published var startTime: Date = Date()
    @Published var endTime: Date = Date()
    @Published var exercises: [WorkoutExercise] = []

    private(set) var context: ModelContext?

    init(context: ModelContext? = nil) {
        self.context = context
    }

    func setContext(_ context: ModelContext) {
        self.context = context
    }
    
    func addExercise(_ template: Exercise) {
        exercises.append(WorkoutExercise(template: template))
    }
    
    func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }
    
    func clearForm() {
        title = ""
        date = Date()
        startTime = Date()
        endTime = Date()
        exercises = []
    }
    
    func saveWorkout() throws {
        guard let context else { return }
        
        let workout = Workout(
            date: date,
            title: title,
            startTime: startTime,
            endTime: endTime
        )
        workout.exercises = exercises
        context.insert(workout)
        try context.save()
        clearForm()
    }
    
    var canSave: Bool {
        !title.isEmpty && !exercises.isEmpty
    }
    
    var canClear: Bool {
        !title.isEmpty || !exercises.isEmpty
    }
}
