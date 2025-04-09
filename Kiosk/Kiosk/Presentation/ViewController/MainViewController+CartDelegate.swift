extension MainViewController: CartDelegate {
    func didChangeTicket(_: Ticket) {}

    func didExceedMaxCount() {}

    func didReachZeroCount(_: Ticket) {}
}
