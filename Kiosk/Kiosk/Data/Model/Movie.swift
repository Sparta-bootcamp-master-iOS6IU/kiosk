struct Movie: Hashable, Decodable {
    let title: String
    let genre: String
    let date: String
    let actor: String
    let synopsis: String
    let price: Int
    let seniorPrice: Int
    let disabledPrice: Int
    let totalTicketCount: Int
    let image: String

    enum CodingKeys: String, CodingKey {
        case title,
             genre,
             date,
             actor,
             synopsis,
             price,
             seniorPrice = "senior_price",
             disabledPrice = "disabled_price",
             totalTicketCount,
             image
    }
}
