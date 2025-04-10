import Foundation

struct DefaultTicketPriceUseCase: TicketPriceUseCase {
    func changePrice(of ticket: Ticket) -> Ticket {
        let totalOriginalPrice = formatTotalPrice(price: ticket.originalPrice, count: ticket.count)

        let totalDiscountedPrice: String? = {
            guard let discountedPrice = ticket.discountedPrice else { return nil }

            return formatTotalPrice(price: discountedPrice, count: ticket.count)
        }()

        var updated = ticket
        updated.totalOriginalPrice = totalOriginalPrice
        updated.totalDiscountedPrice = totalDiscountedPrice

        return updated
    }

    private func formatTotalPrice(price: Int, count: Int) -> String {
        PriceFormatHelper.format(price * count)
    }
}
