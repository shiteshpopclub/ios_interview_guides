import UIKit

protocol iOSEngineerSkilSet {
    func getLanguageExpertise()
}

protocol devOpsEngineesSkilSet {
    func getLanguageExpertise()
}

class Employee {
    let name: String

    init(name: String) {
        self.name = name
    }

    func employeeDetails() {
        print("Emp name is \(name)")
    }
}

class iOSEngineer: Employee, iOSEngineerSkilSet, devOpsEngineesSkilSet {
    func getLanguageExpertise() {
        print("Swift")
    }
}

let iosEngineer = iOSEngineer(name: "Shitesh")
iosEngineer.employeeDetails()
iosEngineer.getLanguageExpertise()


func stringifyValue(distance: Int) -> String {
    var result: String = "The distance is "
    result += String(distance)
    return result
}
print(stringifyValue(distance: 67))
