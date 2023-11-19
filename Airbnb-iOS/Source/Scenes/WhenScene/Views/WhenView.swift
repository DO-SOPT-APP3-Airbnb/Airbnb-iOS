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
    
    // MARK: Component
    let navigationBar = UIView()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgWhen
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "언제 여행을 가실 예정인가요?"
        label.font = .iosTitleBold25
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
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.insertSegment(withTitle: "날짜지정", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "월 단위", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "유연한 일정", at: 2, animated: true)
        return segmentedControl
    }()
    
    private let calendar = FSCalendar()
    
    private let skipButton: UIButton = {
       let button = UIButton()
        button.setTitle("건너뛰기", for: .normal)
        button.setTitleColor(.grayGrayText, for: .normal)
        button.titleLabel?.font = .iosSubMedium16
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
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
        backgroundView.addSubviews(selectSegmentControl, calendar, skipButton, nextButton)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(128)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(26)
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
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(selectSegmentControl.snp.bottom).offset(27)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(289)
        }
        
        skipButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(23)
            $0.leading.equalToSuperview().offset(18)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(skipButton.snp.centerY)
            $0.height.equalTo(46)
            $0.width.equalTo(119)
        }
        
    }
    
    func setCalendarUI() {
        // delegate, dataSource
       // self.calendar.delegate = self
       // self.calendar.dataSource = self
        
        // calendar locale > 한국으로 설정
        self.calendar.locale = Locale(identifier: "ko_KR")
        
        // 상단 요일을 한글로 변경
        self.calendar.calendarWeekdayView.weekdayLabels[0].text = "일"
        self.calendar.calendarWeekdayView.weekdayLabels[1].text = "월"
        self.calendar.calendarWeekdayView.weekdayLabels[2].text = "화"
        self.calendar.calendarWeekdayView.weekdayLabels[3].text = "수"
        self.calendar.calendarWeekdayView.weekdayLabels[4].text = "목"
        self.calendar.calendarWeekdayView.weekdayLabels[5].text = "금"
        self.calendar.calendarWeekdayView.weekdayLabels[6].text = "토"
        
        // 월~일 글자 폰트 및 사이즈 지정
        self.calendar.appearance.weekdayFont = .iosBodyMedium14
        // 숫자들 글자 폰트 및 사이즈 지정
        self.calendar.appearance.titleFont = .iosBodyBold14
        
        // 캘린더 스크롤 가능하게 지정
        self.calendar.scrollEnabled = true
        // 캘린더 스크롤 방향 지정
        self.calendar.scrollDirection = .horizontal
        
        // Header dateFormat, 년도, 월 폰트(사이즈)와 색, 가운데 정렬
//        self.calendar.appearance.headerDateFormat = "YYYY년 MM월"
//        self.calendar.appearance.headerTitleFont = UIFont.SpoqaHanSans(type: .Bold, size: 20)
//        self.calendar.appearance.headerTitleColor = UIColor(named: "FFFFFF")?.withAlphaComponent(0.9)
//        self.calendar.appearance.headerTitleAlignment = .center
        
        // 요일 글자 색
        self.calendar.appearance.weekdayTextColor = UIColor(named: "F5F5F5")?.withAlphaComponent(0.2)
        
        // 캘린더 높이 지정
        self.calendar.headerHeight = 68
        // 캘린더의 cornerRadius 지정
        self.calendar.layer.cornerRadius = 10
        
        // 양옆 년도, 월 지우기
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        // 달에 유효하지 않은 날짜의 색 지정
        self.calendar.appearance.titlePlaceholderColor = UIColor.white.withAlphaComponent(0.2)
        // 평일 날짜 색
        self.calendar.appearance.titleDefaultColor = .black1
        self.calendar.appearance.titleWeekendColor = .main1
        self.calendar.appearance.subtitleWeekendColor = .grayGrayText
        // 달에 유효하지않은 날짜 지우기
        self.calendar.placeholderType = .none
        
        // 캘린더 숫자와 subtitle간의 간격 조정
        self.calendar.appearance.subtitleOffset = CGPoint(x: 0, y: 4)
    }
}
