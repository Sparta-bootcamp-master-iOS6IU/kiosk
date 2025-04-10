protocol CartDelegate: AnyObject {
    func didAddTicket(_ ticket: Ticket)
    func didChangeTicket(_ ticket: Ticket)
    func didExceedMaxCount()
    func didReachZeroCount(_ ticket: Ticket)
}
