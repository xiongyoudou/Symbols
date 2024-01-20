//
//  TestMemoryFunction.swift
//  Symbols
//
//  Created by xiong有都 on 2024/1/20.
//

import Foundation

func testMemoryFunction() {
    test_getMemory()
    test_unsafeBitCast()

    test_UnsafePointer()
    test_UnsafeBufferPointer()
    
    test_withUnsafeBytes()
    test_withUnsafeBufferPointer()
    test_withMemoryRebound()
}

func test_getMemory() {
    var number = 42
    let pointerToNumber = UnsafeMutablePointer<Int>(&number)
    print(type(of: pointerToNumber))
    
    func modifyValue(_ x: inout Int) {
        print(type(of: x))
        x = 42
    }
    var number2 = 10
    modifyValue(&number2)  // Correct usage of '&'
}

// 注意在转换两种不同的类型时，必须保证两者size相同。当转换Int64和Float时就会报错如下
// Thread 1: Fatal error: Can't unsafeBitCast between types of different sizes
func test_unsafeBitCast() {
    let intValue: Int32 = 42
    let floatValue = unsafeBitCast(intValue, to: Float.self)
    print(floatValue) // 输出可能是一个不正确的浮点数，因为整数和浮点数的内存表示不同

    let newIntValue = unsafeBitCast(floatValue, to: Int32.self)
    print(newIntValue) // 输出可能是一个不正确的整数，同样因为内存表示不同
}

func test_UnsafePointer() {
    // 创建一个包含整数的数组
    let array: [Int] = [1, 2, 3, 4, 5]

    // 使用UnsafePointer获取数组的起始地址
    let pointer = UnsafePointer(array)

    // 通过指针访问数组中的元素
    for i in 0..<array.count {
        let element = pointer.advanced(by: i).pointee
        print("Element at index \(i): \(element)")
    }

    // 也可以直接使用指针的下标操作
    for i in 0..<array.count {
        let element = pointer[i]
        print("Element at index \(i): \(element)")
    }
}

func test_UnsafeBufferPointer() {
    // 创建一个包含整数的原始内存缓冲区
    let array: [Int] = [1, 2, 3, 4, 5]
    let bufferPointer = UnsafeBufferPointer(start: array, count: array.count)

    // 使用 UnsafeBufferPointer 迭代访问缓冲区中的元素
    for element in bufferPointer {
        print(element)
    }

    // 或者通过索引访问缓冲区中的元素
    for i in 0..<bufferPointer.count {
        print(bufferPointer[i])
    }

    // 使用指针进行更底层的操作
    let pointer1 = bufferPointer.baseAddress
    print("First element using pointer:", pointer1?.pointee)
    
    let pointer2 = bufferPointer.baseAddress!.advanced(by: 1)
    print("Second element using pointer:", pointer2.pointee)
}

func test_withUnsafeBytes() {
    struct SampleStruct {
        let number: Int
        let flag: Bool
    }
    
    print("Getting the bytes of an instance")
    var sampleStruct = SampleStruct(number: 25, flag: true)
    withUnsafeBytes(of: &sampleStruct) { bytes in
        for byte in bytes {
            print(byte)
        }
    }
    print("===================================")
}

func test_withUnsafeBufferPointer() {
    let numbers = [1, 2, 3, 4, 5]
    let sum = numbers.withUnsafeBufferPointer { buffer -> Int in
        // buffer: UnsafeBufferPointer
        
        var result = 0
        for i in stride(from: buffer.startIndex, to: buffer.endIndex, by: 2) {
            result += buffer[i]
        }
        return result
    }
    print(sum)
    // 'sum' == 9
}

func test_withMemoryRebound() {
    // 创建一个指向整数的指针
    var intValue = 42
    let intPointer = UnsafeMutablePointer<Int>(&intValue)

    // 使用withMemoryRebound将整数指针重新绑定为浮点数指针
    let result = intPointer.withMemoryRebound(to: Float.self, capacity: 1) { floatPointer -> Float in
        // 在此闭包中，floatPointer 的类型被重新绑定为 Float
        // 可以在这里访问重新绑定后的内存
        floatPointer.pointee = 3.14
        return floatPointer.pointee
    }

    // 打印结果
    print("Result: \(result)")
}


