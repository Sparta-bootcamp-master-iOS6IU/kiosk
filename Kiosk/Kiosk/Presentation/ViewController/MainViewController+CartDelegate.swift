import UIKit

extension MainViewController: CartDelegate {
    private typealias Alert = CartConstant.Alert

    func didChangeTicket() {
        reloadCartSection()
    }

    func didExceedMaxCount() {
        let alert = UIAlertController(
            title: Alert.title,
            message: Alert.increaseMessage,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: Alert.confirm, style: .default))

        present(alert, animated: true)
    }

    func didReachZeroCount(_ ticket: Ticket) {
        let alert = UIAlertController(
            title: Alert.title,
            message: Alert.decreaseMessage,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: Alert.cancel, style: .cancel))

        alert.addAction(UIAlertAction(title: Alert.remove, style: .destructive) { [weak self] _ in
            self?.mainViewModel.remove(ticket: ticket)
            self?.reloadCartSection()
        })

        present(alert, animated: true)
    }

    private func reloadCartSection() {
        guard var snapshot = dataSource?.snapshot() else { return }

        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .cart))

        let cartItems = mainViewModel.ticketList.map { MovieItem.cart($0) }
        snapshot.appendItems(cartItems, toSection: .cart)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
