# SnakeGame
* 語言：Swift
* 架構：MVVM
* 控制方式：Swipe

# 設計方向
## 遊戲畫面
設定畫面中一格的單位，根據不同螢幕解析度去計算最大格子數、蛇的寬度、食物的位子...等。
好處在各種螢幕上都能感受到滿版效果，缺點是遊戲上不符合邏輯，平板的格子數比手機多，存活率跟得分會佔優勢。

## 蛇的組成
蛇的身體由Queue搭配自定義class `Point(x, y)`，每一個Point代表一節身體。
根據定義的單位去進行各種計算，比如，單位為10，往右邊前進，下一個頭的節點為`(x + 10, y)`

## 繪圖方式
原先在UIBezierPath與CGContext做考量，基於以下兩個原因，最後採用UIBezierPath。
1. UIBezierPath屬於在Core Animation，CGContext屬於在Core Graphics，而Core Animation是封裝Core Graphics，考量到只需要繪畫背景、蛇、食物，都是矩形就能完成的事情，不太需要用到較底層的CGContext
2. 某篇[stackoverflow](https://stackoverflow.com/questions/6327817/why-is-uibezierpath-faster-than-core-graphics-path)表示UIBezierPath是對Core Graphics進行封裝，所以性能是差不多的，但個人實測用模擬去繪製16000個5*5矩形，UIBezierPath與CGContext效能並無相差，所以，在目前的需求下，選擇兩者是不會差太多的。
