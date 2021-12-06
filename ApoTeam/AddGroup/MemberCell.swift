//
//  AddGroupCell.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 05.12.2021.
//

import UIKit
import SnapKit

class MemberCell: UITableViewCell {
    
    let avatar = UIImageView()
    let name = UILabel()
    let status = UILabel()
//    var invent: [String] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatar)
        avatar.backgroundColor = .lightGray
        avatar.layer.cornerRadius = 50
        avatar.clipsToBounds = true
        avatar.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.left.top.equalToSuperview().offset(10)
        }
        name.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
        name.textColor = .label
        contentView.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        status.font = UIFont(name: "AmericanTypewriter-Bold", size: 15)
        status.textColor = .tertiaryLabel
        contentView.addSubview(status)
        status.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func makeInvent(_ invent: [String]) {
        var leftOffset = 10
        var wh = (Int(UIScreen.main.bounds.width) - 110 - 10 * invent.count) / invent.count
        if wh > 40 { wh = 40 }
        for emoji in invent {
            let image = emoji.image()
            let imgView = UIImageView()
            print(wh)
            
            contentView.addSubview(imgView)
            imgView.image = image
            imgView.backgroundColor = .lightGray
            imgView.layer.cornerRadius = 5
            
            imgView.layer.shadowColor = UIColor.gray.cgColor
            imgView.layer.shadowRadius = 3
            imgView.layer.shadowOffset = .zero
            imgView.layer.shadowOpacity = 0.2
            
            imgView.snp.makeConstraints { make in
                make.width.equalTo(wh)
                make.height.equalTo(wh)
                make.bottom.equalTo(avatar)
                make.left.equalTo(avatar.snp.right).offset(leftOffset)
            }
            leftOffset += wh + 10
        }
    }

}
