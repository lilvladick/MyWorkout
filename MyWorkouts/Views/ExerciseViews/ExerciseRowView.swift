import SwiftUI

struct ExerciseRow: View {
    let title: String
    let description: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title).font(.headline)
            if let desc = description, !desc.isEmpty {
                Text(desc).font(.subheadline).foregroundStyle(.secondary)
            }
        }.padding(.vertical, 4)
    }
}
