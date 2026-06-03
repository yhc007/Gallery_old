threeSixty = {
    init: function() {
    	alert("init");
        //this._vr = new AC.VR('viewer', 'http://106.240.234.114:8080/media/21/00200002/PANORAMA-LK1104-56-17-140-110-#.jpg', 34, {
    	getMediaPath1();
    	this._vr = new AC.VR('viewer', getMediaPath(), 34, {
            invert: true
        });
    },
    didShow: function() {
        this.init();
    },
    willHide: function() {
        recycleObjectValueForKey(this, "_vr");
    },
    shouldCache: function() {
        return false;
    }
};
if (!window.isLoaded) {
    window.addEventListener("load", function() {
    	alert("threeSixty start");
        threeSixty.init();
    }, false);
}
