import SwiftData
import SwiftUI

struct AddExerciseTemplateView: View {
    @Query private var Exercises: [Exercise]
    
    @Binding var selectedExercises: [Exercise]
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            ForEach(Exercises, id: \.persistentModelID) { exercise in
                Button {
                    toggleSelection(exercise)
                } label: {
                    HStack {
                        Text(exercise.title)
                        Spacer()
                        if selectedExercises.contains(where: { $0.persistentModelID == exercise.persistentModelID }) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
        }
        .navigationTitle("Select Exercises")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
    
    private func toggleSelection(_ exercise: Exercise) {
        if let index = selectedExercises.firstIndex(where: { $0.persistentModelID == exercise.persistentModelID }) {
            selectedExercises.remove(at: index)
        } else {
            selectedExercises.append(exercise)
        }
    }
}
