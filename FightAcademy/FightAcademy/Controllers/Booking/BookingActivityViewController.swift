//
//  BookingActivityViewController.swift
//  FightAcademy
//
//  Created by Aliona Starunska on 22.03.2021.
//

import UIKit
import FSCalendar

protocol BookingNewActivity: ErrorDisplaying, LoadingDisplaying {

    var onSelectActivityType: ((BookingDelegate) -> Void)? { get set }
    var onSelectCoach: ((BookingDelegate, TrainingType) -> Void)? { get set }
    var onRequestActivity: (() -> Void)? { get set }

}

protocol BookingDelegate: class {
    
    func didSelect(_ activity: TrainingType)
    func didSelect(_ coach: Coach)
    
}

class BookingActivityViewController: UIViewController, BookingNewActivity {
    
    var onRequestActivity: (() -> Void)?
    var onSelectCoach: ((BookingDelegate, TrainingType) -> Void)?
    var onSelectActivityType: ((BookingDelegate) -> Void)?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var chooseCoachButton: UIButton!
    @IBOutlet private weak var chooseActivityButton: UIButton!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var activityLabel: UILabel!
    @IBOutlet private weak var calendar: FSCalendar!
    @IBOutlet private weak var coachNameLabel: UILabel!
    @IBOutlet private weak var timeCollectionView: UICollectionView!
    @IBOutlet private weak var timeHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var trainingDates: [Date] = []
    private var timeSlots: [TrainingTime] = []
    private var dataSource: BookingDataSource<TimeCollectionViewCell>?
        
    // MARK: - Selected data
    
    private var selectedActivity: TrainingType?
    private var selectedCoach: Coach?
    private var selectedDate: Date?
    private var selectedTimeSlot: TrainingTime?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Booking Activity"
        setupCollectionView()
        calendar.dataSource = self
        calendar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.reloadData()
        calendar.calendarHeaderView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction private func chooseCoachButtonAction(_ sender: UIButton) {
        guard let activity = selectedActivity else { return }
        onSelectCoach?(self, activity)
    }
    
    @IBAction private func chooseActivityButtonAction(_ sender: UIButton) {
        onSelectActivityType?(self)
    }
    
    @IBAction private func doneButtonAction(_ sender: UIButton) {
        guard let activity = selectedActivity else {
            activityLabel.superview?.shake()
            scrollView.setContentOffset(.zero, animated: true)
            show(errorString: "Please select training type first")
            return
        }
        guard let coach = selectedCoach else {
            coachNameLabel.superview?.shake()
            scrollView.setContentOffset(.zero, animated: true)
            show(errorString: "Please select coach first")
            return
        }
        guard let date = selectedDate else {
            calendar.shake()
            show(errorString: "Please select date first")
            return
        }
        guard let timeSlot = selectedTimeSlot else {
            timeCollectionView.shake()
            show(errorString: "Please select time first")
            return
        }
        
        createBooking(activity, coach, date, timeSlot)
    }
    
    // MARK: - Private
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .itemSize
        layout.minimumLineSpacing = .lineSpacing
        timeCollectionView.collectionViewLayout = layout
        dataSource = BookingDataSource<TimeCollectionViewCell>(slots: timeSlots)
        timeCollectionView.register(TimeCollectionViewCell.cellNib,
                                    forCellWithReuseIdentifier: TimeCollectionViewCell.reuseIdentifier)
        timeCollectionView.dataSource = dataSource
        timeCollectionView.delegate = self
        updateTimeSlotsHeight()
    }
    
    private func isAvailable(date: Date) -> Bool {
        if date < Date().removeTimeStamp {
            return false
        } else {
            if (trainingDates.first(where: { $0.removeTimeStamp == date.removeTimeStamp }) != nil) {
                return true
            }
            return false
        }
    }
    
    private func fetchDates() {
        guard let activity = selectedActivity, let coach = selectedCoach else { return }
        startLoading()
        PMFightApi.shared.dates(for: activity.id, with: coach.id) { [weak self] result in
            self?.endLoading()
            switch result {
            case .failure(let error):
                self?.show(error: error)
            case .success(let days):
                self?.trainingDates = days.compactMap({ $0.date })
                self?.calendar.reloadData()
                self?.calendar.alpha = 1
                self?.calendar.isUserInteractionEnabled = true
            }
        }
    }
    
    private func fetchTimeSlots() {
        guard let date = selectedDate, let activity = selectedActivity, let coach = selectedCoach else { return }
        startLoading()
        PMFightApi.shared.time(for: activity.id, with: coach.id, on: date.dayString) { [weak self] (result) in
            self?.endLoading()
            switch result {
            case .success(let time):
                self?.timeSlots = time
                self?.dataSource?.set(items: time)
                self?.timeCollectionView.reloadData()
                self?.updateTimeSlotsHeight()
            case .failure(let error):
                self?.show(error: error)
            }
        }
    }
    
    private func createBooking(_ activity: TrainingType, _ coach: Coach, _ date: Date, _ timeSlot: TrainingTime) {
        // TODO:
        
        onRequestActivity?()
    }
    
    private func updateTimeSlotsHeight() {
        UIView.animate(withDuration: 0.3) {
            let numberOfRows = ceil(CGFloat(self.timeSlots.count) / .numberOfColumns)
            self.timeHeightConstraint.constant = (numberOfRows - 1) * .lineSpacing + numberOfRows * .cellHeight
            self.view.layoutIfNeeded()
        }
    }
}

extension BookingActivityViewController: BookingDelegate {
    func didSelect(_ coach: Coach) {
        selectedCoach = coach
        coachNameLabel.text = coach.fullName
        fetchDates()
    }
    
    func didSelect(_ activity: TrainingType) {
        selectedActivity = activity
        activityLabel.text = activity.name
        chooseCoachButton.isEnabled = true
        chooseCoachButton.superview?.alpha = 1
    }
}

extension BookingActivityViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if isAvailable(date: date) {
            return .white
        }
        return Asset.Colors.typingTextColor.color
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return isAvailable(date: date)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        timeCollectionView.alpha = 1
        timeCollectionView.isUserInteractionEnabled = true
        fetchTimeSlots()
    }
}

extension BookingActivityViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard timeSlots.indices.contains(indexPath.item) else { return }
        selectedTimeSlot = timeSlots[indexPath.item]
    }
}

// MARK: - Constants

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
