import UIKit

extension MainViewController: CartDelegate {
    func didChangeTicket(_ ticket: Ticket) {
        updateCartSection(for: ticket) { items, index in
            items[index] = .cart(ticket)
        }
    }

    func didExceedMaxCount() {
        let alert = UIAlertController(
            title: CartConstant.Alert.title,
            message: CartConstant.Alert.message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: CartConstant.Alert.confirm, style: .default))

        present(alert, animated: true)
    }

    func didReachZeroCount(_ ticket: Ticket) {
        updateCartSection(for: ticket) { items, index in
            items.remove(at: index)
        }
    }

    private func updateCartSection(for ticket: Ticket, update: (inout [MovieItem], Int) -> Void) {
        guard var snapshot = dataSource?.snapshot() else { return }

        var cartItems = snapshot.itemIdentifiers(inSection: .cart)

        if let index = cartItems.firstIndex(where: {
            guard case let .cart(existingTicket) = $0 else { return false }
            return existingTicket.movieId == ticket.movieId &&
                existingTicket.discountCategory == ticket.discountCategory
        }) {
            update(&cartItems, index)

            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .cart))
            snapshot.appendItems(cartItems, toSection: .cart)
            dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
}
