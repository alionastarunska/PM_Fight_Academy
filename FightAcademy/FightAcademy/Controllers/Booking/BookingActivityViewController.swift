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
    
    private var trainingDates: [Date] = []
    private var timeSlots: [TimeSlot] = []
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
        
        // todo: create booking
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
        guard let activity = selectedActivity, let coach = selectedCoach else {
            error()
            return
        }
        PMFightApi.shared.dates(for: activity.id, with: coach.id) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let days):
                self?.trainingDates = days.compactMap({ $0.date })
                self?.calendar.reloadData()
                self?.calendar.alpha = 1
                self?.calendar.isUserInteractionEnabled = true
            }
        }
    }
}

extension BookingActivityViewController: BookingDelegate {
    func didSelect(_ coach: Coach) {
        selectedCoach = coach
        coachNameLabel.text = coach.fullName
        fetchDates()
    }
    
    func didSelect(_ activity: ChoosingActivityModel) {
        selectedActivity = activity
        activityLabel.text = activity.name
        chooseCoachButton.isEnabled = true
        chooseCoachButton.superview?.alpha = 1
    }
}

extension BookingActivityViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func minimumDate(for calendar: FSCalendar) -> Date {
        let today = Date()
        print("\(today)")
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if isAvailable(date: date) {
            return .white
        }
        return .typingTextColor
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return isAvailable(date: date)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        let formatter = dateFormatter.string(from: date)
        print("\(formatter)")
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

private var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    return formatter
}()

private extension Date {
    var removeTimeStamp: Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else { return self }
        return date
    }
}

private extension UIColor {
    static var typingTextColor: UIColor { return UIColor(named: "typingTextColor") ?? .lightGray }
}
