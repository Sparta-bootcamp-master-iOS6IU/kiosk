protocol CartDelegate: AnyObject {
    func didChangeTicket(_ ticket: Ticket)
    func didExceedMaxCount()
    func didReachZeroCount(_ ticket: Ticket)
}
