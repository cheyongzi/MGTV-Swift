# MGTV-Swift
    1. 项目初衷为了学习Swift所写，通过真实接口请求，仿写部分芒果TV UI
    2. 语言Swift3.0，iOS9.0以上
    3. 后续会继续更新其它UI实现

# ViewSource
    项目中通过ViewSource的方式让Controller代码剥离出去，在ViewSource中进行View的管理
    
# DataSource
    项目中通过DataSource的方式发起网络请求，通过Block的方式回调，这样可以确保哪里调用哪里处理，更方便一些view中请求的操作

# Network
    网络的请求通过Alamofire，AlamofireObjectMapper两个第三方库实现
