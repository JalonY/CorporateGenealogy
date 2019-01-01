//网站地图模块
$('.map .btn').click(function(){
    $('.map-pop').show();
    $(this).parents('.map').addClass('map-big-i');
    var winW = $(window).width();
    var winH = $(window).height();
    console.log(winH);
    if(winW < 768){
        $('.map-pop').height($(window).height()-50-80);
        $('.map-big-i').height($(window).height()-50-80);
        $("html, body").animate({ scrollTop: $(document).height() }, 1000);
    }else{

        $('.map-pop').height($(window).height()-344);
        $('.map-big-i').height($(window).height()-344);
        $("html, body").animate({ scrollTop: $(document).height() }, 1000);
    }
    initMap();
})
$('.map .btn-down').click(function(){
    $('.map-pop').hide();
    $(this).parents('.map').removeClass('map-big-i');
    $('.map').height('107');
})




//创建和初始化地图函数：
function initMap(){
      createMap();//创建地图
      setMapEvent();//设置地图事件
      addMapOverlay();//向地图添加覆盖物
    }
    function createMap(){ 
      map = new BMap.Map("map"); 
      map.centerAndZoom(new BMap.Point(120.783517,31.314176),18);
    }
    function setMapEvent(){
      map.enableScrollWheelZoom();
      map.enableKeyboard();
      map.enableDragging();
      map.enableDoubleClickZoom()
    }
    function addClickHandler(target,window){
      target.addEventListener("click",function(){
        target.openInfoWindow(window);
      });
    }
    function addMapOverlay(){
      var markers = [
        {content:"",title:"",imageOffset: {width:-46,height:-21},position:{lat:39.912588,lng:116.46682}}
      ];
      for(var index = 0; index < markers.length; index++ ){
        var point = new BMap.Point(markers[index].position.lng,markers[index].position.lat);
        var marker = new BMap.Marker(point,{icon:new BMap.Icon("http://api.map.baidu.com/lbsapi/createmap//icon/icon.png",new BMap.Size(20,25),{
          imageOffset: new BMap.Size(markers[index].imageOffset.width,markers[index].imageOffset.height)
        })});
        var label = new BMap.Label(markers[index].title,{offset: new BMap.Size(25,5)});
        var opts = {
          width: 200,
          title: markers[index].title,
          enableMessage: false
        };
        var infoWindow = new BMap.InfoWindow(markers[index].content,opts);
        marker.setLabel(label);
        addClickHandler(marker,infoWindow);
        map.addOverlay(marker);
      };
    }
    //向地图添加控件
    function addMapControl(){
      var scaleControl = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
      scaleControl.setUnit(BMAP_UNIT_IMPERIAL);
      map.addControl(scaleControl);
      var navControl = new BMap.NavigationControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT,type:0});
      map.addControl(navControl);
      var overviewControl = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:true});
      map.addControl(overviewControl);
    }
    var map;
      