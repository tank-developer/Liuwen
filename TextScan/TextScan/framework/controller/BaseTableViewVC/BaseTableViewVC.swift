

import UIKit

class BaseTableViewVC: BaseTemplateVC ,UITableViewDelegate,UITableViewDataSource{
    
    public func getTableViewRowHeight() ->(CGFloat){
        return 60.0
    }
    
    
    
    public func initBaseView(baseTableView:BaseTableView) ->(){
        super.initBaseView(baseView: baseTableView)
        baseTableView.baseTableView.delegate = self
        baseTableView.baseTableView.dataSource = self
        baseTableView.baseTableView.rowHeight = self.getTableViewRowHeight()
    }
    public override func initBaseVo(baseVo:BaseVo) ->(){
        var vo = baseVo
        vo = BaseVo()
    }
    public func getBaseTableCellVoByIndexPath(indexPath:IndexPath,baseTableViewVo:BaseTableViewVo) ->(BaseTableCellVo){
        if !baseTableViewVo.isEqual(nil) && baseTableViewVo.dataArray.count != 0 && baseTableViewVo.dataArray.count >= indexPath.row {
            let cellVo = baseTableViewVo.dataArray[indexPath.row] as! BaseTableCellVo
            return cellVo
        }else{
            if baseTableViewVo.isEqual(NSNull.self){
                print("getBaseTableCellVoByIndexPath error baseTableViewVo == nil")
            }
            if baseTableViewVo.dataArray.count == 0{
                print("getBaseTableCellVoByIndexPath error baseTableViewVo.dataArray == nil")
            }
            if baseTableViewVo.dataArray.count < indexPath.row{
                print("getBaseTableCellVoByIndexPath error [baseTableViewVo.dataArray count] < indexPath.row")
                print("baseTableViewVo.dataArray.count",baseTableViewVo.dataArray.count)
                print("indexPath.row",indexPath.row)

            }
        }
        let cellDataDic = Dictionary<String,Any>()
        let dbDic = Dictionary<String,Any>()
        return BaseTableCellVo.init(cellName: "", cellDataDic: cellDataDic, dbDic: dbDic)
    }
    
//    public func getBaseTableCellVoByIndexPath(indexPath:IndexPath,baseTableViewVo:BaseTableViewVo) ->(BaseTableCellVo){
//        if baseTableViewVo != nil && baseTableViewVo.dataArray != nil && baseTableViewVo.dataArray.count >= indexPath.row {
//            var cellVo = baseTableViewVo.dataArray[indexPath.row] as! BaseTableCellVo
//            return cellVo
//        }else{
//            if baseTableViewVo == nil{
//                print("getBaseTableCellVoByIndexPath error baseTableViewVo == nil")
//            }
//            if baseTableViewVo.dataArray == nil{
//                print("getBaseTableCellVoByIndexPath error baseTableViewVo.dataArray == nil")
//            }
//            if baseTableViewVo.dataArray.count < indexPath.row{
//                print("getBaseTableCellVoByIndexPath error [baseTableViewVo.dataArray count] < indexPath.row")
//                print("baseTableViewVo.dataArray.count",baseTableViewVo.dataArray.count)
//                print("indexPath.row",indexPath.row)
//
//            }
//        }
//        let cellDataDic = Dictionary<String,Any>()
//        let dbDic = Dictionary<String,Any>()
//        return BaseTableCellVo.init(cellName: "", cellDataDic: cellDataDic, dbDic: dbDic)
//    }
    public func getBaseTableView() ->(BaseTableView){
        return BaseTableView()
    }
    override public func getBaseTemplateView() ->(BaseTemplateView){
        return getBaseTableView()
    }
    //(valueChanged(button:))
    override func viewDidLayoutSubviews() {
        let baseTableView = getBaseTableView()
        if !baseTableView.isEqual(nil) {
            if baseTableView.baseTableView.responds(to:(Selector(("setSeparatorInset:")))) {
                baseTableView.baseTableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            }
            if baseTableView.baseTableView.responds(to:(Selector(("setLayoutMargins:")))) {
                baseTableView.baseTableView.layoutMargins = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //代理和数据源方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let baseTableViewVo = self.getBaseTableViewVo()
        if !baseTableViewVo.isEqual(nil) {
            if baseTableViewVo.dataArray == nil || baseTableViewVo.dataArray.count == 0 {
                return 0
            }
            return baseTableViewVo.dataArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellid = "UITableViewCell"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        if cell.isEqual(nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.getTableViewRowHeight()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to:(Selector(("setSeparatorInset:")))) {
            cell.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
        if cell.responds(to:(Selector(("setLayoutMargins:")))) {
            cell.layoutMargins = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let baseTableViewVo = self.getBaseTableViewVo()
        let baseTableCellVo = self.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: baseTableViewVo)
        if baseTableCellVo.isEditable == "YES" {
            return true
        }else{
            return false
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let toBeRemoveVo = self.getBaseTableCellVoByIndexPath(indexPath: indexPath, baseTableViewVo: self.getBaseTableViewVo())
        if editingStyle == .delete {
            self.removeCellFromTableView(tableview: tableView, toBeRemoveVo: toBeRemoveVo, cellIndexPath: indexPath)
        }
    }
    
    func removeCellFromTableView(tableview:UITableView,toBeRemoveVo:BaseTableCellVo,cellIndexPath:IndexPath) -> Void {
        
    }
    
    func afterRemoveCellFromTableViewEditingStyleForRowAtIndexPath(tableView:UITableView,indexPath:IndexPath) -> Void {
        self.getBaseTableView().reloadTableViewImmediately()
        if indexPath.row != 0{
            let scrollIndexPath = IndexPath.init(row: indexPath.row - 1, section: indexPath.section)
            tableView.scrollToRow(at: scrollIndexPath, at: UITableView.ScrollPosition.middle, animated: true)
        }
    }
    func getBaseTableViewVo() -> BaseTableViewVo {
        return BaseTableViewVo()
    }
    

}
