import SwiftData
import SwiftUI

struct EditExerciseListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Query(sort: \Exercise.title) private var myExercises: [Exercise]

    var body: some View {
        NavigationStack {
            List {
                ForEach(myExercises, id: \.persistentModelID) { exercise in
                    VStack(alignment: .leading) {
                        Text(exercise.title).bold()
                        if let descr = exercise.descr, !descr.isEmpty {
                            Text(descr)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: delete)
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

    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let exercise = myExercises[index]
            context.delete(exercise)
        }
        try? context.save()
    }
}

