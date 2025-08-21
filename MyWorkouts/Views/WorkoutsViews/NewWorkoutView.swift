import SwiftData
import SwiftUI

struct NewWorkoutView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
        
    @State private var title: String = ""
    @State private var date: Date = Date()
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var exercises: [WorkoutExercise] = []
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Workout Information")) {
                    TextField("Title", text: $title)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                
                Section(header: Text("Workout Time")) {
                    DatePicker("Start Time", selection: $startTime, displayedComponents: [.hourAndMinute])
                    DatePicker("End Time", selection: $endTime, displayedComponents: [.hourAndMinute])
                }

                Section(header: Text("Exercises")) {
                    if exercises.isEmpty {
                        Text("No exercises added yet")
                            .foregroundStyle(.secondary)
                    }

                    ForEach(exercises) { workoutExercise in
                        NavigationLink {
                            EditWorkoutExerciseView(workoutExercise: workoutExercise)
                        } label: {
                            Text(workoutExercise.template.title)
                        }
                    }
                    .onDelete(perform: deleteExercise)

                    NavigationLink("Add Exercise") {
                        AddExerciseTemplateView(
                            selectedExercises: Binding(
                                get: { exercises.map { $0.template } },
                                set: { newTemplates in
                                    exercises = newTemplates.map { WorkoutExercise(template: $0) }
                                }
                            )
                        )
                        
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Clear") {
                        clearForm()
                    }
                    .disabled(title.isEmpty && exercises.isEmpty)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                       saveWorkout()
                        dismiss()
                   }
                   .disabled(title.isEmpty || exercises.isEmpty)
                }
            }
        }
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }

    private func saveWorkout() {
        let workout = Workout(date: date, title: title, startTime: startTime, endTime: endTime)
        workout.exercises = exercises

        context.insert(workout)

        do {
            try context.save()
            clearForm()
        } catch {
            print("Failed to save workout:", error.localizedDescription)
        }
    }

    private func clearForm() {
        title = ""
        date = Date()
        exercises = []
    }
}
