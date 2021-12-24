//
//  AddStudent.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 18/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AddStudent: UIViewController {

    var student:Student?
    
    private let txtspid: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Student ID"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let txtName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Student Name"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let txtPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let txtclass: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Class"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let txtphone: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone"
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
        assignbackground()
        view.addSubview(txtspid)
        view.addSubview(txtName)
        view.addSubview(txtPassword)
        view.addSubview(txtclass)
        view.addSubview(txtphone)
        view.addSubview(saveButton)
        title = "Add Student"
        if let stud = student{
            txtspid.text=String(stud.spid)
            txtName.text=stud.name
            txtPassword.text=stud.password
            txtclass.text=stud.sclass
            txtphone.text=stud.phone
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        txtspid.frame = CGRect(x: 40, y: 170, width: view.frame.size.width - 80, height: 40)
        txtName.frame = CGRect(x: 40, y: txtspid.bottom+30, width: view.frame.size.width - 80, height: 40)
        txtPassword.frame = CGRect(x: 40, y: txtName.bottom+30, width: view.frame.size.width - 80, height: 40)
        txtclass.frame = CGRect(x: 40, y: txtPassword.bottom+30, width: view.frame.size.width - 80, height: 40)
        txtphone.frame = CGRect(x: 40, y: txtclass.bottom+30, width: view.frame.size.width - 80, height: 40)
        saveButton.frame = CGRect(x: 40, y: txtphone.bottom+30, width: view.frame.size.width - 80, height: 40)
    }
   
    @objc private func saveNote(){
        let spid = Int(txtspid.text!)
        let name = txtName.text!
        let password = txtPassword.text!
        let sclass = txtclass.text!
        let phone = txtphone.text!
        
        if let stud = student{
            CoreDataHandler.shared.update(stud: stud, name: name, password: password, sclass: sclass, phone: phone){
                print("Updated")
                self.resetFields()
            }
        }else{
            CoreDataHandler.shared.insert(id: spid!, name: name, password: password, sclass: sclass, phone: phone){
                print("Data Inserted")
                self.resetFields()
            }
        }
    }
    
    private func resetFields(){
        student = nil
        txtspid.text=""
        txtName.text=""
        txtPassword.text=""
        txtclass.text=""
        txtphone.text=""
    }
    
}
