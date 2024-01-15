//
//  ViewController.swift
//  Symbols
//
//  Created by xiong有都 on 2023/8/4.
//

import UIKit
import StaticFramework
import DynamicFramework

let maxAge_global = 100
var minAge_global = 0

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        minAge_global = 1
        
        let dynamicInfo = getDataFromDynamic()
        print(dynamicInfo)
        
        let staticInfo = getDataFromStatic()
        print(staticInfo)
        
        let student = getStudentData()
        printStudent(student: student)
        
        let pid = getPid()
        print(pid)
        
        var counter = increamentByOne()
        print(counter)
        counter = increamentByOne()
        print(counter)
        
        print(global_var)
    }

    func getDataFromDynamic() -> String {
        let staticProvider = DataProviderFromStatic(age: 13, name: "lucy")
        let info = staticProvider.provideData()
        return info
    }
    
    func getDataFromStatic() -> String {
        let dynamicProvider = DataProviderFromDynamic(age: 12, name: "lilggggssafdasdfqwery")
        let info = dynamicProvider.provideData()
        return info
    }
    
    struct Student{
        var id: Int
        var name: String
    }
    func getStudentData() -> Student {
        return Student(id: 101, name: "what can i do for you")
    }
    func printStudent(student: Student) {
        print(student.id)
        print(student.name)
    }
    
    func getPid() -> Int32 {
        let pid = getPidInfo()
        return pid
    }
    
    func increamentByOne() -> Int32 {
        let counter = increamentCount()
        return counter
    }

}

