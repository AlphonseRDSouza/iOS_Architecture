//: [Previous](@previous)

import Foundation

import UIKit

import PlaygroundSupport

struct Person { // Model
    let firstName: String
    let lastName: String
}

protocol GreetingViewModelProtocol {
    var greeting: String? { get }
    var greetingDidChange: ((GreetingViewModelCombo) -> ())? { get set } // function to call when greeting did change
    init(person: Person)
}
//Separate @objc protocol: To clear Selector based issue in swift 4 and above
//https://www.jessesquires.com/blog/avoiding-objc-in-swift/
@objc protocol GreetingSelectorProtocol {
    func showGreeting()
}

typealias GreetingViewModelCombo = GreetingViewModelProtocol & GreetingSelectorProtocol


class GreetingViewModel : GreetingViewModelCombo {
    let person: Person
    var greeting: String? {
        didSet {
            self.greetingDidChange?(self)
        }
    }
    var greetingDidChange: ((GreetingViewModelCombo) -> ())?
    required init(person: Person) {
        self.person = person
    }
    @objc func showGreeting() {
        self.greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
    }
}

class GreetingViewController : UIViewController {
    var viewModel: GreetingViewModel! {
        didSet {
            self.viewModel.greetingDidChange = { [unowned self] viewModel in
                print(viewModel.greeting)
                self.greetingLabel.text = viewModel.greeting
            }
        }
    }
    lazy var showGreetingButton : UIButton = {
        let btn = UIButton(frame: CGRect(x: 200, y: 200, width: 70, height: 70))
        btn.setTitle("Tap me", for: .normal)
        btn.backgroundColor = .green
        return btn
    }()
    lazy var greetingLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 200, y: 100, width: 350, height: 60))
        label.backgroundColor = .red
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(greetingLabel)
        view.addSubview(showGreetingButton)
        
        showGreetingButton.addTarget(self.viewModel,
                                     action: #selector(viewModel.showGreeting),
                                     for: .touchUpInside)
    }
    // layout code goes here
}
// Assembling of MVVM
let model = Person(firstName: "David", lastName: "Blaine")
let viewModel = GreetingViewModel(person: model)
let view = GreetingViewController()
view.viewModel = viewModel
view.view.backgroundColor = .lightGray

PlaygroundPage.current.liveView = view.view
