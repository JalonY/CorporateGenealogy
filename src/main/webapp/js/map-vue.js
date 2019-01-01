var vm = new Vue({
    el: "#wholeDiv",
    data: {
        map: "", // 百度地图全局变量
        //regionList: [],
        corpList: [],
    },
    mounted: function () {
        var _this = this;
        map = new BMap.Map("allmap");
        var initPoint = new BMap.Point(118.801372, 32.061892);
        map.centerAndZoom(initPoint, 15); // 初始化地图，设置中心坐标点和地图级别
        map.addControl(new BMap.NavigationControl({enableGeolocation: true})); // 添加比例尺控件
        map.addControl(new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT})); // 左上角
        map.enableScrollWheelZoom(true); // 开启鼠标滚轮缩放

        this.getMapList();

        // 监听缩放事件
        map.addEventListener('zoomend', function (event) {
            console.log("缩放");
            _this.mapResize(event.target);
        });
        // 监听拖拽事件
        map.addEventListener('dragend', function (event) {
            console.log("拖拽");
            _this.mapResize(event.target);
        })
    },
    methods: {
        /**
         * 根据城市名称定位
         */
        locationByCityName: function () {
            var cityName = this.$refs.cityName.value;
            map.centerAndZoom(cityName,11);
            var _this = this;
            // 地图加载完成事件
            // 不等他加载完成的话，获取的总是上一次的坐标
            map.addEventListener("tilesloaded", function (event){
                _this.mapResize(event.target);
            });
        },
        /**
         * 获取数据
         */
        getMapList: function () {
            this.getAllCorp();
            this.getCorpDataTable();
        },


        /**
         * 获取所有公司坐标点
         */
        getAllCorp: function () {
            var _this = this;
            this.$http.get("http://localhost:8080/mapCorp.do").then(function (result) {
                var mapCorpList = result.body;
                _this.corpList = mapCorpList;
                for (var i = 0; i < mapCorpList.length; i++) {
                    var point = new BMap.Point(mapCorpList[i].longitude, mapCorpList[i].latitude); // 标记坐标点
                    var label = new BMap.Label(mapCorpList[i].corpName, {offset: new BMap.Size(20, -10)});// 标记说明
                    _this.addMarker(point, label);
                }
                _this.getTradeEcharts(mapCorpList);
                _this.getCapiEcharts(mapCorpList);
            });
        },


        /**
         * 获取地图范围内的公司
         */
        getCorpInsizeMap: function (leftLongitude, leftLatitude, rightLongitude, rightLatitude) {
            var _this = this;
            this.$http.get("http://localhost:8080/mapInside.do?leftLongitude=" + leftLongitude +
                "&leftLatitude=" + leftLatitude +
                "&rightLongitude=" + rightLongitude +
                "&rightLatitude=" + rightLatitude).then(function (result) {
                _this.corpList = result.body;
                _this.getTradeEcharts(result.body);
                _this.getCapiEcharts(result.body);
            });
        },


        /**
         * 企业行业图谱展示
         */
        getTradeEcharts: function (data) {
            var newList = data;
            var tempJSON = [];
            //遍历数组，并分类统计,放入tempJSON中
            for(var i = 0; i < newList.length; i++) {
                if(!tempJSON[newList[i].belongTrade]) {
                    var arr = [];
                    arr.push(newList[i]);
                    tempJSON[newList[i].belongTrade] = arr;
                }else {
                    tempJSON[newList[i].belongTrade].push(newList[i]);
                }
            }
            console.log(tempJSON);
            console.log("tempJSON长度"+Object.keys(tempJSON).length);

            var tradeArr = [];
            var i = 0;
            for(var trade in tempJSON){
                if(i > 4){
                    break;
                }
                tradeArr[i] = {
                    value: tempJSON[trade].length,
                    name: trade
                }
                i++;
            }

            var myChart = echarts.init(document.getElementById('mapCorp1'));
            option = {
                title : {
                    text: '企业所属行业分析（TOP5）',
                    x:'center'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series : [
                    {
                        name: '所属行业',
                        type: 'pie',
                        radius : '55%',
                        center: ['50%', '55%'],
                        data: tradeArr,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            myChart.setOption(option);
        },


        /**
         * 企业资本图谱展示
         */
        getCapiEcharts: function (data) {
            if(data.length > 0){
                $('#mapCorp1').css("display","block");
                $('#mapCorp2').css("display","block");
                $('.mapMessage').css("display","none");

                var class1 = 0;
                var class2 = 0;
                var class3 = 0;
                var class4 = 0;
                var class5 = 0;
                //遍历数组，并分类统计,放入tempJSON中
                for(var i = 0; i < data.length; i++) {
                    if( 0 < data[i].regCapi && data[i].regCapi <= 100){
                        class1 += 1;
                    }else if( 100 < data[i].regCapi && data[i].regCapi <= 500){
                        class2 += 1;
                    }else if( 500 < data[i].regCapi && data[i].regCapi <= 1000){
                        class3 += 1;
                    }else if( 1000 < data[i].regCapi && data[i].regCapi <= 5000){
                        class4 += 1;
                    }else if( 5000 < data[i].regCapi){
                        class5 += 1;
                    }
                }

                var tradeArr = [];
                if(class1 != 0){
                    tradeArr[0] = {
                        value: class1,
                        name: "0-100万"
                    }
                };
                if(class2 != 0){
                    tradeArr[1] = {
                        value: class2,
                        name: "101-500万"
                    }
                };
                if(class3 != 0){
                    tradeArr[2] = {
                        value: class3,
                        name: "501-1000万"
                    }
                };
                if(class4 != 0){
                    tradeArr[3] = {
                        value: class4,
                        name: "1001-5000万"
                    }
                };
                if(class5 != 0){
                    tradeArr[4] = {
                        value: class5,
                        name: "5001万以上"
                    }
                };


                var myChart = echarts.init(document.getElementById('mapCorp2'));
                option = {
                    title : {
                        text: '企业注册资本统计',
                        x:'center'
                    },
                    tooltip : {
                        trigger: 'item',
                        formatter: "{a} <br/>{b} : {c} ({d}%)"
                    },
                    series : [
                        {
                            name: '注册资本',
                            type: 'pie',
                            radius : '55%',
                            center: ['50%', '55%'],
                            data: tradeArr,
                            itemStyle: {
                                emphasis: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }
                    ]
                };
                myChart.setOption(option);
            }else{
                $('#mapCorp1').css("display","none");
                $('#mapCorp2').css("display","none");
                $('.mapMessage').css("display","block");
            }
        },


        /**
         * 表格展示
         */
        getCorpDataTable: function () {
            $('#showCorpTable').DataTable({
                "ajax" : "http://localhost:8080/tableCorp.do",
                "pageLength" : 5,
                "pagingType" : "full_numbers",
                "language" : {
                    "emptyTable" : "无可用数据",
                    "infoEmpty" : "没有记录可以显示",
                    "loadingRecords" : "请等待，数据正在加载中......",
                    "search" : "搜索",
                    "lengthMenu" : "Show _MENU_ entries",
                    "lengthMenu" : '显示 <select>'
                    + '<option value="5">5</option>'
                    + '<option value="10">10</option>'
                    + '<option value="20">20</option>'
                    + '<option value="30">30</option>'
                    + '<option value="40">40</option>'
                    + '<option value="-1">所有</option>'
                    + '</select> 记录',
                    "info" : "第_PAGE_页(共_PAGES_页）",
                    "paginate" : {
                        "first" : '首页',
                        "previous" : '上一页',
                        "next" : '下一页',
                        "last" : '尾页'
                    },
                    "aria" : {
                        "paginate" : {
                            "first" : 'First',
                            "previous" : 'Previous',
                            "next" : 'Next',
                            "last" : 'Last'
                        }
                    }
                },
                "columns" : [ {
                    "data" : "corpName"
                }, {
                    "data" : "operManName"
                }, {
                    "data" : "regCapi"
                }, {
                    "data" : "belongTrade"
                }, {
                    "data" : "corpAddr"
                }  ]
            });
        },


        /**
         * 获取范围区域
         */
        // getAllRegion: function () {
        //     var _this = this;
        //     this.$http.get("http://localhost:8080/mapRegion.do").then(function (result) {
        //         var mapRegionList = result.body;
        //         console.log(mapRegionList.length);
        //         for (var i = 0; i < mapRegionList.length; i++) {
        //             var point = new BMap.Point(mapRegionList[i].longitude, mapRegionList[i].latitude); // 标记坐标点
        //             var regionName = mapRegionList[i].regionName;
        //             var corpNum = mapRegionList[i].corpNum;
        //             _this.drawRegion(point, regionName, corpNum);
        //         }
        //     });
        // },


        /**
         * 标记坐标点
         * @param corpPoint
         * @param corpNameLabel
         */
        addMarker: function (corpPoint, corpNameLabel) {
            var marker = new BMap.Marker(corpPoint);
            marker.setLabel(corpNameLabel);
            map.addOverlay(marker);
        },


        /**
         * 删除所有标记点
         * 当地图范围太大时只显示区域内容，不显式具体的点
         */
        // deleteAllPoint: function () {
        //     var allOverlay = map.getOverlays();
        //     for (var i = 0; i < allOverlay.length - 1; i++) {
        //         map.removeOverlay(allOverlay[i]);
        //     }
        // },


        /**
         * 刻画区域
         * @param regionPoint
         * @param regionName
         * @param corpNum
         */
        // drawRegion: function (regionPoint, regionName, corpNum) {
        //     var textContent = '<p style="margin-top: 20px; pointer-events: none">' +
        //         regionName + '</p>' + '<p style="pointer-events: none">' +
        //         corpNum + '个</p>';
        //     var textLabel = new BMap.Label(textContent, {
        //         position: regionPoint, // 标签位置
        //         offset: new BMap.Size(-40, 20) //文本偏移量
        //     });
        //     textLabel.setStyle({
        //         height: '78px',
        //         width: '78px',
        //         color: '#fff',
        //         backgroundColor: '#0054a5',
        //         border: '0px solid rgb(255, 0, 0)',
        //         borderRadius: "50%",
        //         fontWeight: 'bold',
        //         display: 'inline',
        //         lineHeight: 'normal',
        //         textAlign: 'center',
        //         opacity: '0.8',
        //         zIndex: 2,
        //         overflow: 'hidden'
        //     });
        //     map.addOverlay(textLabel); // 将标签画在地图上
        // },

        /**
         * 地图缩放
         */
        mapResize: function (_map) {
            // 获取当前地图边界
            var bounds = _map.getBounds(),
                southWest = bounds.getSouthWest(),  // 西北角
                northEast = bounds.getNorthEast();  // 东北角

            var zoomLevel = _map.getZoom();

            params = {
                level: zoomLevel,
                leftLongitude: southWest.lng,   // 左上角
                leftLatitude: northEast.lat,
                rightLongitude: northEast.lng,  // 右下角
                rightLatitude: southWest.lat
            };

            // 搜索地图范围内的公司
            // 每当地图大小改变，就重新搜索
            this.getCorpInsizeMap(params.leftLongitude, params.leftLatitude,
                params.rightLongitude, params.rightLatitude);

            // 默认缩放级别为15
            // 缩放级别小于13，删除所有点，只保留区域内容
            // if (zoomLevel < 13) {
            //     this.deleteAllPoint();
            // } else {
            //     this.getAllCorp();
            // }

            console.log("左上角：" + params.leftLongitude+ "," + params.leftLatitude);
            console.log("右下角：" + params.rightLongitude + "," + params.rightLatitude);
        }
    }
});

