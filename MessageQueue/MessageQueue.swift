//
//  MessageQueue.swift
//  MessageQueue
//
//  Created by Ravi Raja Jangid on 16/02/25.
//

import Foundation
protocol MessageProtocol {
//    var title: String? { get }
//    var message: String { get }
}
class Message: MessageProtocol {
    var title: String?
    var message: String
    init(title: String? = nil, message: String) {
        self.title = title
        self.message = message
    }
}

protocol MessageQueueProtocol: AnyObject {
    func onMessagePop(message: MessageProtocol)
}

class MessageQueue {
    
    weak var delegate: MessageQueueProtocol?
    private var delayTime: Double = 1
    static private var delay: DispatchTime {
        return .now() + sharedInstance.delayTime
    }
    
    private init(){}
    
    private static let sharedInstance = MessageQueue()
    var isEmpty: Bool = false
    private var queue:[MessageProtocol] = []
    
    static func setDelegate(delegate: MessageQueueProtocol){
        sharedInstance.delegate = delegate
    }
    
    static func setDelay(delayTime: Double){
        sharedInstance.delayTime = delayTime
    }
    static func addMessage(message: MessageProtocol){
        sharedInstance.queue.append(message)
        print(sharedInstance.queue.count)
        if sharedInstance.queue.count == 1, let message = sharedInstance.queue.first {
            popMessage(message: message)
            
        }
    }
    
    static private func popMessage(message: MessageProtocol){
        let startTime = Date()
        DispatchQueue.main.asyncAfter(deadline: delay , execute: {
            sharedInstance.queue.removeFirst()
            sharedInstance.delegate?.onMessagePop(message:message)
            if let message = sharedInstance.queue.first {
                popMessage(message: message)
                let endTime = Date()
                let executionTime = endTime.timeIntervalSince(startTime) // Time in seconds
                print("Execution Time: \(executionTime) seconds")
            }
        })
      
    }
}
