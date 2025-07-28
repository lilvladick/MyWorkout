import SwiftUI
import SwiftData

struct NewExerciseView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    var body: some View {
        NavigationStack {
            Form {
                Section("Exercise name") {
                    TextField("Example: Bench press", text: $title)
                }
                Section("Description (Optional)") {
                    TextField("Enter description", text: $description)
                }
                
            }
            .navigationTitle(Text("New Exercise"))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .cancel, action: {
                        dismiss()
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .confirm, action: {
                        saveExercise()
                    })
                }
            }
        }
    }
    
    private func saveExercise() {
        let exercise = Exercise(name: title, descr: description.isEmpty ? nil : description)
        modelContext.insert(exercise)
        dismiss()
    }
}

#Preview {
    NewExerciseView()
}
