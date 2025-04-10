import UIKit

extension MainViewController: CartDelegate {
    func didChangeTicket() {
        reloadCartSection()
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

    func didReachZeroCount() {
        reloadCartSection()
    }

    private func reloadCartSection() {
        guard var snapshot = dataSource?.snapshot() else { return }

        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .cart))

        let cartItems = mainViewModel.ticketList.map { MovieItem.cart($0) }
        snapshot.appendItems(cartItems, toSection: .cart)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
