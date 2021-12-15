//
//  CustomTextField.swift
//  ApoTeam
//
//  Created by Дмитрий Константинов on 04.12.2021.
//

import UIKit
import SnapKit

class MemberRedactView: UIViewController {
    
    let avatar = UIImageView()
    let labelTitle = UILabel()
    let nameTF = UITextField()
    let statusTF = UITextView()
    let randomBtn = UIButton()
    let backgroundView = UIView()
    weak var delegate: GroupViewDelegate?
    var presenter: MemberRedactPresenter? = nil
    
    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        addSubviews()
        
        createLabelTitle()
        
        createAvatar()
        
        createNameTF()
        
        createStatusTF()
        
        createRandomBtnAndInventoryBtn()

    }
    
    //Сохранение происходит при закрытии окна
    override func viewDidDisappear(_ animated: Bool) {
        if presenter != nil {
            for i in 1..<8 {
                guard let btn = self.view.viewWithTag(i) as? UIButton else { return }
                self.presenter!.inventory.append(btn.titleLabel?.text ?? "")
            }
            presenter?.editMember(name: nameTF.text ?? "",
                                  status: statusTF.text ?? "",
                                  avatar: avatar.image?.pngData() ?? Data())
            delegate?.update(presenter!.member)
        }
        
    }
    
    @objc
    func tapButtonInventory(_ sender: UIButton) {
        showAlert(tagBtn: sender.tag)
    }
    
    @objc
    func tapButtonRandom() {
        
        UIView.animate(withDuration: 0.2,
                       animations: {
            self.randomBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.6) {
                self.randomBtn.transform = CGAffineTransform.identity
            }
        })
        
        DispatchQueue.global(qos: .background).async {
            
            self.presenter?.getRandomInventory(complit: { inventory in
                DispatchQueue.main.async {
                    for i in 1..<8 {
                        guard let btn = self.view.viewWithTag(i) as? UIButton else { return }
                        btn.setTitle("", for: .normal)
                    }
                    var i = 1
                    for object in inventory {
                        guard let btn = self.view.viewWithTag(i) as? UIButton else { return }
                        btn.setTitle(object, for: .normal)
                        i += 1
                    }
                }
            })
            
            self.presenter?.getRandomName(complit: { name in
                DispatchQueue.global(qos: .background).async {
                    self.presenter?.getRandomAvatar(complit: { dataImg in
                        DispatchQueue.main.async {
                            self.avatar.image = UIImage(data: dataImg)
                        }
                    })
                }
                DispatchQueue.main.async {
                    self.nameTF.text = name
                }
            })
            
            self.presenter?.getRandomStatus(complit: { status in
                DispatchQueue.main.async {
                    self.statusTF.text = status
                    self.statusTF.textColor = .black
                }
            })
        }

    }
    
    private func showAlert(tagBtn: Int) {
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        backgroundView.frame = self.view.bounds
        let emojiView = EmojiView(viewController: self, tagBtn: tagBtn, emojiArray: presenter?.getArrayInventory() ?? [""])
        emojiView.layer.masksToBounds = true
        emojiView.layer.cornerRadius = 12
        emojiView.frame = CGRect(x: 40,
                                 y: 1200,
                                 width: self.view.frame.size.width-80,
                                 height: 200)
        self.view.addSubview(backgroundView)
        self.view.addSubview(emojiView)
        UIView.animate(withDuration: 0.25) {
            self.backgroundView.alpha = 0.6
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    emojiView.center = self.view.center
                }
            }
        }

    }
}

//MARK: - Делегаты

extension MemberRedactView: UITextFieldDelegate, UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write status"
            textView.textColor = .lightGray
        }
    }
}

//MARK: - Функции для создания элементов

extension MemberRedactView {
    
    private func addSubviews() {
        self.view.addSubview(labelTitle)
        self.view.addSubview(avatar)
        self.view.addSubview(nameTF)
        self.view.addSubview(statusTF)
        self.view.addSubview(randomBtn)
    }
    
    fileprivate func createLabelTitle() {
        labelTitle.text = "Edit Member"
        labelTitle.font = UIFont(name: "AmericanTypewriter-Bold", size: 30)
        labelTitle.textColor = .label
        labelTitle.textAlignment = .center
        labelTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.95)
        }
    }
    
    fileprivate func createAvatar() {
        avatar.backgroundColor = .lightGray
        avatar.image = UIImage(data: presenter!.member.avatar)
        avatar.layer.cornerRadius = 50
        avatar.clipsToBounds = true
        avatar.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.top.equalTo(labelTitle.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
        }
    }
    
    fileprivate func createNameTF() {
        nameTF.placeholder = "Write name"
        nameTF.delegate = self
        nameTF.text = presenter?.member.name
        nameTF.textAlignment = .left
        nameTF.snp.makeConstraints { make in
            make.top.equalTo(labelTitle.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(10)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.height.equalTo(45)
        }
    }
    
    fileprivate func createStatusTF() {
        if presenter?.member.status == "" {
            statusTF.text = "Write status"
            statusTF.textColor = .lightGray
        } else {
            statusTF.text = presenter?.member.status
            statusTF.textColor = .black
        }
        statusTF.delegate = self
        statusTF.textAlignment = .left
        statusTF.snp.makeConstraints { make in
            make.top.equalTo(nameTF.snp.bottom).offset(10)
            make.left.equalTo(avatar.snp.right).offset(10)
            make.right.equalToSuperview().offset(10)
            make.height.equalTo(45)
        }
    }
    
    fileprivate func createRandomBtnAndInventoryBtn() {
        randomBtn.setTitle("Random Member", for: .normal)
        randomBtn.setTitleColor(.blue, for: .normal)
        randomBtn.addTarget(self, action: #selector(tapButtonRandom), for: .touchUpInside)
        randomBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(statusTF.snp.bottom).offset(100)
            make.width.equalToSuperview().multipliedBy(0.95)
            make.height.equalTo(50)
        }
        
        let wh = (UIScreen.main.bounds.width - 80) / 7
        var leftOffset = 10
        for i in 1..<8 {
            let btn = UIButton()
            btn.setTitle(presenter?.member.invent[i-1], for: .normal)
            btn.backgroundColor = .white
            self.view.addSubview(btn)
            btn.tag = i
            
            btn.snp.makeConstraints { make in
                make.width.equalTo(wh)
                make.height.equalTo(wh)
                make.top.equalTo(self.statusTF.snp.bottom).offset(20)
                make.left.equalToSuperview().offset(leftOffset)
            }
            btn.layer.shadowColor = UIColor.gray.cgColor
            btn.layer.shadowRadius = 3
            btn.layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
            btn.layer.shadowOpacity = 0.5
            btn.addTarget(self, action: #selector(tapButtonInventory(_:)), for: .touchUpInside)
            leftOffset += Int(wh) + 10
        }
    }
}
