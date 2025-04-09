struct Ticket {
    let movieId: String
    let title: String
    let originalPrice: Int
    let discountedPrice: Int
    let discountCategory: BenefitOption?
    var count: Int
}
