//
//  BookingActivityViewController.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 22.03.2021.
//

import UIKit
import FSCalendar

protocol BookingNewActivity: UIViewController {

    var onSelectActivityType: (() -> Void)? { get set }
    var onSelectCoach: (() -> Void)? { get set }
    var onRequestActivity: (() -> Void)? { get set }

}

class BookingActivityViewController: UIViewController, BookingNewActivity, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet private weak var chooseCoachButton: UIButton!
    @IBOutlet private weak var chooseActivityButton: UIButton!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var activityLabel: UILabel!
    @IBOutlet private weak var calendar: FSCalendar!
    @IBOutlet private weak var coachNameLabel: UILabel!
    @IBOutlet private weak var timeCollectionView: UICollectionView!
    @IBOutlet private weak var timeHeightConstraint: NSLayoutConstraint!
    
    private var timeSlots: [TimeSlot] = TimeSlotsMock.make()
    private var dataSourse: BookingDataSourse<TimeCollectionViewCell>?
    
    var onRequestActivity: (() -> Void)?
    var onSelectCoach: (() -> Void)?
    var onSelectActivityType: (() -> Void)?
    
    @IBAction func chooseCoachButtonAction(_ sender: UIButton) {
        chooseCoach()
    }
    @IBAction func chooseActivityButtonAction(_ sender: UIButton) {
        chooseActivity()
    }
    @IBAction func doneButtonAction(_ sender: UIButton) {
        requestForActivity()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Booking Activity"
        setupCollectionView()
        calendar.dataSource = self
        calendar.delegate = self
        
    }
    
    @objc private func chooseActivity() {
        onSelectActivityType?()
    }
    
    @objc private func chooseCoach() {
        onSelectCoach?()
    }
    
    @objc private func requestForActivity() {
        onRequestActivity?()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .itemSize
        layout.minimumLineSpacing = .lineSpacing
        timeCollectionView.collectionViewLayout = layout
        let numberOfRows = ceil(CGFloat(timeSlots.count) / .numberOfColumns)
        timeHeightConstraint.constant = (numberOfRows - 1) * .lineSpacing + numberOfRows * .cellHeight
        view.layoutIfNeeded()
        dataSourse = BookingDataSourse<TimeCollectionViewCell>(slots: timeSlots)
        timeCollectionView.register(TimeCollectionViewCell.cellNib,
                                    forCellWithReuseIdentifier: TimeCollectionViewCell.reuseIdentifier)
        timeCollectionView.dataSource = dataSourse
    }
}

private extension CGSize {
    static var itemSize: CGSize { return CGSize(width: (UIScreen.main.bounds.width - .horizontalMargins) / .numberOfColumns,
                                                height: .cellHeight)}
}

private extension CGFloat {
    static var numberOfColumns: CGFloat { return 3 }
    static var horizontalMargins: CGFloat { return 52 }
    static var lineSpacing: CGFloat { return 6 }
    static var cellHeight: CGFloat { return 40 }
}
