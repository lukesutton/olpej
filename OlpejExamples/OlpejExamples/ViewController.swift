//
//  ViewController.swift
//  OlpejExamples
//
//  Created by Luke Sutton on 7/07/2016.
//  Copyright © 2016 Luke Matthew Sutton. All rights reserved.
//

import UIKit
import Olpej

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label1 = Component<UILabel>(
            id: "label-1",
            properties: [
                .text("what the heck man"),
                .textColor(.redColor()),
                .textAlignment(.Right),
                .hidden(false)
            ]
        )
        
        let button1 = Component<UIButton>(
            id: "button-1",
            properties: [
                .title("First", forState: .Normal),
                .backgroundColor(.blueColor()),
                .frame(x: 20, y: 20, width: 100, height: 50)
            ]
        )

        let button2 = Component<UIButton>(
            id: "button-2",
            properties: [
                .title("Second", forState: .Normal),
                .backgroundColor(.redColor()),
                .frame(x: 20, y: 20, width: 100, height: 50)
            ]
        )

        let stack = Component<UIStackView>(
            id: "stack",
            properties: [
                .alignment(.Fill),
                .axis(.Vertical),
                .distribution(.FillEqually),
                .frame(x: 20, y: 20, width: 300, height: 400),
                .pinTop(),
                .pinLeft(),
                .pinRight(),
                .pinBottom()
            ],
            children: [
                label1,
                button1,
                button2
            ]
        )
        
        stack.render(to: view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

