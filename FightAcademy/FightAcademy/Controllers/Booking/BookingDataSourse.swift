//
//  BookingDataSourse.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 24.03.2021.
//

import UIKit

class BookingDataSourse<Cell: TimeCollectionViewCell>: NSObject, UICollectionViewDataSource {
    
    var slots: [TimeSlot]
    
    init(slots: [TimeSlot]) {
        self.slots = slots
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: slots[indexPath.row])
        return cell
    }
}
