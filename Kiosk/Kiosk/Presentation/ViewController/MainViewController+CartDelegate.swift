import UIKit

extension MainViewController: CartDelegate {
    private typealias Alert = CartConstant.Alert

    func didChangeCurrentPage() {
        for cell in collectionView.collectionView.visibleCells {
            guard let cell = cell as? MovieInfoCell else { continue }
            cell.setSelectedOption(isSeniorSelected: false, isDisabledSelected: false)
        }
    }

    func didAddTicket(_ ticket: Ticket) {
        guard let dataSource else { return }
        var snapshot = dataSource.snapshot()

        snapshot.appendItems([.cart(ticket)], toSection: .cart)
        dataSource.apply(snapshot, animatingDifferences: true)

        updateCartHeader()
    }

    func didAddDuplicatedTicket() {
        let alert = UIAlertController(
            title: Alert.title,
            message: Alert.duplicateMessage,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: Alert.confirm, style: .default))

        present(alert, animated: true)
    }

    func didChangeTicket() {
        reloadCartSection()
        updateCartHeader()
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
            self?.updateCartHeader()
        })

        present(alert, animated: true)
    }

    func reloadCartSection() {
        guard var snapshot = dataSource?.snapshot() else { return }

        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .cart))

        let cartItems = mainViewModel.ticketList.map { MovieItem.cart($0) }
        snapshot.appendItems(cartItems, toSection: .cart)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    func updateCartHeader() {
        guard let index = sections.firstIndex(of: .cart) else {
            return
        }
        let indexPath = IndexPath(item: 0, section: index)

        if let headerView = collectionView.collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: indexPath
        ) as? SectionHeaderView {
            let totalCount = mainViewModel.totalCount()
            headerView.updateTitle(totalCount: totalCount)
        }
    }
}
