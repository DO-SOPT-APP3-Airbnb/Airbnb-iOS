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
    let buttonText = ["날짜 지정", "월 단위", "유연한 일정"]
    
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
        label.font = .systemFont(ofSize: 25.adjusted, weight: .bold)
        label.setLineSpacing(spacing: 30.adjusted)
        return label
    }()
    
    private let backgroundView: UIView =  {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        view.makeCornerRound(radius: 20.adjusted)
        return view
    }()
    
    private lazy var optionSelectButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .grayGrayLine
        stackView.makeCornerRound(radius: 20.adjusted)
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let calendarView = CalendarView()
    
    lazy var dateSelectCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 16.adjusted
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
    
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        configureSegmentButton()
    }
    
    private func setLayout() {
        self.addSubviews(backgroundImageView,
                         navigationBar,
                         titleLabel,
                         backgroundView)
        backgroundView.addSubviews(optionSelectButtonStackView,
                                   calendarView,
                                   dateSelectCollectionView,
                                   skipButton,
                                   nextButton)
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(128.adjusted)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(35.adjusted)
            $0.leading.equalToSuperview().offset(20.adjusted)
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(31.adjusted)
            $0.leading.trailing.equalToSuperview().inset(18.adjusted)
            if UIScreen.main.isLongerThan812pt {
                $0.bottom.equalToSuperview().inset(55.adjusted)
            } else {
                $0.bottom.equalToSuperview().inset(18.adjusted)
            }
        }
        
        optionSelectButtonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(21.adjusted)
            $0.top.equalToSuperview().offset(24.adjusted)
            $0.height.equalTo(40.adjusted)
        }
        
        calendarView.snp.makeConstraints {
            if UIScreen.main.isLongerThan812pt {
                $0.top.equalTo(optionSelectButtonStackView.snp.bottom).offset(27.adjusted)
            } else {
                $0.top.equalTo(optionSelectButtonStackView.snp.bottom).offset(12.adjusted)
            }
            $0.leading.trailing.equalToSuperview().inset(32.adjusted)
        }
        
        dateSelectCollectionView.snp.makeConstraints {
            if UIScreen.main.isLongerThan812pt {
                $0.top.equalTo(calendarView.snp.bottom).offset(34.adjusted)
            } else {
                $0.top.equalTo(calendarView.snp.bottom).offset(12.adjusted)
            }
            $0.leading.equalToSuperview().offset(8.adjusted)
            $0.trailing.equalToSuperview()
            if UIScreen.main.isLongerThan812pt {
                $0.bottom.equalTo(nextButton.snp.top).offset(-39.adjusted)
            } else {
                $0.bottom.equalTo(nextButton.snp.top).offset(-15.adjusted)
            }
            $0.height.equalTo(36.adjusted)
        }
        
        skipButton.snp.makeConstraints {
            if UIScreen.main.isLongerThan812pt {
                $0.bottom.equalToSuperview().inset(30.adjusted)
            } else {
                $0.bottom.equalToSuperview().inset(24.adjusted)
            }
            $0.leading.equalToSuperview().offset(27.adjusted)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.adjusted)
            $0.centerY.equalTo(skipButton.snp.centerY)
            $0.height.equalTo(46.adjusted)
            $0.width.equalTo(119.adjusted)
        }
        
    }
    
    // MARK: Custom Function
    private func configureSegmentButton() {
        for i in 0 ..< buttonText.count {
            let button = SegmentButton(buttonTitle: buttonText[i])
            if i == 0 {
                button.isSelect = true
            }
            optionSelectButtonStackView.addArrangedSubview(button)
        }
    }
    // MARK: Objc Function
}

// MARK: - Extension
// MARK: CollectionViewDataSource
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

