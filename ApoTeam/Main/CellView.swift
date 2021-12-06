//
//  CellView.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 03.12.2021.
//

import UIKit
import SnapKit

class CellView: UITableViewCell {
    
    let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        setTitle()
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        contentView.layer.cornerRadius = 14
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.2
    }
    
    func makeImage(_ images: [Data]) {
        var leftOtstup = 15
        for avatar in images {
            let imgView = UIImageView()
            imgView.image = UIImage(data: avatar)
            imgView.backgroundColor = .lightGray
            imgView.layer.cornerRadius = 25
            imgView.clipsToBounds = true
            if avatar == images[0] {
                imgView.layer.borderWidth = 3
                imgView.layer.borderColor = UIColor.yellow.cgColor
            }
            self.contentView.addSubview(imgView)
            imgView.snp.makeConstraints { make in
                make.centerY.equalToSuperview().multipliedBy(1.5)
                make.width.equalTo(50)
                make.height.equalTo(50)
                make.left.equalTo(leftOtstup)
            }
            leftOtstup += 65
        }
    }
    
}

extension CellView {
    
    private func setView() {
        
        self.contentView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.95)
            make.height.equalTo(150)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setTitle() {
        self.title.numberOfLines = 2
        self.title.font = UIFont(name: "AmericanTypewriter-Bold", size: 20)
        self.title.textColor = .label
        self.contentView.addSubview(self.title)
        
        self.title.snp.makeConstraints { make in
            make.centerY.equalToSuperview().dividedBy(2)
            make.leading.equalTo(15)
            make.width.equalToSuperview().multipliedBy(0.95)
        }
    }
}
