//
//  CustomNavigationView.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/20.
//

import UIKit

// MARK: Enum
enum ViewMode {
    case darkMode
    case lightMode
}

class CustomNavigationView: UIView {
    
    // MARK: - Variables
    // MARK: Constants
    // MARK: Property
    var progressLevel: Float = 0.0
    
    // MARK: Component
    private lazy var xButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiteral.btnX, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let lodgingLabel: UILabel = {
        let label = UILabel()
        label.text = "숙소"
        label.font = .iosSubMedium16
        label.textColor = .white
        label.setLineSpacing(spacing: 19)
        return label
    }()
    
    private let activityLabel: UILabel = {
        let label = UILabel()
        label.text = "체험"
        label.font = .iosSubMedium16
        label.textColor = .grayGrayText
        label.setLineSpacing(spacing: 19)
        return label
    }()
    
    private let selectLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var labelStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangeSubViews(lodgingLabel, activityLabel)
        stackView.spacing = 22
        return stackView
    }()
    
    private lazy var progressBarView: UIProgressView  = {
        let progressView = UIProgressView()
        progressView.makeCornerRound(radius: 4)
        progressView.progressTintColor = .main1
        progressView.backgroundColor = .grayGray1
        progressView.progress = self.progressLevel
        return progressView
    }()
    
    
    // MARK: - Function
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    init(level: Float, mode: ViewMode = .lightMode) {
        super.init(frame: .zero)
        self.progressLevel = level / 3
        if mode == .darkMode { setDarkMode() }
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
    
    private func setStyle() { }
    
    private func setLayout() {
        self.addSubviews(xButton, labelStackView, selectLineView, progressBarView)
        
        self.snp.makeConstraints {
            $0.height.equalTo(128.adjustedHeight)
        }
        
        xButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(57.adjusted)
            $0.leading.equalToSuperview().offset(16.adjusted)
            $0.size.equalTo(42.adjusted)
        }
        
        selectLineView.snp.makeConstraints {
            $0.top.equalTo(lodgingLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(lodgingLabel.snp.centerX)
            $0.height.equalTo(2.adjustedHeight)
            $0.width.equalTo(lodgingLabel.snp.width)
        }
        
        labelStackView.snp.makeConstraints {
            $0.centerY.equalTo(xButton.snp.centerY)
            $0.centerX.equalToSuperview()
        }
        
        progressBarView.snp.makeConstraints {
            $0.height.equalTo(8.adjustedHeight)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(21.adjusted)
        }
        
    }
    // MARK: Custom Function
    /// darkMode가 필요할 때 변경하는 함수입니다. 기본은 라이트모드
    private func setDarkMode() {
        lodgingLabel.textColor = .black
        selectLineView.backgroundColor = .black1
    }
    
    // MARK: Objc Function
    @objc private func xButtonTapped() {
        guard let navigationController = findViewController()?.navigationController else {
            return
        }
        navigationController.popToRootViewController(animated: true)
    }
    
    // MARK: Helper Function
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        return nil
    }
}
