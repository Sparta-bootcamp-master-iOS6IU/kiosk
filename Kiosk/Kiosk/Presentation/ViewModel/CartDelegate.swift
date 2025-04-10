protocol CartDelegate: AnyObject {
    func didChangeCurrentPage()
    func didAddTicket(_ ticket: Ticket)
    func didAddDuplicatedTicket()
    func didChangeTicket()
    func didExceedMaxCount()
    func didReachZeroCount(_ ticket: Ticket)
}
