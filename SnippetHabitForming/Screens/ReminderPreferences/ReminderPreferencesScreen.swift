import SwiftUI

struct ReminderPreferencesScreen: View {
    @Binding var route: AppRoute

    var body: some View {
        FigmaScaledCanvas(background: .soft) {
            IconButton(systemName: "house", action: { route = .home })
                .position(x: 824, y: 56)

            VStack(spacing: 0) {
                PreferenceRow(icon: "hand.raised.fill", title: "Gentle Nudges", subtitle: "How should I remind you to play?")
                Divider().background(.black.opacity(0.08))
                Button {
                    route = .routineBuilder
                } label: {
                    PreferenceRow(icon: "bell.fill", title: "Daily Reminder", subtitle: "9:00 AM - Mon, Wed, Fri")
                }
                .buttonStyle(.plain)
                Divider().background(.black.opacity(0.08))
                PreferenceRow(icon: "moon.fill", title: "Quiet Hours", subtitle: "10:00 PM - 7:00 AM")
                Divider().background(.black.opacity(0.08))
                PreferenceRow(icon: "message.fill", title: "Nudge Style", subtitle: "Playful & Encouraging")
            }
            .padding(.vertical, 12)
            .frame(width: 434, height: 247)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(HabitDesign.paper)
                    .shadow(color: .black.opacity(0.22), radius: 5, x: 3, y: 5)
            )
            .position(x: 437, y: 201)
        }
    }
}

private struct PreferenceRow: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 22) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.black)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .figmaText(16, weight: .bold)
                Text(subtitle)
                    .figmaText(12)
            }

            Spacer()
        }
        .frame(height: 54)
        .padding(.horizontal, 30)
    }
}
