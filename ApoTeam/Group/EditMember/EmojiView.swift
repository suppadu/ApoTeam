//
//  EmojiView.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 11.12.2021.
//

import Foundation
import SnapKit

class EmojiView: UIView {
    
    let labelTitle = UILabel()
    let viewController: MemberRedactView
    let tagBtn: Int
    let emojiArray: [String]
    
    init(viewController: MemberRedactView, tagBtn: Int, emojiArray: [String]) {
        self.tagBtn = tagBtn
        self.viewController = viewController
        self.emojiArray = emojiArray
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.addSubview(labelTitle)
        labelTitle.text = "Take emoji"
        labelTitle.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
        labelTitle.textColor = .label
        labelTitle.textAlignment = .center
        labelTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.95)
        }
        
        let wh = (UIScreen.main.bounds.width - 160) / 7
        var leftOffset = 10
        var i = 0
        for emoji in emojiArray {
            let btn = UIButton()
            btn.setTitle("\(emoji)", for: .normal)
            btn.backgroundColor = .white
            self.addSubview(btn)
            btn.tag = i
            btn.addTarget(self, action: #selector(btnTapped(_:)), for: .touchUpInside)
            
            btn.snp.makeConstraints { make in
                make.width.equalTo(wh)
                make.height.equalTo(wh)
                make.top.equalTo(self.labelTitle.snp.bottom).offset(20)
                make.left.equalToSuperview().offset(leftOffset)
            }
            btn.layer.shadowColor = UIColor.gray.cgColor
            btn.layer.shadowRadius = 3
            btn.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
            btn.layer.shadowOpacity = 0.5
            leftOffset += Int(wh) + 10
            i += 1
        }

    }
    
    @objc
    func btnTapped(_ sender: UIButton) {
        guard let btn = viewController.view.viewWithTag(tagBtn) as? UIButton else { return }
        btn.setTitle(sender.titleLabel?.text, for: .normal)
        UIView.animate(withDuration: 0.25) {
            self.frame = CGRect(x: 40, y: 1200,
                                width: self.frame.size.width,
                                height: self.frame.size.height)
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    self.viewController.backgroundView.alpha = 0
                } completion: { done in
                    if done {
                        self.removeFromSuperview()
                        self.viewController.backgroundView.removeFromSuperview()
                    }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func create(_ view: UIView, offsetView: UIView, offset: Int) {
        view.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(offsetView.snp.bottom).offset(offset)
            make.width.equalToSuperview().multipliedBy(0.95)
        }
    }
}
