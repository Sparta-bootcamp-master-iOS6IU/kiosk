protocol CartDelegate: AnyObject {
    func didAddTicket(_ ticket: Ticket)
    func didAddDuplicatedTicket()
    func didChangeTicket()
    func didExceedMaxCount()
    func didReachZeroCount(_ ticket: Ticket)
}
