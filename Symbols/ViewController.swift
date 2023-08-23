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
        let dynamicProvider = DataProviderFromDynamic(age: 12, name: "lily")
        let info = dynamicProvider.provideData()
        return info
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

