import SwiftUI

struct PersonCardView: View {
    let person: Pages.Persons
    let refreshToken: UUID
    let imageUrlBase = "https://cdn.thesimpsonsapi.com/200"

    var body: some View {
        let imageUrl = imageUrlBase + person.portraitPath + "?t=\(refreshToken.uuidString)"
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                case .failure:
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                @unknown default:
                    EmptyView()
                }
            }
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.headline)
                    .lineLimit(1)
                Text(person.occupation ?? "Unknown occupation")
                    .lineLimit(1)
            }
            .padding(.bottom, 6)
            VStack(alignment: .leading) {
                HStack {
                    Text("Age: \(person.age?.description ?? "—")")
                    Text(person.status ?? " ")
                }
                Text(person.phrases?.randomElement() ?? " ")
                    .lineLimit(1)
            }
        }
        .padding(8)
        .background(Color(.systemBackground))
        .frame(maxWidth: .infinity, minHeight: 200, alignment: .topLeading)
    }
}

#Preview {
    PersonCardView(person: Pages.Persons(
        id: 1,
        age: 39,
        birthdate: "1956-05-12",
        gender: "Male",
        name: "Homer Simpson",
        occupation: "Safety Inspector",
        portraitPath: "https://cdn.thesimpsonsapi.com/200/character/1.webp",
        phrases: ["D'oh!"],
        status: "Alive"
    ), refreshToken: UUID())
}
