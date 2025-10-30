import SwiftUI

struct PersonCard: View {
    let person: Pages.Persons
    let imageUrl = "https://cdn.thesimpsonsapi.com/200"

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: imageUrl + person.portraitPath)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        //.frame(width: 100, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                case .failure:
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                @unknown default:
                    EmptyView()
                }
            }
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.headline)
                    .lineLimit(1)
                    //.multilineTextAlignment(.leading)
                Text(person.occupation ?? "Unknown occupation")
                    //.multilineTextAlignment(.leading)
                    .lineLimit(1)
                    //.frame(width: 100)
            }
            .padding(.bottom, 6)
            VStack(alignment: .leading) {
                HStack {
                    Text("Age: \(person.age?.description ?? "—")")
                    Text(person.status ?? "")
                }
                Text(person.phrases?.randomElement() ?? "")
                    //.multilineTextAlignment(.leading)
                    .lineLimit(1)
                    //.frame(width: 100)
            }
        }
        .padding(8)
        .background(Color(.systemBackground))
        //.cornerRadius(12)
        //.shadow(radius: 2)
        .frame(maxWidth: .infinity, minHeight: 200, alignment: .topLeading) // <-- одинаковая высота
    }
}

#Preview {
    PersonCard(person: Pages.Persons(
        id: 1,
        age: 39,
        birthdate: "1956-05-12",
        gender: "Male",
        name: "Homer Simpson",
        occupation: "Safety Inspector",
        portraitPath: "https://cdn.thesimpsonsapi.com/200/character/1.webp",
        phrases: ["D'oh!"],
        status: "Alive"
    ))
}
