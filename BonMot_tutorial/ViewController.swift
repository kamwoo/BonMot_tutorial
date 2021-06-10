//
//  ViewController.swift
//  BonMot_tutorial
//
//  Created by wooyeong kam on 2021/06/10.
//

import UIKit
import BonMot


class ViewController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    @IBOutlet var fourthLabel: UILabel!
    @IBOutlet var fifthLabel: UILabel!
    @IBOutlet var sixthLabel: UILabel!
    @IBOutlet weak var sevenLabel: UILabel!
    
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setLabelStyle(with: "이것은 일반적인 방법으로 적용된 라벨 스타일 입니다.")
        setLabelStyleWithBonMot(with: "이것은 Bonmot이 적용된 라벨 스타일 입니다.")
        setLabelStyleDirectly()
        
        fourthLabel.attributedText = "이것은 사만코 글자 입니다".styled(with: MyText.titleBold)
        fifthLabel.attributedText = "이것은 메로나 글자 입니다.".styled(with: MyText.titleLight)
        setLabelStyleMultiComposed()
        setLabelWithXMLStyle()
        
    }
    
    
    // 일반적인 적용 방법
    fileprivate func setLabelStyle(with content: String){
        print("ViewController - setLabelStyle() called")
        
        let attributedString = NSMutableAttributedString(string: content)
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 2 // Whatever line spacing you want in points
        
        
        let font = UIFont.systemFont(ofSize: 72)
        let customFont = UIFont(name: "BinggraeMelona", size: 20)!
        let attributes: [NSAttributedString.Key: Any] = [
            .font: customFont,
            .foregroundColor: UIColor.red,
        ]
        
        attributedString.addAttributes(attributes, range: NSMakeRange(0, attributedString.length))
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        
        
        firstLabel.attributedText = attributedString
//        firstLabel.font = UIFont(name: "Maplestory OTF Bold", size: 20)!
        firstLabel.textColor = .black
    }

    fileprivate func setLabelStyleWithBonMot(with content: String){
        // 스트링 스타일 설정
        let style = StringStyle(.font(UIFont(name: "BinggraeMelona", size: 20)!),
                                .lineSpacing(2),
                                .color(.blue))
        
        secondLabel.attributedText = content.styled(with: style)
        
    }
    
    fileprivate func setLabelStyleDirectly(){
        thirdLabel.numberOfLines = 0
        thirdLabel.attributedText = "이것은 단어단위로 나눠지는 방법으로 적용된 라벨 스타일 입니다.".styled(with: .lineBreakMode(.byWordWrapping), .alignment(.center), .color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)))
    }
    
    fileprivate func setLabelStyleMultiComposed(){
        let firstAttributedString = "이것을 첫 단어 // ".styled(with: .lineBreakMode(.byCharWrapping),
                                                                      .color(.brown))
        let secondAttributedString = "이것은 두번째 단어 // ".styled(with: MyText.titleLight)
        let thirdAttributedString = "이것은 세번째 단어 ".styled(with: MyText.titleBold)
        sixthLabel.attributedText = NSAttributedString.composed(of: [
            firstAttributedString, secondAttributedString, thirdAttributedString
        ])
    }
    
    fileprivate func setLabelWithXMLStyle(){
        let string = "오 이런 <red>빨간 글자</red> 이건 <blue>파란 글자</blue> 이런 <myCustomStyle>커스텀 스타일</myCustomStyle>"
        let redStyle = StringStyle(.lineBreakMode(.byCharWrapping),
                                   .color(.red),
                                   .backgroundColor(.yellow)
                                   )
        let blueStyle = StringStyle(.lineBreakMode(.byCharWrapping),
                                    .color(.blue),
                                    .backgroundColor(.yellow)
                                    )
        let completeStyle = StringStyle(
            .font(UIFont.systemFont(ofSize: 20)),
            .lineSpacing(2),
            .xmlRules([
                .style("red", redStyle),
                .style("blue", blueStyle),
                .style("myCustomStyle", MyText.titleLight)
            ])
        )
        
        sevenLabel.attributedText = string.styled(with: completeStyle)
    }
    
}

struct MyText {
    static let titleBold = StringStyle(
        .color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)),
        .font(UIFont(name: "BinggraeSamanco", size: 25)!)
    )
    static let titleLight = StringStyle(
        .color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),
        .font(UIFont(name: "BinggraeMelona", size: 25)!)
    )
}
