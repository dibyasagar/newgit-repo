CQ.form.ImageMultiField=CQ.Ext.extend(CQ.form.CompositeField,{fieldConfig:null,test:null,numberOfItems:null,name:null,constructor:function(b){var e=this;
if(!b.name){b.name="./numberofitems"
}if(!b.value){b.value=0
}if(!b.fieldConfig){b.fieldConfig={}
}if(!b.fieldConfig.xtype){b.fieldConfig.xtype="customgenericlist"
}b.fieldConfig.name=b.name;
b.fieldConfig.style="width:95%;";
var a=new Array();
this.numberOfItems=new CQ.Ext.form.Hidden({name:b.name,value:b.value});
a.push(this.numberOfItems);
if(b.readOnly){b.fieldConfig.readOnly=true
}else{a.push({xtype:"button",cls:"cq-multifield-btn",text:"+",handler:function(){e.addItem()
}})
}this.name=b.name;
this.fieldConfig=b.fieldConfig;
for(var d=0;
d<this.fieldConfig.length;
d++){if(this.fieldConfig[d].autoDelete){a.push({xtype:"hidden",name:this.fieldConfig[d].name+CQ.Sling.DELETE_SUFFIX})
}}b=CQ.Util.applyDefaults(b,{defaults:{xtype:"imagemultifielditem",fieldConfig:b.fieldConfig},items:[{xtype:"panel",border:false,bodyStyle:"padding:4px",items:a}]});
CQ.form.ImageMultiField.superclass.constructor.call(this,b);
if(this.defaults.fieldConfig.regex){this.defaults.fieldConfig.regex=b.fieldConfig.regex
}this.addEvents("change")
},addItem:function(b){var a=this.insert(this.items.getCount()-1,{});
this.findParentByType("form").getForm().add(a.field);
this.doLayout();
if(b){a.setValue(b)
}if(a.field.isXType("trigger")){a.field.wrap.setWidth("95%")
}this.setNumberOfItems();
return a
},getValue:function(){var a=new Array();
this.items.each(function(d,b){if(d instanceof CQ.form.ImageMultiField.Item){a[b]=d.getValue();
b++
}},this);
return a
},setValue:function(b){this.fireEvent("change",this,b,this.getValue());
this.doLayout();
if((b!=null)&&(b!="")){if(b instanceof Array||CQ.Ext.isArray(b)){for(var a=0;
a<b.length;
a++){this.addItem(b[a])
}}else{this.addItem(b)
}}},getNumberOfItems:function(){return this.items.getCount()-1
},setNumberOfItems:function(a){if(!a){this.numberOfItems.setValue(this.getNumberOfItems())
}else{this.numberOfItems.setValue(a)
}},processRecord:function(a,h){var j=this.items;
var d=new Array();
j.each(function(i){if(i instanceof CQ.form.CustomMultiField.Item){this.remove(i,true);
this.findParentByType("form").getForm().remove(i)
}},this);
var f=a.get(this.name);
if(!f){f=0
}if(f==1){var g=this.addItem();
g.processRecord(a,h)
}else{for(var e=0;
e<f;
e++){var b=a.copy();
for(c in b.data){if(CQ.Ext.isArray(b.data[c])){b.data[c]=b.data[c][e]
}}var g=this.addItem();
g.processRecord(b,h)
}}}});
CQ.Ext.reg("imagemultifield",CQ.form.ImageMultiField);
CQ.form.ImageMultiField.Item=CQ.Ext.extend(CQ.Ext.Panel,{constructor:function(b){var d=this;
this.field=CQ.Util.build(b.fieldConfig,true);
var a=new Array();
a.push({xtype:"panel",border:false,cellCls:"cq-multifield-itemct",items:d.field});
if(!b.fieldConfig.readOnly){a.push({xtype:"panel",border:false,items:{xtype:"button",text:"Up",handler:function(){var f=d.ownerCt;
var e=f.items.indexOf(d);
if(e>0){d.reorder(f.items.itemAt(e-1))
}}}});
a.push({xtype:"panel",border:false,items:{xtype:"button",text:"Down",handler:function(){var f=d.ownerCt;
var e=f.items.indexOf(d);
if(e<f.items.getCount()-1){d.reorder(f.items.itemAt(e+1))
}}}});
a.push({xtype:"panel",border:false,items:{xtype:"button",cls:"cq-multifield-btn",text:"-",handler:function(){d.ownerCt.remove(d)
}}})
}b=CQ.Util.applyDefaults(b,{layout:"table",anchor:"100%",border:false,layoutConfig:{columns:4},defaults:{bodyStyle:"padding:3px"},items:a});
CQ.form.ImageMultiField.Item.superclass.constructor.call(this,b);
if(b.value){this.field.setValue(b.value)
}},reorder:function(a){var b=a.field.getValue();
a.field.setValue(this.field.getValue());
this.field.setValue(b)
},getValue:function(){return this.field.getValue()
},setValue:function(a){this.field.setValue(a)
},processRecord:function(a,b){this.field.processRecord(a,b)
}});
CQ.Ext.reg("imagemultifielditem",CQ.form.ImageMultiField.Item);