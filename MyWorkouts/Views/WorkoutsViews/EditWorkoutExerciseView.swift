import SwiftData
import SwiftUI

struct EditWorkoutExerciseView: View {
    @AppStorage("preferredUnit") private var weightUnit: String = "kg"
    @Bindable var workoutExercise: WorkoutExercise
    @State private var weight: String = ""
    @State private var reps: String = ""

    var body: some View {
        Form {
            Section(header: Text("Add exercise set")) {
                TextField("Weight", text: $weight)
                    .keyboardType(.decimalPad)
                TextField("Repeats", text: $reps)
                    .keyboardType(.numberPad)
                Button("Add") {
                    if let w = Double(weight), let r = Int(reps) {
                        workoutExercise.sets.append(ExerciseSet(weight: w, reps: r))
                        weight = ""
                        reps = ""
                    }
                }
            }

            Section(header: Text("Sets")) {
                ForEach(workoutExercise.sets) { set in
                    Text("Weight: \(String(format: "%.2f", set.weight)) \(weightUnit), Repeats: \(set.reps)")
                }
            }
        }
        .navigationTitle(workoutExercise.template.name)
    }
}
