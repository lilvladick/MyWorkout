import SwiftData
import SwiftUI

struct AddExerciseTemplateView: View {
    @Query private var exercises: [Exercise]
    var onSelect: (Exercise) -> Void

    var body: some View {
        List {
            ForEach(exercises) { exercise in
                Button {
                    onSelect(exercise)
                } label: {
                    Text(exercise.name)
                }
            }
        }
        .navigationTitle("Select Exercise")
    }
}
