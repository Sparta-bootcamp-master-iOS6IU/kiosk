extension MainViewController: CartDelegate {
    func didChangeTicket(_ ticket: Ticket) {
        guard var snapshot = dataSource?.snapshot() else { return }

        var cartItems = snapshot.itemIdentifiers(inSection: .cart)
        let updatedItem = MovieItem.cart(ticket)

        if let index = cartItems.firstIndex(where: {
            guard case let .cart(existingTicket) = $0 else { return false }
            return existingTicket.movieId == ticket.movieId
                && existingTicket.discountCategory == ticket.discountCategory
        }) {
            cartItems[index] = updatedItem

            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .cart))
            snapshot.appendItems(cartItems, toSection: .cart)

            dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }

    func didExceedMaxCount() {}

    func didReachZeroCount(_: Ticket) {}
}
