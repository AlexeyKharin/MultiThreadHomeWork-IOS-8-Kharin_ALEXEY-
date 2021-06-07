//
//  ViewController.swift
//  MultiThreadHomeWork
//
//  Created by Alexey Golovin on 19.02.2021.
//
/*

 Разберитесь в коде, указанном в данном примере.
 Вам нужно определить где конкретно реализованы проблемы многопоточности (Race Condition, Deadlock) и укажите их. Объясните, из-за чего возникли проблемы.
 Попробуйте устранить эти проблемы.
 Готовый проект отправьте на проверку. 
 
*/

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exampleOne()
        exampleTwo()
        print("d")
    }
    
    func exampleOne() {
        var storage: [String] = []
        let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)
    //  Race Condition
        //        Здесь был вызов асинхронный
        concurrentQueue.sync {
            for i in 0...10 {
                sleep(1)
                storage.append("Cell: \(i)")
                print(storage[i])
            }
        }
    // Race Condition
        concurrentQueue.async {
            for i in 0...10 {
                storage[i] = "Box: \(i)"
                print(storage[i])
            }
        }
    }
    
    func exampleTwo() {
        print("a")
//        DeadLock - попытка асинхронно на главном потоке вызвать синхронно главный поток
        DispatchQueue.main.async {
            DispatchQueue.main.async {
                //        Здесь был вызов синхронный вызов
                print("b")
            }
            print("c")
        }
        print("d")
    }
    
}

