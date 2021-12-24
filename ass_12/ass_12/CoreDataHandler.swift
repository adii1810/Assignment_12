//
//  CoreDataHandler.swift
//  StudentAdmissionCoreDataApp
//
//  Created by DCS on 23/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler{
    static let shared = CoreDataHandler()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedObjectContext: NSManagedObjectContext?
    
    private init(){
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    func save(){
        appDelegate.saveContext()
    }
    
    func insert(id:Int, name:String, password:String, sclass:String, phone:String, completion: @escaping () -> Void){
        let stud = Student(context: managedObjectContext!)
        
        stud.spid = Int32(id)
        stud.name = name
        stud.password = password
        stud.sclass = sclass
        stud.phone = phone
        
        save()
        completion()
    }
    
    func update(stud:Student, name:String, password:String, sclass:String, phone:String, completion: @escaping () -> Void){

        stud.name = name
        stud.password = password
        stud.sclass = sclass
        stud.phone = phone
        
        save()
        completion()
    }
    
    func delete(stud:Student, completion: @escaping () -> Void){
        managedObjectContext!.delete(stud)
        
        save()
        completion()
    }
    
    func fetch() -> [Student]{
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        
        do{
            let studArray = try managedObjectContext?.fetch(fetchRequest)
            return studArray!
        }catch{
            print(error)
            return [Student]()
        }
    }
    
    func fetch(id:Int) -> [Student]{
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "spid contains %i", id)
        do{
            let studArray = try managedObjectContext?.fetch(fetchRequest)
            return studArray!
        }catch{
            print(error)
            return [Student]()
        }
    }
    
    func fetchClass(sclass:String) -> [Student]{
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "sclass like %@", sclass)
        
        do{
            let studArray = try managedObjectContext?.fetch(fetchRequest)
            return studArray!
        }catch{
            print(error)
            return [Student]()
        }
    }
    
    func insertNotice(title:String,discription:String,date:String, completion: @escaping () -> Void){
        let note   = Notice(context: managedObjectContext!)
        note.title = title
        note.discription = discription
        note.date = Double(date)!
        
        save()
        completion()
    }
    
    func updateNotice(note:Notice, title:String, discription:String, date:String, completion: @escaping () -> Void){
        
        note.title = title
        note.discription = discription
        note.date = Double(date)!
        
        save()
        completion()
    }
    func deleteNotice(note:Notice, completion: @escaping () -> Void){
        managedObjectContext!.delete(note)
        
        save()
        completion()
    }
    func fetchNotice() -> [Notice]{
        let fetchRequest:NSFetchRequest<Notice> = Notice.fetchRequest()
        
        do{
            let noteArray = try managedObjectContext?.fetch(fetchRequest)
            return noteArray!
        }catch{
            print(error)
            return [Notice]()
        }
    }
    func checkValidUser(id:Int, password:String)->Bool{
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "spid contains %i and password like %@",id, password)
        fetchRequest.resultType = .countResultType
        do{
            let cnt:NSInteger = try (managedObjectContext?.count(for: fetchRequest))!
            
            if cnt == 0{
                return false
            }
            else{
                return true
            }
        }catch{
            print(error)
            return false
        }
    }
    
    func profileDetails(id:Int)->[Student]{
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "spid contains %i", id)
        
        do{
            let noteArray = try managedObjectContext?.fetch(fetchRequest)
            return noteArray!
        }catch{
            print(error)
            return [Student]()
        }
        
    }
    
    func changePassword(stud:Student, password:String, completion: @escaping () -> Void){
        
        stud.password = password
        save()
        completion()
    }
    
}
