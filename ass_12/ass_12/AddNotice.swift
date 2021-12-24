//
//  AddNotice.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AddNotice: UIViewController {

    var notice:Notice?
    
    private let txttitle: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let txtdis: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Discription"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let txtdate: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Date"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        return button
    }()
    func assignbackground(){
        let background = UIImage(named: "studbg")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Notice"
        assignbackground()
        view.addSubview(txttitle)
        view.addSubview(txtdis)
        view.addSubview(txtdate)
        view.addSubview(saveButton)
        view.backgroundColor = UIColor.clear
        
        if let note = notice{
            txttitle.text = note.title
            txtdis.text = note.discription
            txtdate.text = String(note.date)
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        txttitle.frame = CGRect(x: 40, y: 200, width: view.frame.size.width - 80, height: 40)
        txtdis.frame = CGRect(x: 40, y: txttitle.bottom+30, width: view.frame.size.width - 80, height: 40)
        txtdate.frame = CGRect(x: 40, y: txtdis.bottom+30, width: view.frame.size.width - 80, height: 40)
        saveButton.frame = CGRect(x: 40, y: txtdate.bottom+30, width: view.frame.size.width - 80, height: 40)
    }
    @objc private func saveNote(){
        let title = txttitle.text!
        let dis = txtdis.text!
        let date = txtdate.text!
        if let note = notice{
            CoreDataHandler.shared.updateNotice(note: note, title: title, discription: dis, date: date){
                print("Updated")
                self.resetFields()
            }
        }else{
            CoreDataHandler.shared.insertNotice(title: title, discription: dis, date: date){
                print("Data Inserted")
                self.resetFields()
            }
        }
    }
    
    private func resetFields(){
        notice = nil
        txttitle.text=""
        txtdis.text=""
        txtdate.text=""
    }
}
