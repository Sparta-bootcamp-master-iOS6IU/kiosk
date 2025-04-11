struct Ticket: Hashable {
    let movieId: String
    let title: String
    let originalPrice: Int
    var totalOriginalPrice: String
    let discountedPrice: Int?
    var totalDiscountedPrice: String?
    let discountCategory: BenefitOption?
    var count: Int
}
