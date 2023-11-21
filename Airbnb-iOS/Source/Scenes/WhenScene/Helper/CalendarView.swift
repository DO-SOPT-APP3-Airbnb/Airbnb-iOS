//
//  CalendarView.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/21.
//

import UIKit

class CalendarView: UIView {
    // MARK: - Variables
    // MARK: Constants
    let weekDayText = ["일", "월", "화", "수", "목", "금", "토"]
    let calendarDateFormatter = CalendarDateFormatter()
    
    // MARK: Component
    let weekdayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    let monthlyCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.estimatedItemSize = CGSize(width: 24, height: 24)
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(MonthlyCollectionViewCell.self, forCellWithReuseIdentifier: MonthlyCollectionViewCell.reusableId)
        return collectionView
    }()
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateCalendarData()
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Helpers
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        configureWeekDay()
        monthlyCollectionView.dataSource = self
    }
    
    private func setLayout() {
        self.addSubviews(weekdayStackView, monthlyCollectionView)
        
        weekdayStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        monthlyCollectionView.snp.makeConstraints {
            $0.height.equalTo(200.adjusted)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: Custom Function
    private func configureWeekDay() {
        weekDayText.forEach {
            let label = UILabel()
            label.text = $0
            label.textColor = .grayGrayText
            label.font = .iosBodyMedium14
            label.textAlignment = .center
            weekdayStackView.addArrangedSubview(label)
        }
    }
    
    func updateCalendarData() {
        self.calendarDateFormatter.updateCurrentMonthDays()
    }
    
}

//MARK: - Extension
//MARK: CollectionViewDataSource
extension CalendarView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.calendarDateFormatter.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthlyCollectionViewCell.reusableId, for: indexPath) as! MonthlyCollectionViewCell
        cell.monthlydayLabel.text = calendarDateFormatter.days[indexPath.item]
        
        /// 주말 라벨 스타일 적용
        if indexPath.item % 7 == 0 {
            cell.monthlydayLabel.textColor = .main1
        } else if indexPath.item % 7 == 6 {
            cell.monthlydayLabel.textColor = .grayGrayText
        }
        
        /// 오늘 이전의 날짜 취소선
        if indexPath.item < calendarDateFormatter.getUnableDate() {
            cell.monthlydayLabel.textColor = .grayGrayText
            cell.monthlydayLabel.attributedText = cell.monthlydayLabel.text?.strikeThrough()
        }
        
        return cell
        
    }
    
    
}
