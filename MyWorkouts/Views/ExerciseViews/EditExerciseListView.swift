import SwiftData
import SwiftUI

struct EditExerciseListView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel: EditExerciseListViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.exercises, id: \.persistentModelID) { exercise in
                    VStack(alignment: .leading) {
                        Text(exercise.title).bold()
                        if let descr = exercise.descr, !descr.isEmpty {
                            Text(descr)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationTitle("Edit Exercises")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

