struct DefaultTicketCountUseCase: TicketCountUseCase {
    private typealias Count = DomainConstant.TicketCount

    func changeCount(of ticket: Ticket, delta: Int) -> Result<Ticket, TicketCountError> {
        let count = ticket.count + delta

        guard (Count.min ... Count.max).contains(count) else {
            return count > Count.max ? .failure(.exceed) : .failure(.zero)
        }

        var updated = ticket
        updated.count = count

        return .success(updated)
    }
}
