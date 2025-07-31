import SwiftData
import SwiftUI

struct NewWorkoutView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
        
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var exercises: [WorkoutExercise] = []
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Workout Information")) {
                    TextField("Title", text: $name)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
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
                            Text(workoutExercise.template.name)
                        }
                    }
                    .onDelete(perform: deleteExercise)

                    NavigationLink("Add Exercise") {
                        AddExerciseTemplateView { template in
                            let newExercise = WorkoutExercise(template: template)
                            exercises.append(newExercise)
                        }
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Clear") {
                        clearForm()
                    }
                    .disabled(name.isEmpty && exercises.isEmpty)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                       saveWorkout()
                        dismiss()
                   }
                   .disabled(name.isEmpty || exercises.isEmpty)
                }
                ToolbarItem(placement: .automatic) {
                    EditButton()
                }
            }
        }
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }

    private func saveWorkout() {
        let workout = Workout(date: date, name: name)
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
        name = ""
        date = Date()
        exercises = []
    }
}
