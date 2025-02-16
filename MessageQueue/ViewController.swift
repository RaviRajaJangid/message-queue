//
//  ViewController.swift
//  MessageQueue
//
//  Created by Ravi Raja Jangid on 16/02/25.
//

import UIKit

class ViewController: UIViewController, MessageQueueProtocol {
   
    
    var message: UILabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(message)
        message.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            message.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            message.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        let m1 = Message(message: "Hi")
        let m2 = Message(message: "Hello")
        let m3 = Message(message: "How are you")
        let m4 = Message(message: "What are you doing")
        let m5 = Message(message: "Are you alright")
        MessageQueue.setDelay(delayTime: 2)
        MessageQueue.setDelegate(delegate: self)
        MessageQueue.addMessage(message: m1)
        MessageQueue.addMessage(message: m2)
        MessageQueue.addMessage(message: m3)
        MessageQueue.addMessage(message: m4)
        MessageQueue.addMessage(message: m5)
        DispatchQueue.main.asyncAfter(deadline: .now()+6 , execute: {
            MessageQueue.addMessage(message: m1)
            MessageQueue.addMessage(message: m2)
            MessageQueue.addMessage(message: m3)
            MessageQueue.addMessage(message: m4)
            MessageQueue.addMessage(message: m5)
        })
    }

    func onMessagePop(message: any MessageProtocol) {
        if let m = message as? Message {
            self.message.text = m.message
        }
    }
}

