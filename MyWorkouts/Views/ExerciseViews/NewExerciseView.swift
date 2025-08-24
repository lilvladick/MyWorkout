import SwiftUI
import SwiftData

struct NewExerciseView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: NewExerciseViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Workout emoji") {
                    TextField("💪", text: $viewModel.emoji)
                        .font(.largeTitle)
                        .frame(width: 60)
                        .multilineTextAlignment(.center)
                        .keyboardType(.default)
                        .onChange(of: viewModel.emoji) { _, newValue in
                            if newValue.count > 1 {
                                viewModel.emoji = String(newValue.prefix(1))
                            }
                        }
                }
                Section("Exercise name") {
                    TextField("Example: Bench press", text: $viewModel.title)
                }
                Section("Description (Optional)") {
                    TextField("Enter description", text: $viewModel.description)
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
                        viewModel.saveExercise()
                        dismiss()
                    })
                    .disabled(viewModel.title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
