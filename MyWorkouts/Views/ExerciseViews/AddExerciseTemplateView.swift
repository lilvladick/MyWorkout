import SwiftData
import SwiftUI

struct AddExerciseTemplateView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel: AddExerciseTemplateViewModel
    
    init(viewModel: AddExerciseTemplateViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.exercises, id: \.persistentModelID) { exercise in
                Button {
                    viewModel.toggleSelection(exercise)
                } label: {
                    HStack {
                        Text(exercise.title)
                        Spacer()
                        if viewModel.selectedExercises.contains(where: { $0.persistentModelID == exercise.persistentModelID }) {
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
                    viewModel.done()
                    dismiss()
                }
            }
        }
    }
}
