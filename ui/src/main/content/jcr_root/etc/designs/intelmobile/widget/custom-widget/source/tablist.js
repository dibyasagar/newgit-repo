CQ.form.CustomMultiField=CQ.Ext.extend(CQ.form.CompositeField,{listItems:null,numberOfItems:null,name:null,constructor:function(b){var e=this;
this.nextParName=1;
if(!b.name){b.name="./numberofitems"
}this.name=b.name;
if(!b.value){b.value=0
}if(!b.listItems){b.listItems={}
}if(!b.listItems.xtype){b.listItems.xtype="customgenericlist"
}var a=new Array();
this.numberOfItems=new CQ.Ext.form.Hidden({name:b.name,value:b.value});
a.push(this.numberOfItems);
this.listItems=b.listItems;
if(b.readOnly){b.listItems.readOnly=true
}else{a.push({xtype:"button",text:"+",handler:function(){e.addItem()
}})
}for(var d=0;
d<this.listItems.length;
d++){if(this.listItems[d].autoDelete){a.push({xtype:"hidden",name:this.listItems[d].name+CQ.Sling.DELETE_SUFFIX})
}}b=CQ.Util.applyDefaults(b,{defaults:{xtype:"custommultifielditem",fieldConfig:b.listItems,listItems:b.listItems},items:[{xtype:"panel",border:false,bodyStyle:"padding:4px",items:a}]});
CQ.form.CustomMultiField.superclass.constructor.call(this,b);
if(this.defaults.listItems.regex){this.defaults.listItems.regex=b.fieldConfig.regex
}this.addEvents("change")
},addItem:function(d){var b=this.insert(this.items.getCount()-1,{});
this.findParentByType("form").getForm().add(b.field);
var e=this.findParentByType("form");
var a=e.getForm();
for(var f in e){}this.doLayout();
this.setNumberOfItems();
return b
},getNumberOfItems:function(){return this.items.getCount()-1
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
}}},getValue:function(){var a=new Array();
this.items.each(function(d,b){if(d instanceof CQ.form.MultiField.Item){a[b]=d.getValue();
b++
}},this);
return a
},setValue:function(a){this.fireEvent("change",this,a,this.getValue());
this.doLayout();
if((a!=null)&&(a!="")){this.addItem(a)
}}});
CQ.Ext.reg("custommultifield",CQ.form.CustomMultiField);
CQ.form.CustomMultiField.Item=CQ.Ext.extend(CQ.Ext.Panel,{constructor:function(b){var d=this;
this.field=CQ.Util.build(b.listItems,true);
var a=new Array();
a.push({xtype:"panel",border:false,items:this.field});
if(!b.fieldConfig.readOnly){a.push({xtype:"panel",border:false,items:{xtype:"button",text:"Up",handler:function(){var f=d.ownerCt;
var e=f.items.indexOf(d);
if(e>0){d.reorder(f.items.itemAt(e-1))
}}}});
a.push({xtype:"panel",border:false,items:{xtype:"button",text:"Down",handler:function(){var f=d.ownerCt;
var e=f.items.indexOf(d);
if(e<f.items.getCount()-1){d.reorder(f.items.itemAt(e+1))
}}}});
a.push({xtype:"panel",border:false,items:{xtype:"button",text:"-",handler:function(){var e=d.ownerCt.items.getCount()-1;
d.ownerCt.setNumberOfItems(d.ownerCt.getNumberOfItems()-1);
d.ownerCt.remove(d)
}}})
}b=CQ.Util.applyDefaults(b,{layout:"table",border:false,layoutConfig:{columns:4},defaults:{bodyStyle:"padding:20px"},items:a});
CQ.form.CustomMultiField.Item.superclass.constructor.call(this,b);
if(b.value){this.field.setValue(b.value)
}},reorder:function(a){var b=a.field.getValue();
a.field.setValue(this.field.getValue());
this.field.setValue(b)
},processRecord:function(a,b){this.field.processRecord(a,b)
},getValue:function(){return this.field.getValue()
},setValue:function(a){this.field.setValue(a)
},setParName:function(a){this.field.setParName(a)
}});
CQ.Ext.reg("custommultifielditem",CQ.form.CustomMultiField.Item);