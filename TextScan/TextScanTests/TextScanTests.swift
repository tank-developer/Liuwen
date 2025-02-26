//
//  TextScanTests.swift
//  TextScanTests
//
//  Created by Apple on 2023/11/9.
//

import XCTest
import NaturalLanguage

@testable import TextScan

final class TextScanTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let text = """
               InBody 身体水分 TinBody770) ID 15904113359 身高 年𠳕 性别 75 男性 测式日期/时间 (（透析）） 172cm
               (1946.07.10） 2021,10.09. 16:39 身体水分组成 身体水分组成 身体水分含量（(L） 60 0O 100 110 120 130
               100 170 32.5 身体总水分 32 5t 30 0AA . 细胞内水分 (） 70 10 GO 100 10 ％ 網舶内水分 19 9L 22 7-277
               19.9 细胞外水分 12.6L (13 号 170 細胞外水分 (L) HOF 00 100 110 120 13o 140 160 170 % 节段水分分析
               12.6 右上肢 1.80 L ( 201-279 细胞外水分比率分析 左上肢 2.00 L 2 07-2 79 低每准 魃干 16 8t 17 4 213
               细胞外水分比事 0.320 0.340 0360 0 380 0.300 0.400 0410 0 420 0.430 0 440 0 450 右下胶 5.65L ( 6
               08-743 0.390 左下肢 5.72 L ( 6 08-743 节段水分分析 人体成分分析 蛋白质 8.7 kg ( 9B~120 标准 无机盐
               2.83 hg 3.38~4 14 右上肢 (L) 70 85 100 15 130 45 160 175 1G0 205 1.80 体脂肪 30.0 xg ( 7.8-156
               左上肢 (L) 55 70 85 100 115 130 145 175 去脂体重 44.0 Mg ( 49 8~00 9 2.00 骨矿物质含量 2.37 kg (
               279~3.41 躯干 (L) 70 80 90 100 110 120 130 40 150 160 170 肌肉脂肪分析 16.8 体重 74.0 xg 55 3-
               74.9 右下肢 (L) 80 90 100 110 120 130 40 150 160 170 % 5.65 骨骼肌含量 23.9 kg 27 8-34 0 肌肉量
               41.6 kg 47.0-57 4 左下肢 (L) 70 80 90 100 110 120 130 140 150 160 170 ％ 5.72 体脂肪含量 30.0
               kg ( 7.8~156 肥胖分析 节段细胞外水分比率分析 BMI 25.0 kg/m ( 18.5~25 .0 体脂百分比 40.5% (10.0~200
               0 43 0.42 研究项目- 浮肿 基础代谢宰 1321 kcal ( 1593~1865 腰臀比 1.07 0.80~0.90 0.395 腹围 102.1
               cm 轻度浮肿 0 39 0.389 0.393 内脏脂肪面积 171.8 cm3 肥胖度 90~110 0 38 0.379 114 % 正常 0.376 身体
               细胞量 28.5 kg ( 32.5~39.7 0 37 上臂围度 32.4 cm 0 36 上臂肌肉围度 27.5 cm 右上肢 左上肢 躯干 右下肢
               左下肢 TBW/FFM 73.9% 去脂体重指数 身体水分历史记录 14.9 kg/m' 脂肪量指数 10.1 kg/m' 体重 (kg) 86.1
               79.1 81.0 79.3 73.5 74.0 全身相位角 ¢( 50xz] 4.6 身体总水分 39.9 35.8 37.1 43.6 35. 32.5 生物电阻
               抗- 细胞内水分 (L) 23.7 22.0 22.9 26.2 右上肢 左上肢躯千 右下肢 左下胶 21.1 19.9 ZQ) 1 MHlz/438.4
               383.5 35.6 331.9 323.0 5 g.428.0 374.7 34.4 324.1 315.2 细胞外水分（L） 16.2 13.8 14.2 17.4
               14.0 50 k1/ 377.9 334.7 31.0 294.0 285.0 12.6 250 H12/345.4 306.2 27.2 275.1 265.0 500 MHz
               334.7 296.9 25.8 270.1 259.4 细胞外水分比率 0.406 0.386 0.383 0.400 0.398 0.390 1000 &H2/
               328.6. 291.3 23.9 265.7 255.3 ：最近 口全部 1903 28 20 01.22: 20.05 20  20 08 24 21 07 01:21
               10.09 129 11 13 11.34 16.31 ：1639 Ver Lookin Body120 32a6- SN. C71600359 Copyrgh(g 1296-by
               InBody Co. Lat Au Pghs resaned BR-Chinese-00-B-140129
           """
        natureLanguage(text: text)
    }
    
    func natureLanguage(text:String) {
        let tokenizer = NLTokenizer(unit: .word) // 分词器操作的粒度级别
        tokenizer.setLanguage(.simplifiedChinese) // 设置要分词的文本的语言
        tokenizer.string = text
        var tokenResult = [String]()
        tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) { tokenRange, attribute in
            let str = String(text[tokenRange])
            if attribute != .numeric, str.count > 1 {
                      tokenResult.append(str)
                print(tokenResult)
            }
            return true
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
