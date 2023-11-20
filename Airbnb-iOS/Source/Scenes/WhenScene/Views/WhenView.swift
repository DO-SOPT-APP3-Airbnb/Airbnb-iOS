//
//  WhenView.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/20.
//

import UIKit

import SnapKit
import FSCalendar

class WhenView: UIView {
    // MARK: - Variables
    // MARK: Property
    let dateSelectList = ["정확한 날짜", "1일", "2일", "3일", "4일", "5일", "6일", "7일"]
    
    // MARK: Component
    let navigationBar = CustomNavigationView(level: 2, mode: .darkMode)
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgWhen
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "언제 여행을 가실 예정인가요?"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.setLineSpacing(spacing: 30)
        return label
    }()
    
    private let backgroundView: UIView =  {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        view.makeCornerRound(radius: 20)
        return view
    }()
    
    private let selectSegmentControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "날짜지정", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "월 단위", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "유연한 일정", at: 2, animated: true)
        segmentedControl.setWidth(100, forSegmentAt: 0)
        segmentedControl.setWidth(100, forSegmentAt: 1)
        segmentedControl.setWidth(100, forSegmentAt: 2)
        segmentedControl.backgroundColor = .grayGrayLine
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.makeCornerRound(radius: 20)
        return segmentedControl
    }()
    
    let calendarView = FSCalendar()
    
    lazy var dateSelectCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(DateSelectCollectionViewCell.self, forCellWithReuseIdentifier: DateSelectCollectionViewCell.reusableId)
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("건너뛰기", for: .normal)
        button.setTitleColor(.black1, for: .normal)
        button.titleLabel?.font = .iosSubMedium16
        button.setUnderline()
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .iosSubMedium16
        button.backgroundColor = .black
        button.makeCornerRound(radius: 10)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI(){
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        setCalendarUI()
    }
    
    private func setLayout() {
        self.addSubviews(backgroundImageView, navigationBar, titleLabel, backgroundView)
        backgroundView.addSubviews(selectSegmentControl, calendarView, dateSelectCollectionView,skipButton, nextButton)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(128)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(35)
            $0.leading.equalToSuperview().offset(20)
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(31)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.bottom.equalToSuperview().inset(55)
        }
        
        
        selectSegmentControl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(selectSegmentControl.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(289)
        }
        
        dateSelectCollectionView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(34)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(36)
        }
        
        skipButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().offset(27)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(skipButton.snp.centerY)
            $0.height.equalTo(46)
            $0.width.equalTo(119)
        }
        
    }
    
    func setCalendarUI() {
        // calendar locale > 한국으로 설정
        self.calendarView.locale = Locale(identifier: "ko_KR")
        // 상단 요일을 한글로 변경
        self.calendarView.calendarWeekdayView.weekdayLabels[0].text = "일"
        self.calendarView.calendarWeekdayView.weekdayLabels[1].text = "월"
        self.calendarView.calendarWeekdayView.weekdayLabels[2].text = "화"
        self.calendarView.calendarWeekdayView.weekdayLabels[3].text = "수"
        self.calendarView.calendarWeekdayView.weekdayLabels[4].text = "목"
        self.calendarView.calendarWeekdayView.weekdayLabels[5].text = "금"
        self.calendarView.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        // 월~일 글자 폰트 및 사이즈 지정
        self.calendarView.appearance.weekdayFont = .iosBodyMedium14
        // 숫자들 글자 폰트 및 사이즈 지정
        self.calendarView.appearance.titleFont = .iosBodyBold14
        
        // 캘린더 스크롤 가능하게 지정
        self.calendarView.scrollEnabled = true
        // 캘린더 스크롤 방향 지정
        self.calendarView.scrollDirection = .horizontal
        
        // 요일 글자 색
        self.calendarView.appearance.weekdayTextColor = UIColor(named: "F5F5F5")?.withAlphaComponent(0.2)
        
        // 캘린더 높이 지정
        self.calendarView.headerHeight = 0
        
        // 캘린더의 cornerRadius 지정
        self.calendarView.layer.cornerRadius = 10
        
        // 양옆 년도, 월 지우기
        self.calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        
        // 달에 유효하지 않은 날짜의 색 지정
        self.calendarView.appearance.titlePlaceholderColor = UIColor.white.withAlphaComponent(0.2)
        // 평일 날짜 색
        self.calendarView.appearance.titleDefaultColor = .black1
        self.calendarView.appearance.titleWeekendColor = .main1
        self.calendarView.appearance.subtitleWeekendColor = .grayGrayText
        // 달에 유효하지않은 날짜 지우기
        self.calendarView.placeholderType = .none
        //
        //        // 캘린더 숫자와 subtitle간의 간격 조정
        //        self.calendarView.appearance.subtitleOffset = CGPoint(x: 0, y: 4)
    }
}

extension WhenView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateSelectList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateSelectCollectionViewCell.reusableId, for: indexPath) as! DateSelectCollectionViewCell
        if indexPath.row == 0 {
            cell.isFirstCell = true
        }
        cell.titleLabel.text = dateSelectList[indexPath.row]
        return cell
    }
}

