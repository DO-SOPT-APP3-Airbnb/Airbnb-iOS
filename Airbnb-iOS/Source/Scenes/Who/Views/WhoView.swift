//
//  WhoView.swift
//  Airbnb-iOS
//
//  Created by 지희의 MAC on 2023/11/22.
//

import UIKit

class WhoView: UIView {
    // MARK: - Variables
    
    // MARK: Constants
    let titleText: [String] = ["성인","어린이", "유아", "반려동물"]
    let subTitleText: [String] = ["13세 이상", "2~12세", "2세 미만", "반려동물을 동반하시나요?"]
    
    // MARK: Property
    
    
    // MARK: Component
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.imgWho
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let navigationView = CustomNavigationView(level: 4, mode: .darkMode)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "누구와 함께 여행가시나요?"
        label.font = .iosTitleBold25
        label.textColor = .black1
        return label
    }()
    
    private lazy var accompanyTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 85
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.register(AccompanyTableViewCell.self, forCellReuseIdentifier: AccompanyTableViewCell.reusableId)
        tableView.makeCornerRound(radius: 20)
        tableView.contentInset = UIEdgeInsets(top: 33, left: 0, bottom: 33, right: 0)
        tableView.backgroundColor = .whiteWhite40
        tableView.dataSource = self
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI(){
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        self.addSubviews(backgroundImageView,
                         navigationView,
                         titleLabel,
                         accompanyTableView)
    }
    
    private func setConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(20)
        }
        
        accompanyTableView.snp.makeConstraints {
            $0.height.equalTo(400)
            $0.bottom.equalToSuperview().inset(56)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

extension WhoView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titleText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = accompanyTableView.dequeueReusableCell(withIdentifier: AccompanyTableViewCell.reusableId) as! AccompanyTableViewCell
        cell.selectionStyle = .none
        cell.configureCell(title: titleText[indexPath.row],
                           subTitle: subTitleText[indexPath.row])
        return cell
    }
    
    
}
