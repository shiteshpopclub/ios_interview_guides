import UIKit

/*
 https://medium.com/macoclock/template-method-pattern-8cc01879099d
 https://vinileal.com/design%20patterns/design-patterns-swift-template-method/
 
 
 Template method
 
 ‘Template Method’ pattern is a behavioral design pattern which improves the communication/interaction between objects and keeps them loosely coupled.

 The ‘Template Method’ pattern defines a structure with the skeleton of an algorithm and delegates the responsibility for some of its steps to subcomponents.

 When should we use this pattern?
 This pattern should be used when two, or more, components have similarities in the implementation of an algorithm.


 
 */

typealias File     = String
typealias RawData  = String
typealias Data   = String
typealias Analysis = String

/// Blueprint of the functions that will require custom implementations
protocol DataMiner {
    func openFile(path: String) -> File
    func extractData(file: File) -> RawData
    func parseData(data: RawData) -> `Data`
    func closeFile(file: File)
}

extension DataMiner {
    /// TEMPLATE METHOD: series of functions defining the algorithm
    func mine(path: String) {
        print("\(#function)   path: \(path)")
        let file = openFile(path: path)
        let rawData = extractData(file: file)
        let data = parseData(data: rawData)
        let analysis = analyzeData(analysis: data)
        sendReport(analysis: analysis)
        closeFile(file: file)
    }
    // MARK: Default implementations
    func analyzeData(analysis: `Data`) -> Analysis {
        print("ℹ️ analyze data")
        return "analysis"
    }
    func sendReport(analysis: Analysis) {
        print("ℹ️ send report")
    }
}


// PDFDataMiner conforms to the DataMiner protocol
class PDFDataMiner: DataMiner {
    init() {
        // Call the template method
        mine(path: "PDFFilePath")
    }
    func openFile(path: String) -> File {
        print("📃️ open PDF File")
        return "PDF file opened"
    }
    func extractData(file: File) -> RawData {
        print("📃️ extract PDF data")
        return "PDF raw data extracted"
    }
    func parseData(data: RawData) -> `Data` {
        print("📃️ parse PDF data")
        return "PDF data parsed"
    }
    func closeFile(file: File) {
        print("📃️ close PDF File")
    }
}
// Testing the PDF implementation
_ = PDFDataMiner()


protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}


class MyView: UIView {

    var firstLabel = UILabel()
    var secondLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyView: CodeView {

    func buildViewHierarchy() {
        addSubview(firstLabel)
        addSubview(secondLabel)
    }

    func setupConstraints() {
    // Preferred constraint setup
    }

    func setupAdditionalConfiguration() {
        firstLabel.backgroundColor = .blue
        secondLabel.numberOfLines = 2
    }
}
