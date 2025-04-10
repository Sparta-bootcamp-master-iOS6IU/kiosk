protocol TicketPriceUseCase {
    func changePrice(of ticket: Ticket) -> Ticket
}
