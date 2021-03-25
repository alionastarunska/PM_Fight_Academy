//
//  BookingActivityViewController.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 22.03.2021.
//

import UIKit
import FSCalendar

protocol BookingNewActivity: UIViewController {

    var onSelectActivityType: ((BookingDelegate) -> Void)? { get set }
    var onSelectCoach: ((BookingDelegate) -> Void)? { get set }
    var onRequestActivity: (() -> Void)? { get set }

}

protocol BookingDelegate: class {
    
    func didSelect(_ activity: ChoosingActivityModel)
    func didSelect(_ coach: Coach)
    
}

class BookingActivityViewController: UIViewController, BookingNewActivity {
    
    @IBOutlet private weak var chooseCoachButton: UIButton!
    @IBOutlet private weak var chooseActivityButton: UIButton!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var activityLabel: UILabel!
    @IBOutlet private weak var calendar: FSCalendar!
    @IBOutlet private weak var coachNameLabel: UILabel!
    @IBOutlet private weak var timeCollectionView: UICollectionView!
    @IBOutlet private weak var timeHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var timeSlots: [TimeSlot] = TimeSlotsMock.make()
    private var dataSource: BookingDataSource<TimeCollectionViewCell>?
    
    private var selectedActivity: ChoosingActivityModel?
    private var selectedCoach: Coach?
    private var selectedDate: Date?
    private var selectedTimeSlot: TimeSlot?
    
    var onRequestActivity: (() -> Void)?
    var onSelectCoach: ((BookingDelegate) -> Void)?
    var onSelectActivityType: ((BookingDelegate) -> Void)?
    
    @IBAction func chooseCoachButtonAction(_ sender: UIButton) {
        onSelectCoach?(self)
    }
    
    @IBAction func chooseActivityButtonAction(_ sender: UIButton) {
        onSelectActivityType?(self)
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        guard let activity = selectedActivity else {
            error()
            activityLabel.superview?.shake()
            scrollView.setContentOffset(.zero, animated: true)
            return
        }
        guard let coach = selectedCoach else {
            error()
            coachNameLabel.superview?.shake()
            scrollView.setContentOffset(.zero, animated: true)
            return
        }
        guard let date = selectedDate else {
            error()
            calendar.shake()
            return
        }
        guard let timeSlot = selectedTimeSlot else {
            error()
            timeCollectionView.shake()
            return
        }
        onRequestActivity?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Booking Activity"
        setupCollectionView()
        calendar.dataSource = self
        calendar.delegate = self
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
        dataSource = BookingDataSource<TimeCollectionViewCell>(slots: timeSlots)
        timeCollectionView.register(TimeCollectionViewCell.cellNib,
                                    forCellWithReuseIdentifier: TimeCollectionViewCell.reuseIdentifier)
        timeCollectionView.dataSource = dataSource
        timeCollectionView.delegate = self
    }
    
    private func error() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}

extension BookingActivityViewController: BookingDelegate {
    func didSelect(_ coach: Coach) {
        selectedCoach = coach
        coachNameLabel.text = coach.fullName
        calendar.alpha = 1
        calendar.isUserInteractionEnabled = true
    }
    
    func didSelect(_ activity: ChoosingActivityModel) {
        selectedActivity = activity
        activityLabel.text = activity.name
        chooseCoachButton.isEnabled = true
        chooseCoachButton.superview?.alpha = 1
    }
}

extension BookingActivityViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        timeCollectionView.alpha = 1
        timeCollectionView.isUserInteractionEnabled = true
    }
}

extension BookingActivityViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard timeSlots.indices.contains(indexPath.item) else { return }
        selectedTimeSlot = timeSlots[indexPath.item]
    }
}

private extension CGSize {
    static var itemSize: CGSize { return CGSize(width: (UIScreen.main.bounds.width - .horizontalMargins) / .numberOfColumns,
                                                height: .cellHeight)}
}

private extension CGFloat {
    static var numberOfColumns: CGFloat { return 3 }
    static var horizontalMargins: CGFloat { return 55 }
    static var lineSpacing: CGFloat { return 6 }
    static var cellHeight: CGFloat { return 40 }
}
