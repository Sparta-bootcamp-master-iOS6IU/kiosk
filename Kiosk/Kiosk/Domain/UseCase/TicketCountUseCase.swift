protocol TicketCountUseCase {
    func changeCount(of ticket: Ticket, delta: Int) -> Result<Ticket, TicketCountError>
}
