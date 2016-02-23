//
//  ViewController.swift
//  TASKEYA_test01
//
//  Created by 井上航 on 2016/02/15.
//  Copyright © 2016年 Wataru Inoue. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIToolbarDelegate {
    @IBOutlet weak var titleTextField: UITextField! //タイトル
    @IBOutlet weak var supDecTextField: UITextField! //実行者決定期限
    @IBOutlet weak var decTextField: UITextField! // 実行期限
    @IBOutlet weak var priceTextField: UITextField! //依頼価格
    @IBOutlet weak var reqRangeTextField: UITextField! //依頼相手
    
    var supDecToolBar: UIToolbar!
    var decToolBar: UIToolbar!
    var priceToolBar: UIToolbar!
    var reqRangeToolBar: UIToolbar!
    
    var supDecDatePicker: UIDatePicker! //実行者決定期限日時選択のPickerView
    var decDatePicker: UIDatePicker! //実行期限日時選択のPickerView
    var reqRangePickerView: UIPickerView!
    
    var supDecDate: NSDate!
    var decDate: NSDate!
    var reqRangeArray: NSArray = ["れべる１","れべる２","広め","全世界"] //依頼相手の選択肢
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /* Create an Image View to replace the Title View */
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named:"taskeyalogo_1024.png")
        
        /* Set the Title View */
        navigationItem.titleView = imageView
        
        
        // 各TextFieldの初期入力文字の設定
        titleTextField.placeholder = "依頼のタイトルを入力"
        supDecTextField.placeholder = dateToString(NSDate())
        decTextField.placeholder = dateToString(NSDate())
        priceTextField.placeholder = "金額を入力"
        reqRangeTextField.placeholder = "依頼範囲を選択"
        
        titleTextField.tag = 1
        supDecTextField.tag = 2
        decTextField.tag = 3
        priceTextField.tag = 4
        reqRangeTextField.tag = 5
        
        titleTextField.delegate = self
        titleTextField.returnKeyType = .Next
        
        // supDecDatePickerの設定
        supDecDatePicker = UIDatePicker()
        supDecDatePicker.addTarget(self, action: "changedSupDecDateEvent:", forControlEvents: UIControlEvents.ValueChanged)
        supDecDatePicker.datePickerMode = UIDatePickerMode.DateAndTime
        supDecTextField.inputView = supDecDatePicker
        
        // supDecToolBar作成。ニョキ担当
        supDecToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        supDecToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        supDecToolBar.backgroundColor = UIColor.blackColor()
        supDecToolBar.barStyle = .BlackTranslucent
        supDecToolBar.tintColor = UIColor.whiteColor()
        
        //supDecToolBarを閉じるボタンを追加
        let supDectoolBarBtn      = UIBarButtonItem(title: "完了", style: .Done, target: self, action: "tappedToolBarBtn:")
        let supDecToolBarBtnToday = UIBarButtonItem(title: "今日", style: .Done, target: self, action: "tappedSupDecToolBarBtnToday:")
        supDectoolBarBtn.tag = 2
        supDecToolBar.items = [supDectoolBarBtn, supDecToolBarBtnToday]
        
        // decDatePickerの設定
        decDatePicker = UIDatePicker()
        decDatePicker.addTarget(self, action: "changedDecDateEvent:", forControlEvents: UIControlEvents.ValueChanged)
        decDatePicker.datePickerMode = UIDatePickerMode.DateAndTime
        decTextField.inputView = decDatePicker
        
        // decToolBar作成。ニョキ担当
        decToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        decToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        decToolBar.backgroundColor = UIColor.blackColor()
        decToolBar.barStyle = .BlackTranslucent
        decToolBar.tintColor = UIColor.whiteColor()
        
        //decToolBarを閉じるボタンを追加
        let decToolBarBtn      = UIBarButtonItem(title: "完了", style: .Done, target: self, action: "tappedToolBarBtn:")
        let decToolBarBtnToday = UIBarButtonItem(title: "今日", style: .Done, target: self, action: "tappedDecToolBarBtnToday:")
        decToolBarBtn.tag = 3
        decToolBar.items = [decToolBarBtn, decToolBarBtnToday]
        
        // priceTextFiledの設定
        priceTextField.keyboardType = .NumberPad
        
        // priceToolBar作成。ニョキ担当
        priceToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        priceToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        priceToolBar.backgroundColor = UIColor.blackColor()
        priceToolBar.barStyle = .BlackTranslucent
        priceToolBar.tintColor = UIColor.whiteColor()
        
        // priceToolBarを閉じるボタンを追加
        let priceToolBarButton = UIBarButtonItem(title: "完了", style: .Done, target: self, action: "tappedToolBarBtn:")
        priceToolBarButton.tag = 4
        priceToolBar.items = [priceToolBarButton]
        
        
        // reqRangePickerViewの設定
        reqRangePickerView = UIPickerView()
        reqRangePickerView.showsSelectionIndicator = true
        reqRangePickerView.delegate = self
        reqRangeTextField.inputView = reqRangePickerView
        
        // reqRangeToolBar作成。ニョキ担当
        reqRangeToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        reqRangeToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        reqRangeToolBar.backgroundColor = UIColor.blackColor()
        reqRangeToolBar.barStyle = .BlackTranslucent
        reqRangeToolBar.tintColor = UIColor.whiteColor()
        
        //reqRangeToolBarを閉じるボタンを追加
        let reqRangeToolBarButton = UIBarButtonItem(title: "完了", style: .Done, target: self, action: "tappedToolBarBtn:")
        reqRangeToolBarButton.tag = 5
        reqRangeToolBar.items = [reqRangeToolBarButton]
        
        
        //TextFieldをpickerViewとToolVerに関連づけ
        supDecTextField.inputAccessoryView = supDecToolBar
        decTextField.inputAccessoryView = decToolBar
        priceTextField.inputAccessoryView = priceToolBar
        reqRangeTextField.inputAccessoryView = reqRangeToolBar
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        print("textFieldShouldReturn!!!!!!!!!!!!")
        
        // 今フォーカスが当たっているテキストボックスからフォーカスを外す
        textField.resignFirstResponder()
        nextInput(textField.tag)
        return true
        
        
    }
    
    //    /*
    //    テキストが編集された際に呼ばれる.
    //    */
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // 変更後の内容を作成する
        var tmpStr = textField.text! as NSString
        tmpStr = tmpStr.stringByReplacingCharactersInRange(range, withString: string)
        
        if tmpStr.length > 20 {
            print("20字を超えました。")
            return false
        }
        //テキストフィールドを更新する
        return true
    }
    
    // 次の入力に移動するメソッド
    func nextInput(tagNum: Int){
        
        //        // 次のTag番号を持っているテキストボックスがあれば、フォーカスする
        let nextTag = tagNum + 1
        if let nextTextField = self.view.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        }
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return reqRangeArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reqRangeArray[row] as? String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reqRangeTextField.text = reqRangeArray[row] as? String
    }
    
    
    // 「完了」を押すと閉じる
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        supDecTextField.resignFirstResponder()
        decTextField.resignFirstResponder()
        priceTextField.resignFirstResponder()
        reqRangeTextField.resignFirstResponder()
        
        nextInput(sender.tag)
    }
    
    // 「今日」を押すと今日の日付をセットする
    func tappedSupDecToolBarBtnToday(sender: UIBarButtonItem) {
        supDecDate = NSDate()
        supDecDatePicker.date = NSDate()
        changeSupDecLabelDate(NSDate())
    }
    
    // 「今日」を押すと今日の日付をセットする
    func tappedDecToolBarBtnToday(sender: UIBarButtonItem) {
        decDate = NSDate()
        decDatePicker.date = NSDate()
        changeDecLabelDate(NSDate())
    }
    
    //
    func changedSupDecDateEvent(sender:UIDatePicker){
        //        var dateSelecter: UIDatePicker = sender
        self.changeSupDecLabelDate(supDecDatePicker.date)
    }
    
    func changedDecDateEvent(sender:UIDatePicker){
        //        var dateSelecter: UIDatePicker = sender
        self.changeDecLabelDate(decDatePicker.date)
    }
    
    func changeSupDecLabelDate(date:NSDate) {
        supDecDate = date
        supDecTextField.text = self.dateToString(date)
    }
    
    func changeDecLabelDate(date:NSDate) {
        decDate = date
        decTextField.text = self.dateToString(date)
    }
    
    func dateToString(date:NSDate) ->String {
        let calender: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let comps: NSDateComponents = calender.components([.Year, .Month, .Day, .Hour, .Minute, .Second, .Weekday] , fromDate: date)
        
        let date_formatter: NSDateFormatter = NSDateFormatter()
        var weekdays: [String?] = [nil, "日", "月", "火", "水", "木", "金", "土"]
        date_formatter.locale     = NSLocale(localeIdentifier: "ja_JP")
        date_formatter.dateStyle = .FullStyle
        print(String(comps.weekday))
        date_formatter.dateFormat = "yyyy年MM月dd日(\(weekdays[comps.weekday]!)) hh時mm分"
        
        return date_formatter.stringFromDate(date)
    }
    
    // 依頼ボタン
    @IBAction func onTappedNextButton(sender: UIButton) {
        self.performSegueWithIdentifier("toSecondVC", sender: nil)
    }
    
    
    
    // 画面遷移の準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "toSecondVC") {
            
            let SecondVC = segue.destinationViewController as! SecondViewController
            
            SecondVC.titleString = self.titleTextField.text
            SecondVC.supDecDate = self.supDecDate
            SecondVC.decDate = self.decDate
            SecondVC.priceInt = Int(self.priceTextField.text!)
            SecondVC.reqRangeString = reqRangeTextField.text
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
