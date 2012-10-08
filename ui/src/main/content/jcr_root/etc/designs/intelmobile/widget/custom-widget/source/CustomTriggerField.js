CQ.Ext.form.CustomTriggerField=CQ.Ext.extend(CQ.Ext.form.TextField,{defaultAutoCreate:{tag:"input",type:"text",size:"16",autocomplete:"off"},hideTrigger:false,autoSize:CQ.Ext.emptyFn,monitorTab:true,deferHeight:true,mimicing:false,onResize:function(a,b){CQ.Ext.form.CustomTriggerField.superclass.onResize.call(this,a,b);
if(typeof a=="number"){this.el.setWidth(this.adjustWidth("input",a-this.trigger.getWidth()))
}this.wrap.setWidth(this.el.getWidth()+this.trigger.getWidth())
},adjustSize:CQ.Ext.BoxComponent.prototype.adjustSize,getResizeEl:function(){return this.wrap
},getPositionEl:function(){return this.wrap
},alignErrorIcon:function(){if(this.wrap){this.errorIcon.alignTo(this.wrap,"tl-tr",[2,0])
}},onRender:function(b,a){CQ.Ext.form.CustomTriggerField.superclass.onRender.call(this,b,a);
this.wrap=this.el.wrap({cls:"x-form-field-wrap"});
this.trigger=this.wrap.createChild(this.triggerConfig||{tag:"img",src:CQ.Ext.BLANK_IMAGE_URL,cls:"x-form-trigger "+this.triggerClass});
if(this.hideTrigger){this.trigger.setDisplayed(false)
}this.initTrigger();
if(!this.width){this.wrap.setWidth(this.el.getWidth()+this.trigger.getWidth())
}alert("HERE = "+this.wrap.getWidth());
this.wrap.setWidth("95%");
alert("HERE AFTER = "+this.wrap.getWidth())
},afterRender:function(){CQ.Ext.form.CustomTriggerField.superclass.afterRender.call(this);
var a;
if(CQ.Ext.isIE&&this.el.getY()!=(a=this.trigger.getY())){this.el.position();
this.el.setY(a)
}},initTrigger:function(){this.trigger.on("click",this.onTriggerClick,this,{preventDefault:true});
this.trigger.addClassOnOver("x-form-trigger-over");
this.trigger.addClassOnClick("x-form-trigger-click")
},onDestroy:function(){if(this.trigger){this.trigger.removeAllListeners();
this.trigger.remove()
}if(this.wrap){this.wrap.remove()
}CQ.Ext.form.CustomTriggerField.superclass.onDestroy.call(this)
},onFocus:function(){CQ.Ext.form.CustomTriggerField.superclass.onFocus.call(this);
if(!this.mimicing){this.wrap.addClass("x-trigger-wrap-focus");
this.mimicing=true;
CQ.Ext.get(CQ.Ext.isIE?document.body:document).on("mousedown",this.mimicBlur,this,{delay:10});
if(this.monitorTab){this.el.on("keydown",this.checkTab,this)
}}},checkTab:function(a){if(a.getKey()==a.TAB){this.triggerBlur()
}},onBlur:function(){},mimicBlur:function(a){if(!this.wrap.contains(a.target)&&this.validateBlur(a)){this.triggerBlur()
}},triggerBlur:function(){this.mimicing=false;
CQ.Ext.get(CQ.Ext.isIE?document.body:document).un("mousedown",this.mimicBlur,this);
if(this.monitorTab){this.el.un("keydown",this.checkTab,this)
}this.beforeBlur();
this.wrap.removeClass("x-trigger-wrap-focus");
CQ.Ext.form.CustomTriggerField.superclass.onBlur.call(this)
},beforeBlur:CQ.Ext.emptyFn,validateBlur:function(a){return true
},onDisable:function(){CQ.Ext.form.CustomTriggerField.superclass.onDisable.call(this);
if(this.wrap){this.wrap.addClass(this.disabledClass);
this.el.removeClass(this.disabledClass)
}},onEnable:function(){CQ.Ext.form.CustomTriggerField.superclass.onEnable.call(this);
if(this.wrap){this.wrap.removeClass(this.disabledClass)
}},onShow:function(){if(this.wrap){this.wrap.dom.style.display="";
this.wrap.dom.style.visibility="visible"
}},onHide:function(){this.wrap.dom.style.display="none"
},onTriggerClick:CQ.Ext.emptyFn});
CQ.Ext.form.TwinCustomTriggerField=CQ.Ext.extend(CQ.Ext.form.CustomTriggerField,{initComponent:function(){CQ.Ext.form.TwinCustomTriggerField.superclass.initComponent.call(this);
this.triggerConfig={tag:"span",cls:"x-form-twin-triggers",cn:[{tag:"img",src:CQ.Ext.BLANK_IMAGE_URL,cls:"x-form-trigger "+this.trigger1Class},{tag:"img",src:CQ.Ext.BLANK_IMAGE_URL,cls:"x-form-trigger "+this.trigger2Class}]}
},getTrigger:function(a){return this.triggers[a]
},initTrigger:function(){var a=this.trigger.select(".x-form-trigger",true);
this.wrap.setStyle("overflow","hidden");
var b=this;
a.each(function(d,f,c){d.hide=function(){var g=b.wrap.getWidth();
this.dom.style.display="none";
b.el.setWidth(g-b.trigger.getWidth())
};
d.show=function(){var g=b.wrap.getWidth();
this.dom.style.display="";
b.el.setWidth(g-b.trigger.getWidth())
};
var e="Trigger"+(c+1);
if(this["hide"+e]){d.dom.style.display="none"
}d.on("click",this["on"+e+"Click"],this,{preventDefault:true});
d.addClassOnOver("x-form-trigger-over");
d.addClassOnClick("x-form-trigger-click")
},this);
this.triggers=a.elements
},onTrigger1Click:CQ.Ext.emptyFn,onTrigger2Click:CQ.Ext.emptyFn});
CQ.Ext.reg("customtrigger",CQ.Ext.form.CustomTriggerField);