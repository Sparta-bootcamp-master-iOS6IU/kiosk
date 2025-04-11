protocol CartDelegate: AnyObject {
    func didChangeCurrentPage(page: Int, of totalPages: Int)
    func didAddTicket(_ ticket: Ticket)
    func didAddDuplicatedTicket()
    func didChangeTicket()
    func didExceedMaxCount()
    func didReachZeroCount(_ ticket: Ticket)
}
