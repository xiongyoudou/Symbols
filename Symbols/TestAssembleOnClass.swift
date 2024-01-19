//
//  TestAssembleOnClass.swift
//  Symbols
//
//  Created by xiong有都 on 2024/1/20.
//

import Foundation

/// private model
private class Student{
    var id: Int = 0
    var name: String = ""
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

func testAssembelOnClass() {
    let student = getStudentData()
    printStudent(student: student)
}

/// private functions
private func getStudentData() -> Student {
    return Student(id: 101, name: "lily")
}

private func printStudent(student: Student) {
    _ = student.name
    print(student.id)
    print(student.name)
}

