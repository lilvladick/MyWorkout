import SwiftUI
import SwiftData

struct NewExerciseView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var emoji: String = "💪"
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Workout emoji") {
                    TextField("💪", text: $emoji)
                        .font(.largeTitle)
                        .frame(width: 60)
                        .multilineTextAlignment(.center)
                        .keyboardType(.default)
                        .onChange(of: emoji) { _, newValue in
                            if newValue.count > 1 {
                                emoji = String(newValue.prefix(1))
                            }
                        }
                }
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
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
    
    private func saveExercise() {
        let exercise = Exercise(title: title, descr: description.isEmpty ? nil : description, emoji: emoji)
        modelContext.insert(exercise)
        dismiss()
    }
}

#Preview {
    NewExerciseView()
}
