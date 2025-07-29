import SwiftUI

struct ExerciseRow: View {
    let title: String
    let description: String?
    let emoji: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(emoji).font(.largeTitle)
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                if let desc = description, !desc.isEmpty {
                    Text(desc)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: Color.indigo.opacity(0.1), radius: 6, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.indigo.opacity(0.15), lineWidth: 0.5)
        )
    }
}
