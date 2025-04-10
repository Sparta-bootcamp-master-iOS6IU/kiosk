protocol CartDelegate: AnyObject {
    func didChangeTicket()
    func didExceedMaxCount()
    func didReachZeroCount(_ ticket: Ticket)
}
