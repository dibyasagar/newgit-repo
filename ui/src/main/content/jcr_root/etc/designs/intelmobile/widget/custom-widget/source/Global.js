BLM={};
BLM.Global={};
BLM.Global.ListPagesSortOrderChanged=function(c,a){var b=this.findParentByType("dialog");
alert("before submit?  path to  = "+c+", from dialog = "+this.findByType("dialog").path+", thispath11 = "+this.path+", form url = "+this.form.url+", record = "+a+", this = "+this.getField("./path"))
};